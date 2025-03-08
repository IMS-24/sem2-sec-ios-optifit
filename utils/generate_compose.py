#!/usr/bin/env python3
import os
import sys
import json
import argparse
from collections import OrderedDict, defaultdict

def debug(message):
    print(f"[*]: {message}")

def info(message):
    print(f"[+]: {message}")

def warn(message):
    print(f"[!]: {message}")

def error(message):
    print(f"[-]: {message}")

def flatten_json(y, parent_key='', sep='__'):
    """
    Flatten a nested JSON/dictionary.
    For arrays, joins values by comma.
    Also replaces any '.' in the generated keys with '_'.
    """
    items = []
    for k, v in y.items():
        new_key = f"{parent_key}{sep}{k}" if parent_key else k
        # Replace any '.' with '_' in the key.
        new_key = new_key.replace('.', '_')
        if isinstance(v, dict):
            items.extend(flatten_json(v, new_key, sep=sep).items())
        elif isinstance(v, list):
            items.append((new_key, ",".join(str(i) for i in v)))
        else:
            items.append((new_key, v))
    return dict(items)

def write_env_file(env_vars, filename=".env"):
    info(f"Writing .env file to '{filename}'")
    # Group keys by section.
    groups = defaultdict(list)
    for key, value in env_vars.items():
        # If key contains '__', group by the prefix; otherwise, assign to MISC.
        if "__" in key:
            section = key.split("__")[0]
        else:
            if key == "CONNECTION_STRING":
                section = "CONNECTIONSTRINGS"
            else:
                section = "MISC"
        groups[section].append((key, value))
    
    # Sort sections alphabetically (with MISC at the end).
    sections = sorted([s for s in groups if s != "MISC"]) + (["MISC"] if "MISC" in groups else [])
    
    with open(filename, "w") as f:
        f.write("# Generated .env file\n\n")
        for section in sections:
            f.write(f"# ----- {section} -----\n")
            for key, value in sorted(groups[section]):
                val = str(value)
                # Enclose in quotes if it contains spaces.
                if " " in val and not (val.startswith('"') and val.endswith('"')):
                    val = f'"{val}"'
                f.write(f"{key}={val}\n")
            f.write("\n")

def write_compose_file(env_vars, filename="compose.yml"):
    info(f"Writing compose file to '{filename}'")
    # Generate a docker-compose file with $ escapes for variable interpolation.
    compose_content = f"""
services:
  backend:
    container_name: qb8s.net.${{PROJECT_NAME}}
    image: ${{PRIVATE_REGISTRY_URL}}/${{PROJECT_NAME}}:latest
    ports:
      - "${{API_PORT}}:8080"
    environment:
      - ASPNETCORE_ENVIRONMENT=Production
      - ConnectionStrings__DefaultConnection=${{CONNECTION_STRING}}
"""
    # Append all flattened appsettings keys (except CONNECTION_STRING) as environment variables.
    for key in sorted(env_vars.keys()):
        if "__" in key and key != "CONNECTION_STRING":
            compose_content += f"      - {key}=${{{key}}}\n"

    compose_content += f"""    depends_on:
      - db

  db:
    container_name: qb8s.net.${{PROJECT_NAME}}-postgres
    image: postgres
    restart: always
    environment:
      POSTGRES_PASSWORD: ${{DB_PASSWORD}}
      POSTGRES_USER: ${{DB_USER}}
      POSTGRES_DB: ${{DB_NAME}}
    ports:
      - "${{DB_PORT}}:5432"
    volumes:
      - db-data:/var/lib/postgresql/data
      - ./database/init:/docker-entrypoint-initdb.d/
  
  pgadmin:
    image: dpage/pgadmin4
    container_name: qb8s.net.${{PROJECT_NAME}}-pgadmin
    restart: always
    ports:
      - "8888:80"
    env_file: .env
    volumes:
      - pg-admin-data:/var/lib/pgadmin
    depends_on:
      - db

volumes:
  db-data: null
  pg-admin-data: null
"""
    with open(filename, "w") as f:
        f.write(compose_content)

def parse_connection_string(conn_str):
    """
    Parse a semicolon-delimited connection string into a dictionary.
    Example:
    "Server=...;Port=9966;Database=optifit;User Id=ronniecoleman;Password=hiTSd3YiNovVXJkUHdzY9NKV2mpRvPff;"
    """
    result = {}
    parts = conn_str.strip().strip(';').split(';')
    for part in parts:
        if '=' in part:
            key, value = part.split('=', 1)
            result[key.strip().lower()] = value.strip()
    return result

def main():
    parser = argparse.ArgumentParser(
        description="Generate a .env file and a docker-compose file from an appsettings JSON file."
    )
    parser.add_argument("appsettings", help="Path to the appsettings JSON file.")
    parser.add_argument("--env-out", default=".env", help="Output file for the .env file (default: .env)")
    parser.add_argument("--compose-out", default="compose.yml", help="Output file for the compose file (default: compose.yml)")
    args = parser.parse_args()

    if not os.path.exists(args.appsettings):
        error(f"Appsettings file '{args.appsettings}' does not exist.")
        sys.exit(1)
    try:
        with open(args.appsettings, "r") as f:
            appsettings_data = json.load(f, object_pairs_hook=OrderedDict)
    except Exception as e:
        error(f"Failed to parse JSON from '{args.appsettings}': {e}")
        sys.exit(1)

    flattened = flatten_json(appsettings_data)
    debug(f"Flattened appsettings: {flattened}")

    env_vars = {
        "PROJECT_NAME": "optifit",
        "API_PORT": "9764",
        "PRIVATE_REGISTRY_URL": "your.registry.url"
    }

    if "ConnectionStrings__DefaultConnection" in flattened:
        env_vars["CONNECTION_STRING"] = flattened["ConnectionStrings__DefaultConnection"]
    else:
        warn("No ConnectionStrings__DefaultConnection found in appsettings.")
        env_vars["CONNECTION_STRING"] = "<< xxxxx >>"

    if env_vars["CONNECTION_STRING"] != "<< xxxxx >>":
        conn_details = parse_connection_string(env_vars["CONNECTION_STRING"])
        env_vars["DB_PASSWORD"] = conn_details.get("password", "<< xxxxx >>")
        env_vars["DB_USER"] = conn_details.get("user id", "<< xxxxx >>")
        env_vars["DB_NAME"] = conn_details.get("database", "<< xxxxx >>")
        env_vars["DB_PORT"] = conn_details.get("port", "<< xxxxx >>")
    else:
        env_vars["DB_PASSWORD"] = "<< xxxxx >>"
        env_vars["DB_USER"] = "<< xxxxx >>"
        env_vars["DB_NAME"] = "<< xxxxx >>"
        env_vars["DB_PORT"] = "<< xxxxx >>"

    for key, value in flattened.items():
        env_vars[key.upper()] = value

    write_env_file(env_vars, args.env_out)
    info(f".env file generated with {len(env_vars)} entries.")
    write_compose_file(env_vars, args.compose_out)
    info("docker-compose file generated.")

if __name__ == "__main__":
    main()

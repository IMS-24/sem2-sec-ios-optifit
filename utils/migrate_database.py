#!/usr/bin/env python3

import os
import sys
import json
import argparse
import subprocess
import glob

def debug(message):
    print(f"[*]: {message}")

def info(message):
    print(f"[+]: {message}")

def warn(message):
    print(f"[!]: {message}")

def error(message):
    print(f"[-]: {message}")

def get_confirmation(prompt, count=1):
    """Prompt the user for confirmation 'count' times."""
    for _ in range(count):
        answer = input(prompt).strip().lower()
        if answer != 'y':
            error("Operation aborted by user.")
            sys.exit(1)

def load_connection_string(file_path):
    """Read the JSON settings file and return the connection string from ConnectionStrings -> DefaultConnection."""
    try:
        with open(file_path, "r") as f:
            debug(f"Loading JSON file: {file_path}")
            data = json.load(f)
    except Exception as e:
        error(f"Error reading JSON file '{file_path}': {e}")
        sys.exit(1)

    try:
        connection_string = data["ConnectionStrings"]["DefaultConnection"]
        return connection_string
    except KeyError:
        error("Error: 'ConnectionStrings' or 'DefaultConnection' not found in the JSON file.")
        sys.exit(1)

def resolve_project_path(path):
    """
    Resolve a project file path.
    If 'path' is a directory, look for a single .csproj file inside it.
    If found, return its absolute path. If not, exit with an error.
    If 'path' is a file, ensure it ends with '.csproj' and return its absolute path.
    """
    abs_path = os.path.abspath(path)
    debug(f"Resolving project path for: {abs_path}")
    if os.path.isdir(abs_path):
        csproj_files = glob.glob(os.path.join(abs_path, "*.csproj"))
        if len(csproj_files) == 0:
            error(f"No .csproj file found in directory '{abs_path}'.")
            sys.exit(1)
        elif len(csproj_files) > 1:
            error(f"Multiple .csproj files found in directory '{abs_path}'. Please specify the project file explicitly.")
            sys.exit(1)
        resolved = os.path.abspath(csproj_files[0])
        debug(f"Found .csproj file: {resolved}")
        return resolved
    else:
        if abs_path.endswith(".csproj"):
            debug(f"Using provided project file: {abs_path}")
            return abs_path
        else:
            error(f"File '{abs_path}' is not a .csproj file.")
            sys.exit(1)

def main():
    # Set up command line argument parsing.
    parser = argparse.ArgumentParser(
        description="Run EF Core commands (update, migrations add, migrations remove) using connection strings from appsettings JSON files."
    )
    parser.add_argument(
        "appsettingsProject",
        help="Path to the project file (or directory containing a single .csproj) that contains the appsettings JSON file."
    )
    parser.add_argument(
        "dbcontextProject",
        help="Path to the project file (or directory containing a single .csproj) that contains the DbContext."
    )
    parser.add_argument(
        "environment",
        nargs="?",
        default="local",
        choices=["dev", "local", "prod"],
        help="Environment to run the command (dev, local, prod). Default is local."
    )
    parser.add_argument(
        "command",
        nargs="?",
        default="update",
        choices=["update", "add", "remove"],
        help="EF Core command to run: 'update', 'add', or 'remove'. Default is 'update'."
    )
    parser.add_argument(
        "migrationName",
        nargs="?",
        help="Name of the migration (required when command is 'add')."
    )
    args = parser.parse_args()

    # Validate migration name if needed.
    if args.command == "add" and not args.migrationName:
        error("When using 'add', a migration name must be provided.")
        sys.exit(1)

    # Resolve project paths.
    appsettings_proj = resolve_project_path(args.appsettingsProject)
    dbcontext_proj = resolve_project_path(args.dbcontextProject)

    env = args.environment
    if env == "dev":
        settings_file = "appsettings.Development.json"
    elif env == "local":
        settings_file = "appsettings.local.json"
    elif env == "prod":
        settings_file = "appsettings.production.json"
    else:
        error(f"Unknown environment: {env}")
        sys.exit(1)

    # The appsettings JSON file should be located in the same directory as the appsettings project.
    settings_dir = os.path.dirname(appsettings_proj)
    settings_path = os.path.join(settings_dir, settings_file)
    info(f"Using settings file: {settings_path}")
    if not os.path.exists(settings_path):
        error(f"File '{settings_path}' does not exist.")
        sys.exit(1)

    # Extract the connection string.
    connection_string = load_connection_string(settings_path)

    # Confirmation logic.
    if env == "dev":
        get_confirmation("You are about to update the DEV database. Proceed? (y/N): ", count=1)
    elif env == "prod":
        get_confirmation("WARNING: You are about to update the PROD database. Proceed? (y/N): ", count=1)
        get_confirmation("Please confirm again to proceed with the PROD update. (y/N): ", count=1)

    info(f"Using connection string for '{env}' environment.")

    # Pass the connection string as an environment variable.
    new_env = os.environ.copy()
    new_env["ConnectionStrings__DefaultConnection"] = connection_string

    # Build the dotnet EF command.
    command_list = ["dotnet", "ef"]
    if args.command == "update":
        command_list.extend(["database", "update"])
    elif args.command == "add":
        command_list.extend(["migrations", "add", args.migrationName])
    elif args.command == "remove":
        command_list.extend(["migrations", "remove"])
    else:
        error(f"Unsupported command: {args.command}")
        sys.exit(1)

    # Add the project parameter (for the DbContext).
    command_list.extend(["--project", dbcontext_proj])
    # If needed, you can also add the startup project (the one with appsettings) with:
    # command_list.extend(["--startup-project", appsettings_proj])

    info(f"Running command: {' '.join(command_list)}")
    debug(f"Using DB Context project: {dbcontext_proj}")
    debug(f"Using AppSettings project: {appsettings_proj}")

    try:
        subprocess.run(
            command_list,
            check=True,
            env=new_env
        )
    except subprocess.CalledProcessError as e:
        error("Database command failed.")
        sys.exit(e.returncode)

if __name__ == "__main__":
    main()

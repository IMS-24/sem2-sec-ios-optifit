# OptiFit

OptiFit is a full-featured application designed to deliver an optimal user experience by leveraging a modern tech stack.
The application consists of a robust backend built on ASP.NET Core using Clean Architecture principles, and multiple
frontends including an Angular web application (currently in the design phase) and a native iOS application built with
SwiftUI.

---

## Table of Contents

- [Overview](#overview)
- [Backend](#backend)
    - [Technology Stack](#technology-stack)
    - [Configuration](#configuration)
    - [Database](#database)
    - [Utilities](#utilities)
- [Frontends](#frontends)
    - [Angular](#angular)
    - [iOS (SwiftUI)](#ios-swiftui)
- [Authentication](#authentication)
- [Deployment](#deployment)
- [Conclusion](#conclusion)

---

## Overview

OptiFit is built to be scalable, secure, and easy to maintain. The backend offers comprehensive RESTful API capabilities
with integrated Swagger documentation for testing and exploration. Authentication is implemented via Azure AD B2C to
ensure secure and seamless user access. The solution is containerized with Docker Compose for easy deployment and
integrates scripts for database migration and seeding.

---

## Backend

### Technology Stack

- **Framework:** ASP.NET Core
- **Architecture:** Clean Architecture
- **API Documentation:** Swagger
- **Authentication:** Azure AD B2C

### Configuration

The backend uses an `appsettings.json` file to manage its configuration. Below is an example configuration:

```json
{
  "AzureAdB2C": {
    "Instance": "https://<domain>.b2clogin.com/",
    "ClientId": "xxx-yyy-zzz",
    "Domain": "<domain>.onmicrosoft.com",
    "Scopes": "openid offline_access optifit-api",
    "TenantId": "xxx-yyy-zzz",
    "SignUpSignInPolicyId": "B2C_1_SuSi"
  },
  "ConnectionStrings": {
    "DefaultConnection": "Server=<host>;Port=<port>;Database=<database>;User Id=<user_id>;Password=<password>;"
  },
  "Swagger": {
    "ClientId": "xxx-yyy-zzz",
    "ApplicationName": "swagger",
    "Scopes": [
      "https://<domain>.onmicrosoft.com/<xxx-yyy-zzz>/Api.Access.Full",
      "offline_access",
      "openid"
    ]
  },
  "Logging": {
    "LogLevel": {
      "Default": "Debug",
      "Microsoft.AspNetCore": "Debug",
      "Microsoft.EntityFrameworkCore.Database.Command": "Information",
      "Microsoft.EntityFrameworkCore": "Information"
    }
  }
}
```

### Database

The backend uses a PostgreSQL database. The environment settings are managed via a `.env` file for Docker Compose. Below
is an example:

```dotenv
# Environment used for Docker Compose File

# App
PROJECT_NAME=optifit
API_PORT=9764

## Database Configuration
CONNECTION_STRING="Server=<host>;Port=<port>;Database=<database>>;User Id=<user_id>;Password=<password>"

PRIVATE_REGISTRY_URL=docker-registry.mstoegerer.net
REGISTRY_USERNAME=<registry_username>
REGISTRY_PASSWORD=<registry_password>

# PGAdmin
PGADMIN_DEFAULT_EMAIL=<pgadmin_email>
PGADMIN_DEFAULT_PASSWORD=<pgadmin_password>

# Database
DB_PASSWORD=<db_password>
DB_NAME=<db_name>
DB_USER=<db_user>
DB_PORT=<db_port>
DB_HOST=local-postgres-db
DB_SCHEMA=<db_schema>>
MIGRATION_USER=<db_migration_user>
MIGRATION_PASSWORD=<db_migration_password>
```

### Utilities

Within the `utils` folder, you'll find scripts for:

- **Database Migration:**  
  Scripts that migrate the database using either settings from `appsettings.json` or environment variables.
- **Database Seeding:**  
  Scripts to seed the PostgreSQL database with initial data.

---

## Frontends

### Angular

The Angular frontend is currently in the design phase. More details and implementation instructions will be added as the
project evolves.

### iOS (SwiftUI)

The iOS application is built natively with SwiftUI and supports multiple environments. Configuration is managed through
multiple xcconfig files, such as `Staging.xcconfig`, `Production.xcconfig`, and `Testing.xcconfig`.

Example configuration from `Testing.xcconfig`:

```xcconfig
// Configuration settings file format documentation can be found at:
// https://help.apple.com/xcode/#/dev745c5c974


// Custom values of plist
APP_NAME = OptiFit - $(ENVIRONMENT)
API_BASE_URL = 192.168.0.62:5154 // without http:// since "//" are treated as comment
B2C_CLIENT_ID = //GUID
B2C_POLICY = b2c_1_susi
B2C_AUTHORITY = //domain.b2clogin.com
B2C_SCOPES =  // https://$(B2C_TENANT)/<GUID>/<NAME>
B2C_TENANT =  //domain.onmicrosoft.com

// Build Information
GIT_HASH = <GIT_HASH> // Replaced by build script
FULL_SEMVER = <FULL_SEMVER> // Replaced by build script
GIT_BRANCH = <GIT_BRANCH> // Replaced by build script

// Local variable
ENVIRONMENT = Testing

// Predefined build settings
// Refer <https://developer.apple.com/documentation/xcode/build-settings-reference>
INFOPLIST_KEY_CFBundleDisplayName = OptiFit - $(ENVIRONMENT)
INFOPLIST_FILE = $(PRODUCT_NAME)/PLIST/$(ENVIRONMENT).plist
PRODUCT_BUNDLE_IDENTIFIER = net.qb8s.OptiFit.$(ENVIRONMENT)
ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon_${ENVIRONMENT}
MARKETING_VERSION = 1.2.0
CURRENT_PROJECT_VERSION = 20
```

---

## Authentication

Authentication is handled using Azure AD B2C. The backend configuration for Azure AD B2C is defined in the
`appsettings.json` file as follows:

```json
"AzureAdB2C": {
  "Instance": "https://<domain>.b2clogin.com/",
  "ClientId": "xxx-yyy-zzz",
  "Domain": "<domain>.onmicrosoft.com",
  "Scopes": "openid offline_access optifit-api",
  "TenantId": "xxx-yyy-zzz",
  "SignUpSignInPolicyId": "B2C_1_SuSi"
}
```

Ensure that you have configured your Azure AD B2C tenant and registered the application appropriately to enable secure
authentication.

---

## Deployment

### Docker Compose

A Docker Compose file is available to orchestrate the deployment of the PostgreSQL database and other necessary
services. Ensure your environment variables in the `.env` file are set correctly before deploying.

### Running the Backend

1. **Configure:** Update the `appsettings.json` file with the correct configuration values.
2. **Build & Run:** Build and run the ASP.NET Core backend.
3. **Swagger UI:** Access the Swagger UI at `/swagger` to explore and test the API.

### Running the Frontends

- **Angular:** Follow the project instructions for the Angular application once development progresses past the design
  phase.
- **iOS:** Open the Xcode project, select the appropriate environment configuration (`Staging`, `Production`, or
  `Testing` via the xcconfig files), and build the application.

---

## Conclusion

OptiFit is built on modern technology to ensure scalability, security, and maintainability. Its Clean Architecture
approach on the backend, coupled with flexible frontends, makes it a robust solution for today's application needs.
Contributions and improvements are always welcome—please refer to the repository guidelines for more details.

---

*This documentation is part of the OptiFit project and is subject to updates as the project evolves.*
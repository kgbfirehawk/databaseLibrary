# Library Management System

This project is a **Library Management System** that allows librarians to manage multiple libraries within a district. It keeps track of information about books, staff members, patrons, and checkouts.

---

## Table of Contents

1. [Project Structure](#project-structure)  
2. [Setup Instructions](#setup-instructions)  
   - [Prerequisites](#prerequisites)  
   - [Clone the Repository](#step-1-clone-the-repository)  
   - [Install Dependencies](#step-2-install-dependencies)  
   - [Set Up the Database](#step-3-set-up-the-database)  
   - [Configure the Database Connector](#step-4-configure-the-database-connector)  
   - [Start the Server](#step-5-start-the-server)  
   - [Access the Application](#step-6-access-the-application)  
3. [Project Files](#project-files)

## Setup Instructions

### Prerequisites

Ensure you have the following installed on your system:

- **Node.js** (v14 or higher)  
- **MySQL server**

---

### Step 1: Clone the Repository

Clone the repository and navigate to the project folder:

```bash
git clone <repository-url>
cd databaseLibProject
```


### Step 2: Install Dependencies

Navigate to the `librarydb` directory and install the required Node.js dependencies:

```bash
cd librarydb
npm install
```

### Step 3: Set Up the Database
Ensure your MySQL server is running.  
Create the necessary database and tables by executing the SQL scripts located in the `BaseSQL` and `database` directories. You can use a MySQL client or the command line to run these scripts:
```bash
mysql -u <username> -p <database_name> < BaseSQL/DDL.sql
mysql -u <username> -p <database_name> < BaseSQL/DML.sql
```

### Step 4: Configure the Database Connector
Create a .env file in the librarydb directory with your database connection details:
```
DB_CONNECTION_LIMIT=10
DB_HOST=your-database-host
DB_USER=your-database-username
DB_PASSWORD=your-database-password
DB_DATABASE=your-database-name
```

### Step 5: Start the Server
Start the Express server by running the following command in the librarydb directory:
```
node app.js
```

### Step 6: Access the Application
Open your web browser and navigate to http://localhost:8728 to access the application.

### Project Files
```
BaseSQL/: Contains SQL scripts for setting up the database schema and initial data.
   DDL.sql: Data Definition Language script to create tables.
   DML.sql: Data Manipulation Language script to insert initial data.
   introDatabase.sql: Another script for setting up the database schema.
HTML/: Contains static HTML files for the application.
librarydb/: Main directory for the Node.js application.
.env: Environment variables for database connection.
app.js: Main application file to set up and start the Express server.
   database/: Contains database-related files.
      db-connector.js: Database connector file to manage MySQL connections.
   routes/: Contains route handlers for different parts of the application.
      booksRoutes.js: Routes for managing books.
      booksBorrowersRoutes.js: Routes for managing book-borrower relationships.
      borrowersRoutes.js: Routes for managing borrowers.
      checkoutsRoutes.js: Routes for managing checkouts.
      librariesRoutes.js: Routes for managing libraries.
      staffRoutes.js: Routes for managing staff.
   views/: Contains Handlebars templates for rendering HTML.
      books.hbs: Template for displaying books.
      booksBorrowers.hbs: Template for displaying book-borrower relationships.
      borrowers.hbs: Template for displaying borrowers.
      checkouts.hbs: Template for displaying checkouts.
      index.hbs: Template for the home page.
      libraries.hbs: Template for displaying libraries.
      staff.hbs: Template for displaying staff.
      layouts/: Contains the main layout template.
         main.hbs: Main layout template.
   public/: Contains public static files like HTML and CSS.
      styles.css: Static CSS.
```
---

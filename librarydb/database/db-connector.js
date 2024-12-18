/* Citation for the following function:
Date: 11/21/2024
Adapted from CS 340: nodejs-starter-app (db-connector.js)
Majority of the code was copied from the sample code given, and modified based on individual project tables. 
Source URL: https://github.com/osu-cs340-ecampus/nodejs-starter-app/tree/main/Step%200%20-%20Setting%20Up%20Node.js
*/

require('dotenv').config({ path: '../.env' }); // Load environment variables from .env file

// Get an instance of mysql we can use in the app
var mysql = require('mysql')

// Create a 'connection pool' using the provided credentials
var pool = mysql.createPool({
    connectionLimit : process.env.DB_CONNECTION_LIMIT,
    host            : process.env.DB_HOST,
    user            : process.env.DB_USER,
    password        : process.env.DB_PASSWORD,
    database        : process.env.DB_DATABASE
})

// Export it for use in our application
module.exports.pool = pool;

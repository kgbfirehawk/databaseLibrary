 /* Citation for the following function:
Date: 11/21/2024
Adapted from CS 340: nodejs-starter-app (db-connector.js)
Majority of the code was copied from the sample code given, and modified based on individual project tables. 
Source URL: https://github.com/osu-cs340-ecampus/nodejs-starter-app/tree/main/Step%200%20-%20Setting%20Up%20Node.js
*/


// Get an instance of mysql we can use in the app
var mysql = require('mysql')

// Create a 'connection pool' using the provided credentials
var pool = mysql.createPool({
    connectionLimit : 10,
    host            : 'classmysql.engr.oregonstate.edu',
    user            : 'cs340_jackmack',
    password        : '3577',
    database        : 'cs340_jackmack'
})

// Export it for use in our application
module.exports.pool = pool;

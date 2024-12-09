 /* Citation for the following function:
Date: 11/21/2024
Adapted from CS 340: nodejs-starter-app (app.js)
Majority of the code was copied from the sample code given, and modified based on individual project tables. 
Source URL: https://github.com/osu-cs340-ecampus/nodejs-starter-app/tree/main/Step%200%20-%20Setting%20Up%20Node.js
*/

const express = require('express');
const router = express.Router();
const db = require('../database/db-connector');

// GET route for the libraries page
router.get('/libraries', function(req, res) {
    let queryLibraries = "SELECT * FROM Libraries;";  // SQL query to get all libraries

    db.pool.query(queryLibraries, function(error, libraryRows, fields) {
        if (error) {
            console.error(error);
            res.sendStatus(500); 
        } else {
            res.render('libraries', {
                data: libraryRows
            });
        }
    });
});

// POST route for adding a new library
router.post('/libraries/add', function(req, res) {
    let data = req.body;

    let query = `INSERT INTO Libraries (libraryName, libraryAddress, contactNumber) VALUES (?, ?, ?)`;
    let inserts = [data.name, data.address, data.contact];

    db.pool.query(query, inserts, function(error, rows, fields) {
        if (error) {
            console.error(error);
            res.sendStatus(500); 
        } else {
            res.redirect('/libraries');  // Redirect back to /libraries after adding a new library
        }
    });
});

// POST route for updating a library
router.post('/libraries/update/:libraryID', function(req, res) {
    let libraryID = req.params.libraryID;
    let data = req.body;

    let query = `UPDATE Libraries SET libraryName = ?, libraryAddress = ?, contactNumber = ? WHERE libraryID = ?`;
    let inserts = [data.name, data.address, data.contact, libraryID];

    db.pool.query(query, inserts, function(error, rows, fields) {
        if (error) {
            console.error(error);
            res.sendStatus(500); 
        } else {
            res.redirect('/libraries');  // Redirect back to /libraries after updating the library
        }
    });
});

// POST route for deleting a library
router.post('/libraries/delete/:libraryID', function(req, res) {
    let libraryID = req.params.libraryID;

    let query = `DELETE FROM Libraries WHERE libraryID = ?`;
    let inserts = [libraryID];

    db.pool.query(query, inserts, function(error, rows, fields) {
        if (error) {
            console.error(error);
            res.sendStatus(500); 
        } else {
            res.redirect('/libraries');  // Redirect back to /libraries after deleting the library
        }
    });
});

module.exports = router;
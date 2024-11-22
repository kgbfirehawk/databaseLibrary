 /* Citation for the following function:
Date: 11/21/2024
Adapted from CS 340: nodejs-starter-app (app.js)
Majority of the code was copied from the sample code given, and modified based on individual project tables. 
Source URL: https://github.com/osu-cs340-ecampus/nodejs-starter-app/tree/main/Step%200%20-%20Setting%20Up%20Node.js
*/


const express = require('express');
const router = express.Router();
const db = require('../database/db-connector');  

// GET route for the main /staff page
router.get('/staff', function(req, res) {
    let queryStaff = "SELECT * FROM Staff;";  // SQL query to get all staff members
    let queryLibraries = "SELECT * FROM Libraries;";  // SQL query to get all libraries

    db.pool.query(queryStaff, function(error, staffRows, fields) {
        if (error) {
            console.error(error);
            res.sendStatus(500); 
        } else {
            db.pool.query(queryLibraries, function(libError, libraryRows, fields) {
                if (libError) {
                    console.error(libError);
                    res.sendStatus(500);  
                } else {
                    res.render('staff', {
                        data: staffRows,
                        libraries: libraryRows
                    });
                }
            });
        }
    });
});

// GET route for editing a staff member
router.get('/staff/update/:staffID', function(req, res) {
    let staffID = req.params.staffID;

    let queryStaff = `SELECT * FROM Staff WHERE staffID = ?;`;
    let queryLibraries = "SELECT * FROM Libraries;";

    db.pool.query(queryStaff, [staffID], function(error, staffRows, fields) {
        if (error) {
            console.error(error);
            res.sendStatus(500);
        } else {
            db.pool.query(queryLibraries, function(libError, libraryRows, fields) {
                if (libError) {
                    console.error(libError);
                    res.sendStatus(500);
                } else {
                    res.render('staff', {
                        data: staffRows,
                        libraries: libraryRows,
                        editData: staffRows[0]  // Send the selected staff data for editing
                    });
                }
            });
        }
    });
});

// POST route for adding a new staff member
router.post('/staff/add', function(req, res) {
    let data = req.body;

    let query = `INSERT INTO Staff (staffName, staffTitle, staffExtension, librariesLibraryID) VALUES (?, ?, ?, ?)`;
    let inserts = [data.staffName, data.staffTitle, data.staffExtension, data.librariesLibraryID];

    db.pool.query(query, inserts, function(error, rows, fields) {
        if (error) {
            console.error(error);
            res.sendStatus(500); 
        } else {
            res.redirect('/staff');  // Redirect back to /staff after adding a staff member
        }
    });
});

// POST route for deleting a staff member
router.post('/staff/delete/:staffID', function(req, res) {
    let staffID = req.params.staffID;

    let query = `DELETE FROM Staff WHERE staffID = ?`;
    let inserts = [staffID];

    db.pool.query(query, inserts, function(error, rows, fields) {
        if (error) {
            console.error(error);
            if (error.errno === 1451) {
                res.send("Cannot delete staff member. This staff member is referenced in other records."); // Handle FK constraint error
            } else {
                res.sendStatus(500);  
            }
        } else {
            res.redirect('/staff');  // Redirect back to /staff after deleting
        }
    });
});

// POST route for updating a staff member
router.post('/staff/update/:staffID', function(req, res) {
    let staffID = req.params.staffID;
    let data = req.body;

    let query = `UPDATE Staff SET staffName = ?, staffTitle = ?, staffExtension = ?, librariesLibraryID = ? WHERE staffID = ?`;
    let inserts = [data.staffName, data.staffTitle, data.staffExtension, data.librariesLibraryID, staffID];

    db.pool.query(query, inserts, function(error, rows, fields) {
        if (error) {
            console.error(error);
            res.sendStatus(500);  
        } else {
            res.redirect('/staff');  // Redirect back to /staff after updating
        }
    });
});

module.exports = router;

 /* Citation for the following function:
Date: 11/21/2024
Adapted from CS 340: nodejs-starter-app (app.js)
Majority of the code was copied from the sample code given, and modified based on individual project tables. 
Source URL: https://github.com/osu-cs340-ecampus/nodejs-starter-app/tree/main/Step%200%20-%20Setting%20Up%20Node.js
*/

const express = require('express');
const router = express.Router();
const db = require('../database/db-connector');  

// GET route for the borrowers page
router.get('/borrowers', function(req, res) {
  let queryBorrowers = "SELECT * FROM Borrowers;";  // SQL query to get all staff members
  let queryLibraries = "SELECT * FROM Libraries;";  // SQL query to get all libraries

  db.pool.query(queryBorrowers, function(error, borrowersRows, fields) {
      if (error) {
          console.error(error);
          res.sendStatus(500); 
      } else {
          db.pool.query(queryLibraries, function(libError, libraryRows, fields) {
              if (libError) {
                  console.error(libError);
                  res.sendStatus(500);  
              } else {
                  res.render('borrowers', {
                      data: borrowersRows,
                      libraries: libraryRows
                  });
              }
          });
      }
  });
});


// POST route for adding a new book
router.post('/borrowers/add', function(req, res) {
    let data = req.body;

    let query = `INSERT INTO Borrowers (userName, userAddress, userPhone) VALUES (?, ?, ?)`;
    let inserts = [data.userName, data.userAddress, data.userPhone,];

    db.pool.query(query, inserts, function(error, rows, fields) {
        if (error) {
            console.error(error);
            res.sendStatus(500); 
        } else {
            res.redirect('/borrowers');  // Redirect back to /borrowers after adding a new patron
        }
    });
});
module.exports = router;
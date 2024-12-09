 /* Citation for the following function:
Date: 11/21/2024
Adapted from CS 340: nodejs-starter-app (app.js)
Majority of the code was copied from the sample code given, and modified based on individual project tables. 
Source URL: https://github.com/osu-cs340-ecampus/nodejs-starter-app/tree/main/Step%200%20-%20Setting%20Up%20Node.js
*/

const express = require('express');
const router = express.Router();
const db = require('../database/db-connector');  

// GET route for the books page
router.get('/books', function(req, res) {
    let queryBooks = `SELECT Books.bookID, Books.bookTitle, Books.bookAuthor, Books.bookGenre, Libraries.libraryName 
                  FROM Books 
                  JOIN Libraries ON Books.librariesLibraryID = Libraries.libraryID`;

    let queryLibraries = `SELECT * FROM Libraries`;

    db.pool.query(queryBooks, function(bookError, bookRows, bookFields) {
        if (bookError) {
            console.error(bookError);
            res.sendStatus(500);
        } else {
            db.pool.query(queryLibraries, function(libError, libraryRows, libFields) {
                if (libError) {
                    console.error(libError);
                    res.sendStatus(500);  
                } else {
                    res.render('books', {
                        data: bookRows,
                        libraries: libraryRows
                    });
                }
            });
        }
    });
});


// POST route for adding a new book
router.post('/books/add', function(req, res) {
    let data = req.body;

    let query = `INSERT INTO Books (bookTitle, bookAuthor, bookGenre, librariesLibraryID) VALUES (?, ?, ?, ?)`;
    let inserts = [data.bookTitle, data.bookAuthor, data.bookGenre, data.librariesLibraryID];

    db.pool.query(query, inserts, function(error, rows, fields) {
        if (error) {
            console.error(error);
            res.sendStatus(500); 
        } else {
            res.redirect('/books');  // Redirect back to /books after adding a new book
        }
    });
});





module.exports = router;
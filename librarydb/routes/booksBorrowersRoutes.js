 /* Citation for the following function:
Date: 11/21/2024
Adapted from CS 340: nodejs-starter-app (app.js)
Majority of the code was copied from the sample code given, and modified based on individual project tables. 
Source URL: https://github.com/osu-cs340-ecampus/nodejs-starter-app/tree/main/Step%200%20-%20Setting%20Up%20Node.js
*/

const express = require('express');
const router = express.Router();
const db = require('../database/db-connector');

// GET route for the booksBorrowers page
router.get('/booksBorrowers', function(req, res) {
    let queryBooksBorrowers = `
        SELECT Books.bookID AS booksBookID, Books.bookTitle, Borrowers.userID AS borrowersUserID, Borrowers.userName
        FROM BooksBorrowers
        JOIN Books ON BooksBorrowers.booksBookID = Books.bookID
        JOIN Borrowers ON BooksBorrowers.borrowersUserID = Borrowers.userID;
    `;
    let queryBooks = "SELECT * FROM Books;";
    let queryBorrowers = "SELECT * FROM Borrowers;";

    db.pool.query(queryBooksBorrowers, function(error, booksBorrowersRows, fields) {
        if (error) {
            console.error(error);
            res.sendStatus(500);
        } else {
            db.pool.query(queryBooks, function(bookError, bookRows, fields) {
                if (bookError) {
                    console.error(bookError);
                    res.sendStatus(500);
                } else {
                    db.pool.query(queryBorrowers, function(borrowerError, borrowerRows, fields) {
                        if (borrowerError) {
                            console.error(borrowerError);
                            res.sendStatus(500);
                        } else {
                            res.render('booksBorrowers', {
                                data: booksBorrowersRows,
                                books: bookRows,
                                borrowers: borrowerRows
                            });
                        }
                    });
                }
            });
        }
    });
});

// POST route for adding a new book-borrower relationship
router.post('/booksBorrowers/add', function(req, res) {
    let data = req.body;

    let query = `INSERT INTO BooksBorrowers (booksBookID, borrowersUserID) VALUES (?, ?)`;
    let inserts = [data.bookID, data.borrowerID];

    db.pool.query(query, inserts, function(error, rows, fields) {
        if (error) {
            console.error(error);
            res.sendStatus(500);
        } else {
            res.redirect('/booksBorrowers');
        }
    });
});

// POST route for updating a book-borrower relationship
router.post('/booksBorrowers/update', function(req, res) {
    let data = req.body;

    let query = `
        UPDATE BooksBorrowers 
        SET booksBookID = ?, borrowersUserID = ?
        WHERE booksBookID = ? AND borrowersUserID = ?
    `;
    let inserts = [data.bookID, data.borrowerID, data.originalBookID, data.originalBorrowerID];

    db.pool.query(query, inserts, function(error, rows, fields) {
        if (error) {
            console.error(error);
            res.sendStatus(500);
        } else {
            res.redirect('/booksBorrowers');
        }
    });
});

// POST route for deleting a book-borrower relationship
router.post('/booksBorrowers/delete', function(req, res) {
    let data = req.body;

    let query = `DELETE FROM BooksBorrowers WHERE booksBookID = ? AND borrowersUserID = ?`;
    let inserts = [data.bookID, data.borrowerID];

    db.pool.query(query, inserts, function(error, rows, fields) {
        if (error) {
            console.error(error);
            res.sendStatus(500);
        } else {
            res.redirect('/booksBorrowers');
        }
    });
});

module.exports = router;
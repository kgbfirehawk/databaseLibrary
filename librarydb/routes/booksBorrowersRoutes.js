 /* Citation for the following function:
Date: 11/21/2024
Adapted from CS 340: nodejs-starter-app (app.js)
Majority of the code was copied from the sample code given, and modified based on individual project tables. 
Source URL: https://github.com/osu-cs340-ecampus/nodejs-starter-app/tree/main/Step%200%20-%20Setting%20Up%20Node.js
*/

const express = require('express');
const router = express.Router();
const db = require('../database/db-connector');

// Helper function to execute a query and return a promise
function queryDatabase(query, inserts = []) {
    return new Promise((resolve, reject) => {
        db.pool.query(query, inserts, (error, results) => {
            if (error) {
                reject(error);
            } else {
                resolve(results);
            }
        });
    });
}

// GET route for the booksBorrowers page
router.get('/booksBorrowers', async function(req, res) {
    try {
        // Query to get all book-borrower relationships with names
        let queryBooksBorrowers = `
            SELECT 
                BooksBorrowers.booksBookID,
                BooksBorrowers.borrowersUserID,
                Books.bookTitle,
                Borrowers.userName
            FROM BooksBorrowers
            JOIN Books ON BooksBorrowers.booksBookID = Books.bookID
            JOIN Borrowers ON BooksBorrowers.borrowersUserID = Borrowers.userID;
        `;

        // Queries to get all books and borrowers for the dropdowns
        let queryBooks = "SELECT bookID, bookTitle FROM Books;";
        let queryBorrowers = "SELECT userID, userName FROM Borrowers;";

        const [booksBorrowersRows, booksRows, borrowersRows] = await Promise.all([
            queryDatabase(queryBooksBorrowers),
            queryDatabase(queryBooks),
            queryDatabase(queryBorrowers)
        ]);

        res.render('booksBorrowers', {
            data: booksBorrowersRows,
            books: booksRows,
            borrowers: borrowersRows
        });
    } catch (error) {
        console.error(error);
        res.sendStatus(500);
    }
});

// POST route for adding a new book-borrower relationship
router.post('/booksBorrowers/add', async function(req, res) {
    let data = req.body;

    let query = `INSERT INTO BooksBorrowers (booksBookID, borrowersUserID) VALUES (?, ?)`;
    let inserts = [data.bookID, data.borrowerID];

    try {
        await queryDatabase(query, inserts);
        res.redirect('/booksBorrowers');
    } catch (error) {
        console.error(error);
        res.sendStatus(500);
    }
});

// POST route for deleting a book-borrower relationship
router.post('/booksBorrowers/delete', async function(req, res) {
    let data = req.body;

    let query = `DELETE FROM BooksBorrowers WHERE booksBookID = ? AND borrowersUserID = ?`;
    let inserts = [data.bookID, data.borrowerID];

    try {
        await queryDatabase(query, inserts);
        res.redirect('/booksBorrowers');
    } catch (error) {
        console.error(error);
        res.sendStatus(500);
    }
});

module.exports = router;
-- Data Manipulation Queries for Library Management System
-- By:  Mackenzie Jackson
--      Kyle Belina
-- colon : character being used to denote the variables that will have data from the backend programming language


-- Get all libraries for displaying in dropdowns
SELECT libraryID, libraryName FROM Libraries;

-- Insert a new library into the Libraries table
INSERT INTO Libraries (libraryName, libraryAddress, contactNumber)
VALUES (:libraryNameInput, :libraryAddressInput, :contactNumberInput);

-- Get all books and their respective library for the List Books page
SELECT Books.bookID, bookTitle, bookAuthor, bookGenre, Libraries.libraryName AS library
FROM Books
INNER JOIN Libraries ON Books.librariesLibraryID = Libraries.libraryID;

-- Get a single book's data for the Update Book form 
SELECT bookID, bookTitle, bookAuthor, bookGenre, librariesLibraryID
FROM Books
WHERE bookID = :bookID_selected_from_browse_books_page;

-- Insert a new book into the Books table 
INSERT INTO Books (bookTitle, bookAuthor, bookGenre, librariesLibraryID)
VALUES (:bookTitleInput, :bookAuthorInput, :bookGenreInput, :libraryIDInput);

-- Update book details based on submission of the Update Book form 
UPDATE Books
SET bookTitle = :bookTitleInput, bookAuthor = :bookAuthorInput,
    bookGenre = :bookGenreInput, librariesLibraryID = :libraryIDInput
WHERE bookID = :bookID_from_update_form;

-- Delete a book from the Books table 
DELETE FROM Books WHERE bookID = :bookID_selected_from_browse_books_page;

-- Get all borrowers for displaying in dropdowns
SELECT userID, userName FROM Borrowers;

-- Insert a new borrower into the Borrowers table
INSERT INTO Borrowers (userName, userAddress, userPhone)
VALUES (:userNameInput, :userAddressInput, :userPhoneInput);

-- Update borrower details based on submission of the Update Borrower form
UPDATE Borrowers
SET userName = :userNameInput, userAddress = :userAddressInput, userPhone = :userPhoneInput
WHERE userID = :userID_from_update_form;

-- Delete a borrower from the Borrowers table
DELETE FROM Borrowers WHERE userID = :userID_selected_from_browse_borrowers_page;

-- Get all staff members and their respective library for the List Staff page
SELECT Staff.staffID, staffName, staffTitle, staffExtension, Libraries.libraryName AS library
FROM Staff
LEFT JOIN Libraries ON Staff.librariesLibraryID = Libraries.libraryID;

-- Insert a new staff member into the Staff table
INSERT INTO Staff (staffName, staffTitle, staffExtension, librariesLibraryID)
VALUES (:staffNameInput, :staffTitleInput, :staffExtensionInput, :libraryIDInput);

-- Update staff member details based on submission of the Update Staff form
UPDATE Staff
SET staffName = :staffNameInput, staffTitle = :staffTitleInput, staffExtension = :staffExtensionInput,
    librariesLibraryID = :libraryIDInput
WHERE staffID = :staffID_from_update_form;

-- Delete a staff member from the Staff table
DELETE FROM Staff WHERE staffID = :staffID_selected_from_browse_staff_page;

-- Get all checkouts with book, borrower, staff, and library details for the List Checkouts page
SELECT Checkouts.checkoutID, Libraries.libraryName, Borrowers.userName, Staff.staffName, Books.bookTitle, dueDate
FROM Checkouts
INNER JOIN Libraries ON Checkouts.librariesLibraryID = Libraries.libraryID
INNER JOIN Borrowers ON Checkouts.borrowersUserID = Borrowers.userID
INNER JOIN Staff ON Checkouts.staffStaffID = Staff.staffID
INNER JOIN Books ON Checkouts.booksBookID = Books.bookID;

-- Insert a new checkout into the Checkouts table
INSERT INTO Checkouts (dueDate, librariesLibraryID, booksBookID, borrowersUserID, staffStaffID)
VALUES (:dueDateInput, :libraryIDInput, :bookIDInput, :borrowerIDInput, :staffIDInput);

-- Update checkout details based on submission of the Update Checkout form
UPDATE Checkouts
SET dueDate = :dueDateInput, librariesLibraryID = :libraryIDInput,
    booksBookID = :bookIDInput, borrowersUserID = :borrowerIDInput, staffStaffID = :staffIDInput
WHERE checkoutID = :checkoutID_from_update_form;

-- Delete a checkout from the Checkouts table
DELETE FROM Checkouts WHERE checkoutID = :checkoutID_selected_from_browse_checkouts_page;

-- Insert a new book-borrower association into the BooksBorrowers table
INSERT INTO BooksBorrowers (booksBookID, borrowersUserID)
VALUES (:bookIDInput, :borrowerIDInput);

-- Delete a book-borrower association from the BooksBorrowers table
DELETE FROM BooksBorrowers WHERE booksBookID = :bookIDInput AND borrowersUserID = :borrowerIDInput;
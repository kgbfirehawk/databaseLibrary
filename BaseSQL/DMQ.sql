-- Data Manipulation Queries for Library Management System
-- By:  Mackenzie Jackson
--      Kyle Belina

-- Get all libraries for displaying in dropdowns
SELECT libraryID, libraryName FROM Libraries;

-- Get all books and their respective library for the List Books page
SELECT Books.bookID, bookTitle, bookAuthor, bookGenre, Libraries.libraryName AS library
FROM Books
INNER JOIN Libraries ON Books.librariesLibraryID = Libraries.libraryID;

-- Get a single book's data for the Update Book form ************remove ISBN?
SELECT bookID, bookISBN, bookTitle, bookAuthor, bookGenre, librariesLibraryID
FROM Books
WHERE bookID = :bookID_selected_from_browse_books_page;

-- Insert a new book into the Books table ************remove ISBN?
INSERT INTO Books (bookISBN, bookTitle, bookAuthor, bookGenre, librariesLibraryID)
VALUES (:bookISBNInput, :bookTitleInput, :bookAuthorInput, :bookGenreInput, :libraryIDInput);

-- Update book details based on submission of the Update Book form ************remove ISBN?
UPDATE Books
SET bookISBN = :bookISBNInput, bookTitle = :bookTitleInput, bookAuthor = :bookAuthorInput,
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
INNER JOIN Libraries ON Staff.librariesLibraryID = Libraries.libraryID;

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

-- Get all checkouts with book, borrower, staff, and library details for the List Checkouts page  ********* Remove isReturn?
SELECT Checkouts.checkoutID, Libraries.libraryName, Borrowers.userName, Staff.staffName, Books.bookTitle, dueDate, isReturn
FROM Checkouts
INNER JOIN Libraries ON Checkouts.librariesLibraryID = Libraries.libraryID
INNER JOIN Borrowers ON Checkouts.borrowersUserID = Borrowers.userID
INNER JOIN Staff ON Checkouts.staffStaffID = Staff.staffID
INNER JOIN Books ON Checkouts.booksBookID = Books.bookID;

-- Insert a new checkout into the Checkouts table ********* Remove isReturn?
INSERT INTO Checkouts (dueDate, isReturn, librariesLibraryID, booksBookID, borrowersUserID, staffStaffID)
VALUES (:dueDateInput, :isReturnInput, :libraryIDInput, :bookIDInput, :borrowerIDInput, :staffIDInput);

-- Update checkout details based on submission of the Update Checkout form  ********* Remove isReturn?
UPDATE Checkouts
SET dueDate = :dueDateInput, isReturn = :isReturnInput, librariesLibraryID = :libraryIDInput,
    booksBookID = :bookIDInput, borrowersUserID = :borrowerIDInput, staffStaffID = :staffIDInput
WHERE checkoutID = :checkoutID_from_update_form;

-- Delete a checkout from the Checkouts table
DELETE FROM Checkouts WHERE checkoutID = :checkoutID_selected_from_browse_checkouts_page;
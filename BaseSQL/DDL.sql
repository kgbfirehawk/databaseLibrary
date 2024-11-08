-- Introduction Data Definition queries

-- Disable foreign key checks to avoid issues during import
SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

-- Create Libraries table
CREATE OR REPLACE TABLE Libraries (
    libraryID INT NOT NULL AUTO_INCREMENT,
    libraryName VARCHAR(50) NOT NULL,
    libraryAddress VARCHAR(50) NOT NULL,
    contactNumber VARCHAR(50) NOT NULL,
    PRIMARY KEY (libraryID)
);

-- Create Books table ************************
CREATE OR REPLACE TABLE Books (
    bookID INT NOT NULL AUTO_INCREMENT,
    -- bookISBN VARCHAR(50) NOT NULL,
    bookTitle VARCHAR(50) NOT NULL,
    bookAuthor VARCHAR(50) NOT NULL,
    bookGenre VARCHAR(50) NOT NULL,
    librariesLibraryID INT NOT NULL,
    PRIMARY KEY (bookID),
    CONSTRAINT fkBooksLibrary FOREIGN KEY (librariesLibraryID) REFERENCES Libraries(libraryID) ON DELETE CASCADE
);

-- Create Borrowers table
CREATE OR REPLACE TABLE Borrowers (
    userID INT NOT NULL AUTO_INCREMENT,
    userName VARCHAR(50) NOT NULL,
    userAddress VARCHAR(50) NOT NULL,
    userPhone VARCHAR(50) NOT NULL,
    PRIMARY KEY (userID)
);

-- Create Staff table
CREATE OR REPLACE TABLE Staff (
    staffID INT NOT NULL AUTO_INCREMENT,
    staffName VARCHAR(50) NOT NULL,
    staffTitle VARCHAR(50) NOT NULL,
    staffExtension INT,
    librariesLibraryID INT NOT NULL,
    PRIMARY KEY (staffID),
    CONSTRAINT fkStaffLibrary FOREIGN KEY (librariesLibraryID) REFERENCES Libraries(libraryID) ON DELETE CASCADE
);

-- Create Checkouts table *********************
CREATE OR REPLACE TABLE Checkouts (
    checkoutID INT NOT NULL AUTO_INCREMENT,
    dueDate DATE NOT NULL,
    -- isReturn TINYINT,
    librariesLibraryID INT NOT NULL,
    booksBookID INT NOT NULL,
    borrowersUserID INT NOT NULL,
    staffStaffID INT NOT NULL,
    PRIMARY KEY (checkoutID),
    CONSTRAINT fkCheckoutsLibrary FOREIGN KEY (librariesLibraryID) REFERENCES Libraries(libraryID) ON DELETE CASCADE,
    CONSTRAINT fkCheckoutsBook FOREIGN KEY (booksBookID) REFERENCES Books(bookID) ON DELETE RESTRICT,
    CONSTRAINT fkCheckoutsBorrower FOREIGN KEY (borrowersUserID) REFERENCES Borrowers(userID) ON DELETE CASCADE,
    CONSTRAINT fkCheckoutsStaff FOREIGN KEY (staffStaffID) REFERENCES Staff(staffID) ON DELETE RESTRICT
);

-- Create BooksBorrowers table
CREATE OR REPLACE TABLE BooksBorrowers (
    booksBookID INT NOT NULL,
    borrowersUserID INT NOT NULL,
    PRIMARY KEY (booksBookID, borrowersUserID),
    CONSTRAINT fkBooksHasBorrowersBook FOREIGN KEY (booksBookID) REFERENCES Books(bookID) ON DELETE CASCADE,
    CONSTRAINT fkBooksHasBorrowersBorrower FOREIGN KEY (borrowersUserID) REFERENCES Borrowers(userID) ON DELETE CASCADE
);

-- Insert data into Libraries table
INSERT INTO Libraries (libraryName, libraryAddress, contactNumber) 
VALUES
('Mansfield', '123 E. Broadway St, Sunnyside, OR, 93643', '503-234-9999'),
('Bluehill', '560 Wyatt Ave, Sunnyside, OR, 94645', '503-234-9923'),
('Lovewood', '62 S. Goven St, Sunnyside, OR, 94222', '503-234-9876'),
('Harrington', '236 Blackwater Blvd, Sunnyside, OR, 93432', '503-234-9944');

-- Insert data into Books table (Remove Book ISBN and values????) ******************************
INSERT INTO Books (bookISBN, bookTitle, bookAuthor, bookGenre, librariesLibraryID) 
VALUES
('1593276036', 'Python Crash Course', 'Eric Matthes', 'Nonfiction', 2),
('593498089', 'Solito: a memoir', 'Javier Zamora', 'Biography', 1),
('05933650X', 'The Seven Year Slip', 'Ashley Poston', 'Fiction', 1),
('0062364355X', 'A Mind Awake', 'C.S. Lewis', 'Nonfiction', 4);

-- Insert data into Borrowers table
INSERT INTO Borrowers (userName, userAddress, userPhone) 
VALUES
('Mary Johnson', '232 Westgate Ave, Sunnyside, OR, 95645', '503-244-5699'),
('James Bason', '1212 Apple Way, Sunnyside, OR, 94645', '503-454-2323'),
('Laury Hanns', '45 Maury Lane, Sunnyside, OR, 94223', '503-234-4343'),
('Edward Halle', '44 Ferry St, Sunnyside, OR, 93432', '503-576-9941');

-- Insert data into Staff table
INSERT INTO Staff (staffName, staffTitle, staffExtension, librariesLibraryID) 
VALUES
('Amy Lane', 'Library Manager', 121, 3),
('Adam Ghuyen', 'Reference Librarian', NULL, 2),
('Brenda Cordelle', 'Book Buyer', 120, 2),
('Synthia Hart', 'Children Librarian', 124, 4);

-- Insert data into Checkouts table (Remove isReturn and values??????) *********************
INSERT INTO Checkouts (dueDate, isReturn, librariesLibraryID, booksBookID, borrowersUserID, staffStaffID) 
VALUES
('2024-10-28', 0, 1, 1, 1, 1),
('2024-11-01', 0, 2, 2, 2, 2),
('2024-11-05', 1, 3, 3, 3, 3),
('2024-11-10', 0, 4, 4, 4, 4);

-- Insert data into BooksBorrowers table
-- (1, 1): Book with bookID 1 is borrowed by borrower with userID 1
-- (1, 2): Book with bookID 1 is also borrowed by borrower with userID 2
-- (2, 3): Book with bookID 2 is borrowed by borrower with userID 3
-- (3, 4): Book with bookID 3 is borrowed by borrower with userID 4
INSERT INTO BooksBorrowers (booksBookID, borrowersUserID) 
VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4);

-- Re-enable foreign key checks and commit changes
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

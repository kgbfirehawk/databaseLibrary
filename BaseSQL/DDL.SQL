-- Introduction Data Definition queries

-- Disable foreign key checks to avoid issues during import
SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

-- Create Libraries table
CREATE OR REPLACE TABLE Libraries (
    libraryID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    libraryName VARCHAR(50) NOT NULL,
    libraryAddress VARCHAR(50) NOT NULL,
    contactNumber INT NOT NULL
);

-- Create Books table
CREATE OR REPLACE TABLE Books (
    bookID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    bookISBN VARCHAR(20) NOT NULL,
    bookTitle VARCHAR(50) NOT NULL,
    bookAuthor VARCHAR(50) NOT NULL,
    bookGenre VARCHAR(50) NOT NULL,
    Libraries_libraryID INT NOT NULL,
    CONSTRAINT fk_books_library FOREIGN KEY (Libraries_libraryID) REFERENCES Libraries(libraryID)
);

-- Create Borrowers table
CREATE OR REPLACE TABLE Borrowers (
    userID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userName VARCHAR(50) NOT NULL,
    userAddress VARCHAR(50) NOT NULL,
    userPhone INT NOT NULL
);

-- Create Staff table
CREATE OR REPLACE TABLE Staff (
    staffID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    staffName VARCHAR(50) NOT NULL,
    staffTitle VARCHAR(50) NOT NULL,
    staffExtension INT,
    Libraries_libraryID INT NOT NULL,
    CONSTRAINT fk_staff_library FOREIGN KEY (Libraries_libraryID) REFERENCES Libraries(libraryID)
);

-- Create Checkouts table
CREATE OR REPLACE TABLE Checkouts (
    checkoutID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dueDate DATE NOT NULL,
    isReturn TINYINT,
    Libraries_libraryID INT NOT NULL,
    Books_bookID INT NOT NULL,
    Borrowers_userID INT NOT NULL,
    Staff_staffID INT NOT NULL,
    CONSTRAINT fk_checkouts_library FOREIGN KEY (Libraries_libraryID) REFERENCES Libraries(libraryID),
    CONSTRAINT fk_checkouts_book FOREIGN KEY (Books_bookID) REFERENCES Books(bookID),
    CONSTRAINT fk_checkouts_borrower FOREIGN KEY (Borrowers_userID) REFERENCES Borrowers(userID) ON DELETE CASCADE,
    CONSTRAINT fk_checkouts_staff FOREIGN KEY (Staff_staffID) REFERENCES Staff(staffID) ON DELETE SET NULL
);

-- Create Books_has_Borrowers table
CREATE OR REPLACE TABLE Books_has_Borrowers (
    Books_bookID INT NOT NULL,
    Borrowers_userID INT NOT NULL,
    PRIMARY KEY (Books_bookID, Borrowers_userID),
    CONSTRAINT fk_books_has_borrowers_book FOREIGN KEY (Books_bookID) REFERENCES Books(bookID),
    CONSTRAINT fk_books_has_borrowers_borrower FOREIGN KEY (Borrowers_userID) REFERENCES Borrowers(userID) ON DELETE CASCADE
);

-- Insert data into Libraries table
INSERT INTO Libraries (libraryName, libraryAddress, contactNumber) 
VALUES
('Mansfield', '123 E. Broadway St, Sunnyside, OR, 93643', 5032349999),
('Bluehill', '560 Wyatt Ave, Sunnyside, OR, 94645', 5032349923),
('Lovewood', '62 S. Goven St, Sunnyside, OR, 94222', 5032349876),
('Harrington', '236 Blackwater Blvd, Sunnyside, OR, 93432', 5032349944);

-- Insert data into Books table
INSERT INTO Books (bookISBN, bookTitle, bookAuthor, bookGenre, Libraries_libraryID) 
VALUES
(1593276036, 'Python Crash Course', 'Eric Matthes', 'Nonfiction', 2),
(593498089, 'Solito: a memoir', 'Javier Zamora', 'Biography', 1),
('5933650X', 'The Seven Year Slip', 'Ashley Poston', 'Fiction', 1),
('62364355X', 'A Mind Awake', 'C.S. Lewis', 'Nonfiction', 4);

-- Insert data into Borrowers table
INSERT INTO Borrowers (userName, userAddress, userPhone) 
VALUES
('Mary Johnson', '232 Westgate Ave, Sunnyside, OR, 95645', 5032445699),
('James Bason', '1212 Apple Way, Sunnyside, OR, 94645', 5034542323),
('Laury Hanns', '45 Maury Lane, Sunnyside, OR, 94223', 5032344343),
('Edward Halle', '44 Ferry St, Sunnyside, OR, 93432', 5035769941);

-- Insert data into Staff table
INSERT INTO Staff (staffName, staffTitle, staffExtension, Libraries_libraryID) 
VALUES
('Amy Lane', 'Library Manager', 121, 3),
('Adam Ghuyen', 'Reference Librarian', NULL, 2),
('Brenda Cordelle', 'Book Buyer', 120, 2),
('Synthia Hart', 'Children Librarian', 124, 4);

-- Insert data into Checkouts table
INSERT INTO Checkouts (dueDate, isReturn, Libraries_libraryID, Books_bookID, Borrowers_userID, Staff_staffID) 
VALUES
('2024-10-28', 0, 1, 1, 1, 1),
('2024-11-01', 0, 2, 2, 2, 2),
('2024-11-05', 1, 3, 3, 3, 3),
('2024-11-10', 0, 4, 4, 4, 4);

-- Insert data into Books_has_Borrowers table
-- (1, 1): Book with bookID 1 is borrowed by borrower with userID 1
-- (1, 2): Book with bookID 1 is also borrowed by borrower with userID 2
-- (2, 3): Book with bookID 2 is borrowed by borrower with userID 3
-- (3, 4): Book with bookID 3 is borrowed by borrower with userID 4
INSERT INTO Books_has_Borrowers (Books_bookID, Borrowers_userID) 
VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4);

-- Re-enable foreign key checks and commit changes
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

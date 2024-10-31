SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;


CREATE OR REPLACE TABLE Libraries (
    libraryID INT NOT NULL AUTO_INCREMENT,
    libraryName VARCHAR(50) NOT NULL,
    libraryAddress VARCHAR(50) NOT NULL,
    contactNumber INT NOT NULL,
    PRIMARY KEY (libraryID)
);

CREATE OR REPLACE TABLE Books (
    bookID INT NOT NULL AUTO_INCREMENT,
    bookISBN INT NOT NULL,
    bookTitle VARCHAR(50) NOT NULL,
    bookAuthor VARCHAR(50) NOT NULL,
    bookGenre VARCHAR(50) NOT NULL,
    Libraries_libraryID INT NOT NULL,
    PRIMARY KEY (bookID),
    CONSTRAINT fk_books_library FOREIGN KEY (Libraries_libraryID) REFERENCES Libraries(libraryID) ON DELETE CASCADE
);

CREATE OR REPLACE TABLE Borrowers (
    userID INT NOT NULL AUTO_INCREMENT,
    userName VARCHAR(50) NOT NULL,
    userAddress VARCHAR(50) NOT NULL,
    userPhone INT NOT NULL,
    PRIMARY KEY (userID)
);

CREATE OR REPLACE TABLE Staff (
    staffID INT NOT NULL AUTO_INCREMENT,
    staffName VARCHAR(50) NOT NULL,
    staffTitle VARCHAR(50) NOT NULL,
    staffExtension INT,
    Libraries_libraryID INT NOT NULL,
    PRIMARY KEY (staffID),
    CONSTRAINT fk_staff_library FOREIGN KEY (Libraries_libraryID) REFERENCES Libraries(libraryID) ON DELETE CASCADE
);

CREATE OR REPLACE TABLE Checkouts (
    checkoutID INT NOT NULL AUTO_INCREMENT,
    dueDate DATE NOT NULL,
    isReturn TINYINT,
    Libraries_libraryID INT NOT NULL,
    Books_bookID INT NOT NULL,
    Borrowers_userID INT NOT NULL,
    Staff_staffID INT NOT NULL,
    PRIMARY KEY (checkoutID),
    CONSTRAINT fk_checkouts_library FOREIGN KEY (Libraries_libraryID) REFERENCES Libraries(libraryID) ON DELETE CASCADE,
    CONSTRAINT fk_checkouts_book FOREIGN KEY (Books_bookID) REFERENCES Books(bookID) ON DELETE SET NULL,
    CONSTRAINT fk_checkouts_borrower FOREIGN KEY (Borrowers_userID) REFERENCES Borrowers(userID) ON DELETE CASCADE,
    CONSTRAINT fk_checkouts_staff FOREIGN KEY (Staff_staffID) REFERENCES Staff(staffID) ON DELETE SET NULL
);

CREATE OR REPLACE TABLE Books_has_Borrowers (
    Books_bookID INT NOT NULL,
    Borrowers_userID INT NOT NULL,
    PRIMARY KEY (Books_bookID, Borrowers_userID),
    CONSTRAINT fk_books_has_borrowers_book FOREIGN KEY (Books_bookID) REFERENCES Books(bookID) ON DELETE CASCADE,
    CONSTRAINT fk_books_has_borrowers_borrower FOREIGN KEY (Borrowers_userID) REFERENCES Borrowers(userID) ON DELETE CASCADE
);

SET FOREIGN_KEY_CHECKS=1;
COMMIT;

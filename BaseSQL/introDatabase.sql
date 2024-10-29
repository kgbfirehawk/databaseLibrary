CREATE OR REPLACE TABLE Libraries (
    libraryID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    libraryName VARCHAR(50) NOT NULL,
    libraryAddress VARCHAR(50) NOT NULL,
    contactNumber INT NOT NULL
);

CREATE OR REPLACE TABLE Books (
    bookID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    bookISBN INT NOT NULL,
    bookTitle VARCHAR(50) NOT NULL,
    bookAuthor VARCHAR(50) NOT NULL,
    bookGenre VARCHAR(50) NOT NULL,
    Libraries_libraryID INT NOT NULL,
    FOREIGN KEY (Libraries_libraryID) REFERENCES Libraries(libraryID)
);

CREATE OR REPLACE TABLE Borrowers (
    userID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userName VARCHAR(50) NOT NULL,
    userAddress VARCHAR(145) NOT NULL,
    userPhone INT NOT NULL
);

CREATE OR REPLACE TABLE Staff (
    staffID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    staffName VARCHAR(50) NOT NULL,
    staffTitle VARCHAR(50) NOT NULL,
    staffExtension INT,
    Libraries_libraryID INT NOT NULL,
    FOREIGN KEY (Libraries_libraryID) REFERENCES Libraries(libraryID)
);

CREATE OR REPLACE TABLE Checkouts (
    dueDate DATE NOT NULL,
    isReturn TINYINT,
    Libraries_libraryID INT NOT NULL,
    Books_bookID INT NOT NULL,
    Borrowers_userID INT NOT NULL,
    Staff_staffID INT NOT NULL,
    FOREIGN KEY (Libraries_libraryID) REFERENCES Libraries(libraryID),
    FOREIGN KEY (Books_bookID) REFERENCES Books(bookID),
    FOREIGN KEY (Borrowers_userID) REFERENCES Borrowers(userID),
    FOREIGN KEY (Staff_staffID) REFERENCES Staff(staffID)
);

CREATE OR REPLACE TABLE Books_has_Borrowers (
    Books_bookID INT NOT NULL,
    Borrowers_userID INT NOT NULL,
    PRIMARY KEY (Books_bookID, Borrowers_userID),
    FOREIGN KEY (Books_bookID) REFERENCES Books(bookID),
    FOREIGN KEY (Borrowers_userID) REFERENCES Borrowers(userID)
);

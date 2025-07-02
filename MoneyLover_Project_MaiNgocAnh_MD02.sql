--Tao Database
CREATE DATABASE MoneyLove
GO

--Tao Bang Users 
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50),
    Email VARCHAR(100),
    Password_hash VARCHAR(255),
    Created_at DATETIME DEFAULT GETDATE(),        --tu dong chèn thoi gian hien tai khi tao dòng du lieu
    Updated_at DATETIME DEFAULT GETDATE()
)

--Tao Bang Wallet 
CREATE TABLE Wallet (
    WalletID INT PRIMARY KEY,
    UserID INT,
    Name VARCHAR(100),
    Balance DECIMAL(18,2),
    Currency VARCHAR(10),
    Create_at DATETIME DEFAULT GETDATE(),
    Update_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
)

--Tao Bang Category 
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    UserID INT,
    ParentID INT,
    Name VARCHAR(100),
    Type VARCHAR(50),
    Create_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ParentID) REFERENCES Category(CategoryID)
)

--Tao Bang Recurring_Transaction 
CREATE TABLE Recurring_Transaction (
    RecurringID INT PRIMARY KEY,
    UserID INT,
    WalletID INT,
    CategoryID INT,
    Amount DECIMAL(18,2),
    TransactionType VARCHAR(50),
    Frequency VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    Note TEXT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (WalletID) REFERENCES Wallet(WalletID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
)

--Tao Bang Transactions 
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    UserID INT,
    WalletID INT,
    CategoryID INT,
    RecurringID INT,
    Amount DECIMAL(18,2),
    TransactionType VARCHAR(50),
    Date DATE,
    Note TEXT,
    Create_at DATETIME DEFAULT GETDATE(),
    Update_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (WalletID) REFERENCES Wallet(WalletID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
    FOREIGN KEY (RecurringID) REFERENCES Recurring_Transaction(RecurringID)
)

--Tao Bang Debt 
CREATE TABLE Debt (
    DebtID INT PRIMARY KEY,
    UserID INT,
    Amount DECIMAL(18,2),
    DebtType VARCHAR(50),
    DueDate DATE,
    Note TEXT,
    Status VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
)

--Tao Bang Budget 
CREATE TABLE Budget (
    BudgetID INT PRIMARY KEY,
    UserID INT,
    CategoryID INT,
    Amount DECIMAL(18,2),
    Period VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    Create_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
)

--Tao Bang BankAccount 
CREATE TABLE BankAccount (
    BankAccountID INT PRIMARY KEY,
    UserID INT,
    BankName VARCHAR(100),
    AccountNumber VARCHAR(50),
    Balance DECIMAL(18,2),
    Create_at TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
)

--Tao Bang Notification 
CREATE TABLE Notification (
    NotificationID INT PRIMARY KEY,
    UserID INT,
    Message TEXT,
    IsRead BIT,             --kieu du lieu thay the cho BOOLEAN trong SQL Server. 0 = false, 1 = true
    Created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
)

--Tao Bang Tag 
CREATE TABLE Tag (
    TagID INT PRIMARY KEY,
    UserID INT,
    Name VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
)

--Tao Bang TransactionTag 
CREATE TABLE TransactionTag (
    TransactionID INT,
    TagID INT,
    PRIMARY KEY (TransactionID, TagID),
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID),
    FOREIGN KEY (TagID) REFERENCES Tag(TagID)
)

--Tao Bang ExchangeRate 
CREATE TABLE ExchangeRate (
    RateID INT PRIMARY KEY IDENTITY(1,1),
    FromCurrency VARCHAR(10) NOT NULL,
    ToCurrency VARCHAR(10) NOT NULL,
    Rate DECIMAL(18,6) NOT NULL,         
    EffectiveDate DATE NOT NULL,            -- ngày ti giá có hieu l?c
    Created_at DATETIME DEFAULT GETDATE(),
    Updated_at DATETIME DEFAULT GETDATE()
)

CREATE DATABASE banking_analytics;
USE banking_analytics;


USE banking_analytics;

CREATE TABLE Branches (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(100),
    City VARCHAR(100)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Gender VARCHAR(20),
    City VARCHAR(100),
    State VARCHAR(50)
);

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    BranchID INT,
    AccountType VARCHAR(50),
    OpenDate DATE,
    Balance DECIMAL(15,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionDate DATE,
    TransactionType VARCHAR(50),
    Amount DECIMAL(15,2),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    CustomerID INT,
    LoanType VARCHAR(50),
    LoanAmount DECIMAL(15,2),
    Status VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);





SELECT
    TransactionDate,
    COUNT(TransactionID) AS Total_Transactions,
    SUM(Amount) AS Total_Transaction_Value
FROM transactions
GROUP BY TransactionDate
ORDER BY TransactionDate;



SELECT
    YEAR(TransactionDate) AS Transaction_Year,
    MONTH(TransactionDate) AS Transaction_Month,
    COUNT(TransactionID) AS Total_Transactions,
    SUM(Amount) AS Total_Transaction_Value
FROM transactions
GROUP BY
    YEAR(TransactionDate),
    MONTH(TransactionDate)
ORDER BY
    Transaction_Year,
    Transaction_Month;
    
    
    
    
    SELECT
    YEAR(TransactionDate) AS Transaction_Year,
    COUNT(TransactionID) AS Total_Transactions,
    SUM(Amount) AS Total_Transaction_Value
FROM transactions
GROUP BY YEAR(TransactionDate)
ORDER BY Transaction_Year;



SELECT
    TransactionType,
    COUNT(*) AS Total_Transactions,
    SUM(Amount) AS Total_Amount
FROM transactions
GROUP BY TransactionType;





SELECT
    CASE
        WHEN TransactionType = 'Deposit' THEN 'Deposit'
        WHEN TransactionType = 'Withdrawal' THEN 'Withdrawal'
    END AS Transaction_Category,
    
    COUNT(TransactionID) AS Total_Transactions,
    SUM(Amount) AS Total_Amount,
    AVG(Amount) AS Average_Amount

FROM transactions
WHERE TransactionType IN ('Deposit', 'Withdrawal')

GROUP BY TransactionType
ORDER BY Total_Amount DESC;






SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(t.TransactionID) AS Total_Transactions,
    SUM(t.Amount) AS Total_Transaction_Value
FROM customers c
JOIN accounts a
    ON c.CustomerID = a.CustomerID
JOIN transactions t
    ON a.AccountID = t.AccountID
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY
    Total_Transaction_Value DESC
LIMIT 10;



SELECT *
FROM branches
LIMIT 5;






SELECT
    b.BranchID,
    b.BranchName,
    b.City,
    COUNT(DISTINCT a.AccountID) AS Total_Accounts,
    COUNT(t.TransactionID) AS Total_Transactions,
    SUM(t.Amount) AS Total_Transaction_Value,
    AVG(a.Balance) AS Average_Balance
FROM branches b
LEFT JOIN accounts a
    ON b.BranchID = a.BranchID
LEFT JOIN transactions t
    ON a.AccountID = t.AccountID
GROUP BY
    b.BranchID,
    b.BranchName,
    b.City
ORDER BY Total_Transaction_Value DESC;




SELECT
    AVG(Balance) AS Overall_Average_Account_Balance
FROM accounts;




SELECT *
FROM transactions
ORDER BY Amount DESC
LIMIT 10;





SELECT
    a.AccountID,
    a.CustomerID,
    a.BranchID,
    a.Balance,
    COUNT(t.TransactionID) AS Total_Transactions
FROM accounts a
LEFT JOIN transactions t
    ON a.AccountID = t.AccountID
GROUP BY
    a.AccountID,
    a.CustomerID,
    a.BranchID,
    a.Balance
HAVING COUNT(t.TransactionID) = 0;




SELECT
    CustomerID,
    COUNT(AccountID) AS Total_Accounts
FROM accounts
GROUP BY CustomerID
HAVING COUNT(AccountID) > 1
ORDER BY Total_Accounts DESC;





SELECT
    b.BranchID,
    b.BranchName,
    b.City,
    COUNT(l.LoanID) AS Total_Loans,
    SUM(l.LoanAmount) AS Total_Loan_Amount
FROM loans l
JOIN customers c
    ON l.CustomerID = c.CustomerID
JOIN accounts a
    ON c.CustomerID = a.CustomerID
JOIN branches b
    ON a.BranchID = b.BranchID
GROUP BY
    b.BranchID,
    b.BranchName,
    b.City
ORDER BY Total_Loan_Amount DESC;







SELECT
    YEAR(TransactionDate) AS Transaction_Year,
    MONTH(TransactionDate) AS Transaction_Month,
    COUNT(TransactionID) AS Total_Transactions,
    SUM(Amount) AS Total_Transaction_Value
FROM transactions
GROUP BY
    YEAR(TransactionDate),
    MONTH(TransactionDate)
ORDER BY
    Transaction_Year,
    Transaction_Month;
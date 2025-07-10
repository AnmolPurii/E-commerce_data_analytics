-- --------------------------------------------
-- 📁 E-Commerce Analytics SQL Script
-- Author: Anmolpreet Puri
-- --------------------------------------------

-- 1. Create Tables

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(255) UNIQUE,
    DateOfBirth DATE,
    City VARCHAR(100)
);

CREATE TABLE Seller (
    SellerID INT PRIMARY KEY,
    Name VARCHAR(100),
    TotalSales DECIMAL(10,2)
);

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    MRP DECIMAL(10,2),
    Stock INT,
    SellerID INT,
    CategoryID INT,
    Brand VARCHAR(100),
    FOREIGN KEY (SellerID) REFERENCES Seller(SellerID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    ShippingDate DATE,
    OrderAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE OrderItem (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    MRP DECIMAL(10,2),
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    CustomerID INT,
    PaymentMode VARCHAR(50),
    PaymentDate DATE,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Review (
    ReviewID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Description VARCHAR(255),
    Rating INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- 2. Insert Sample Data

INSERT INTO Customer VALUES 
(101, 'Riya', 'Sharma', 'riya@email.com', '1999-05-12', 'Delhi'),
(102, 'Aryan', 'Mehta', 'aryan@email.com', '2000-08-22', 'Mumbai');

INSERT INTO Seller VALUES 
(501, 'boAt', 0.0),
(502, 'Nike', 0.0);

INSERT INTO Category VALUES 
(10, 'Electronics'),
(20, 'Footwear');

INSERT INTO Product VALUES 
(201, 'Bluetooth Speaker', 2499.00, 50, 501, 10, 'boAt'),
(202, 'Casual Shoes', 1299.00, 30, 502, 20, 'Nike');

INSERT INTO Orders VALUES 
(301, 101, '2024-06-20', '2024-06-22', 3798.00),
(302, 102, '2024-06-21', '2024-06-23', 1299.00);

INSERT INTO OrderItem VALUES 
(301, 201, 1, 2499.00),
(301, 202, 1, 1299.00),
(302, 202, 1, 1299.00);

INSERT INTO Payment VALUES 
(401, 301, 101, 'UPI', '2024-06-20'),
(402, 302, 102, 'Card', '2024-06-21');

INSERT INTO Review VALUES 
(601, 101, 201, 'Great sound quality', 5),
(602, 102, 202, 'Very comfortable', 4);

-- 3. Analytical Queries

-- Top 5 Best-Selling Products
SELECT 
    P.ProductName,
    SUM(OI.Quantity) AS TotalSold
FROM 
    OrderItem OI
JOIN Product P ON OI.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalSold DESC
LIMIT 5;

-- Top 5 Customers by Spend
SELECT 
    C.FirstName || ' ' || C.LastName AS CustomerName,
    SUM(O.OrderAmount) AS TotalSpent
FROM 
    Orders O
JOIN Customer C ON O.CustomerID = C.CustomerID
GROUP BY CustomerName
ORDER BY TotalSpent DESC
LIMIT 5;

-- Monthly Revenue Trend
SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS Month,
    SUM(OrderAmount) AS MonthlyRevenue
FROM Orders
GROUP BY Month
ORDER BY Month;

-- Top Sellers by Revenue
SELECT 
    S.Name AS SellerName,
    SUM(OI.Quantity * OI.MRP) AS TotalSales
FROM OrderItem OI
JOIN Product P ON OI.ProductID = P.ProductID
JOIN Seller S ON P.SellerID = S.SellerID
GROUP BY S.Name
ORDER BY TotalSales DESC;

-- Payment Method Distribution
SELECT 
    PaymentMode,
    COUNT(*) AS UsageCount
FROM Payment
GROUP BY PaymentMode;

-- Assignment: Database Design and Normalization
-- Student Name: __________________
-- Date: __________________________


/* ---------------------------------------------------------
   Question 1: Achieving 1NF
   ---------------------------------------------------------
   Problem:
   The Products column contains multiple values (comma-separated).
   Solution:
   Break it down so that each row represents a single product.
   --------------------------------------------------------- */

-- Original Table: ProductDetail
-- OrderID | CustomerName | Products

-- Create new 1NF-compliant table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Insert rows, one product per row
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Check result
SELECT * FROM ProductDetail_1NF;


/* ---------------------------------------------------------
   Question 2: Achieving 2NF
   ---------------------------------------------------------
   Problem:
   Table is in 1NF, but still has partial dependency:
   - CustomerName depends only on OrderID (not on the whole key).
   Solution:
   - Split the table into two:
     1) Orders (OrderID → CustomerName)
     2) OrderItems (OrderID, Product → Quantity)
   This ensures all non-key columns depend on the whole key.
   --------------------------------------------------------- */

-- Orders table (remove partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert distinct order-customer pairs
INSERT INTO Orders (OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- OrderItems table
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert rows
INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Check result
SELECT * FROM Orders;
SELECT * FROM OrderItems;

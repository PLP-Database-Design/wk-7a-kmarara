-- Question 1: Achieving 1NF
-- Transforming ProductDetail table to ensure each row represents a single product for an order

CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- Question 2: Achieving 2NF
-- Transforming OrderDetails table to remove partial dependencies

-- Step 1: Create a separate table for Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Insert unique orders into Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

-- Step 3: Create a separate table for OrderItems
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 4: Insert order items into OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;

-- E-commerce Sales Analysis SQL Script

-- 1. Drop existing tables (if they exist)
DROP TABLE Sales CASCADE CONSTRAINTS;
DROP TABLE Products CASCADE CONSTRAINTS;
DROP TABLE Customers CASCADE CONSTRAINTS;

-- 2. Create the Products table
CREATE TABLE Products (
    product_id NUMBER PRIMARY KEY,
    name VARCHAR2(255) NOT NULL,
    category VARCHAR2(100),
    price NUMBER(10, 2) NOT NULL
);

-- 3. Create the Customers table
CREATE TABLE Customers (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(255) NOT NULL,
    email VARCHAR2(255) UNIQUE NOT NULL,
    join_date DATE DEFAULT SYSDATE
);

-- 4. Create the Sales table
CREATE TABLE Sales (
    sale_id NUMBER PRIMARY KEY,
    product_id NUMBER NOT NULL,
    customer_id NUMBER NOT NULL,
    quantity NUMBER(5) NOT NULL,
    sale_date DATE DEFAULT SYSDATE,
    total_amount NUMBER(15, 2),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 5. Insert data into Products table
INSERT INTO Products (product_id, name, category, price) VALUES (1, 'Laptop', 'Electronics', 120000.00);
INSERT INTO Products (product_id, name, category, price) VALUES (2, 'Smartphone', 'Electronics', 60000.00);
INSERT INTO Products (product_id, name, category, price) VALUES (3, 'Headphones', 'Accessories', 3000.00);
INSERT INTO Products (product_id, name, category, price) VALUES (4, 'Desk Chair', 'Furniture', 7000.00);
INSERT INTO Products (product_id, name, category, price) VALUES (5, 'Monitor', 'Electronics', 15000.00);

-- 6. Insert data into Customers table with Indian names
INSERT INTO Customers (customer_id, name, email) VALUES (1, 'Rajesh Sharma', 'rajesh.sharma@example.com');
INSERT INTO Customers (customer_id, name, email) VALUES (2, 'Sunita Verma', 'sunita.verma@example.com');
INSERT INTO Customers (customer_id, name, email) VALUES (3, 'Amitabh Rao', 'amitabh.rao@example.com');
INSERT INTO Customers (customer_id, name, email) VALUES (4, 'Priya Mehta', 'priya.mehta@example.com');
INSERT INTO Customers (customer_id, name, email) VALUES (5, 'Vikram Singh', 'vikram.singh@example.com');

-- 7. Insert data into Sales table, calculate total_amount manually
INSERT INTO Sales (sale_id, product_id, customer_id, quantity, sale_date, total_amount) 
VALUES (1, 1, 1, 1, TO_DATE('2024-08-01', 'YYYY-MM-DD'), 1 * (SELECT price FROM Products WHERE product_id = 1));

INSERT INTO Sales (sale_id, product_id, customer_id, quantity, sale_date, total_amount) 
VALUES (2, 2, 2, 2, TO_DATE('2024-08-02', 'YYYY-MM-DD'), 2 * (SELECT price FROM Products WHERE product_id = 2));

INSERT INTO Sales (sale_id, product_id, customer_id, quantity, sale_date, total_amount) 
VALUES (3, 3, 3, 3, TO_DATE('2024-08-03', 'YYYY-MM-DD'), 3 * (SELECT price FROM Products WHERE product_id = 3));

INSERT INTO Sales (sale_id, product_id, customer_id, quantity, sale_date, total_amount) 
VALUES (4, 4, 4, 1, TO_DATE('2024-08-04', 'YYYY-MM-DD'), 1 * (SELECT price FROM Products WHERE product_id = 4));

INSERT INTO Sales (sale_id, product_id, customer_id, quantity, sale_date, total_amount) 
VALUES (5, 5, 5, 1, TO_DATE('2024-08-05', 'YYYY-MM-DD'), 1 * (SELECT price FROM Products WHERE product_id = 5));

-- 8. Basic Queries for Sales Analysis

-- 8.1 Total Sales Amount
SELECT SUM(total_amount) AS total_sales FROM Sales;

-- 8.2 Total Sales by Product
SELECT p.name AS product_name, SUM(s.total_amount) AS total_sales
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sales DESC;

-- 8.3 Total Sales by Category
SELECT p.category, SUM(s.total_amount) AS total_sales
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- 8.4 Total Sales by Customer
SELECT c.name AS customer_name, SUM(s.total_amount) AS total_sales
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
GROUP BY c.name
ORDER BY total_sales DESC;

-- 8.5 Sales Over Time (Daily Sales)
SELECT sale_date, SUM(total_amount) AS daily_sales
FROM Sales
GROUP BY sale_date
ORDER BY sale_date;

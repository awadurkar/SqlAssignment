-- Create database
CREATE DATABASE IF NOT EXISTS sql_assignment;
USE sql_assignment;

-- Create Customers table
CREATE TABLE IF NOT EXISTS Customers (
	customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    email VARCHAR(50) NOT NULL UNIQUE
    );
    
-- Create Products table
CREATE TABLE IF NOT EXISTS Products (
	product_id INT PRIMARY KEY,
	product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2)
    );

-- Create Orders table
CREATE TABLE IF NOT EXISTS Orders (
	order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers (customer_id),
    FOREIGN KEY (product_id) REFERENCES Products (product_id)
    );
    
-- Sample Data: 10 customers. Customer 10 intentionally has no orders.
INSERT INTO Customers (customer_id, customer_name, city, email) VALUES
	(1, 'Aarav Sharma', 'Mumbai', 'aarav.sharma@example.com'),
	(2, 'Diya Patel', 'Ahmedabad', 'diya.patel@example.com'),
	(3, 'Kabir Rao', 'Bengaluru', 'kabir.rao@example.com'),
	(4, 'Meera Iyer', 'Chennai', 'meera.iyer@example.com'),
	(5, 'Arjun Singh', 'Delhi', 'arjun.singh@example.com'),
	(6, 'Ananya Das', 'Kolkata', 'ananya.das@example.com'),
	(7, 'Vivaan Nair', 'Kochi', 'vivaan.nair@example.com'),
	(8, 'Sara Khan', 'Hyderabad', 'sara.khan@example.com'),
	(9, 'Ishaan Joshi', 'Pune', 'ishaan.joshi@example.com'),
	(10, 'Tara Menon', 'Jaipur', 'tara.menon@example.com');

-- Sample Data: 12 products in several categories and at a range of prices.
INSERT INTO Products (product_id, product_name, category, price) VALUES
	(1, 'Wireless Mouse', 'Electronics', 799.00),
	(2, 'Mechanical Keyboard', 'Electronics', 2499.00),
	(3, 'USB-C Hub', 'Electronics', 1599.00),
	(4, 'Bluetooth Speaker', 'Electronics', 3299.00),
	(5, 'Cotton Bedsheet', 'Home', 1299.00),
	(6, 'Desk Lamp', 'Home', 999.00),
	(7, 'Steel Water Bottle', 'Home', 499.00),
	(8, 'SQL Fundamentals', 'Books', 650.00),
	(9, 'Data Engineering Guide', 'Books', 1450.00),
	(10, 'Running Shoes', 'Sports', 3999.00),
	(11, 'Yoga Mat', 'Sports', 1199.00),
	(12, 'Leather Wallet', 'Accessories', 899.00);

-- Sample Data: 20 orders. Dates cover multiple years for Task 20.
INSERT INTO Orders (order_id, customer_id, product_id, quantity, order_date) VALUES
	(1, 1, 2, 1, '2024-01-15'),
	(2, 1, 8, 2, '2024-02-10'),
	(3, 2, 4, 1, '2024-03-05'),
	(4, 2, 5, 1, '2023-11-20'),
	(5, 3, 10, 1, '2024-04-18'),
	(6, 3, 1, 2, '2024-05-02'),
	(7, 4, 3, 1, '2023-12-12'),
	(8, 4, 9, 1, '2024-06-21'),
	(9, 5, 11, 2, '2024-07-09'),
	(10, 5, 6, 1, '2024-08-14'),
	(11, 6, 4, 1, '2023-09-30'),
	(12, 6, 12, 1, '2024-09-03'),
	(13, 7, 2, 1, '2024-10-11'),
	(14, 7, 7, 3, '2024-10-20'),
	(15, 8, 10, 1, '2023-07-04'),
	(16, 8, 3, 2, '2024-11-01'),
	(17, 9, 5, 2, '2024-11-15'),
	(18, 9, 8, 1, '2022-05-19'),
	(19, 1, 11, 1, '2025-01-08'),
	(20, 2, 1, 1, '2025-02-17');
    
-- Section 1: Advanced Joins
-- Task 1: Display each customer along with the products they ordered.
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    p.product_name,
    o.quantity,
    o.order_date
FROM Customers AS c
INNER JOIN Orders AS o ON o.customer_id = c.customer_id
INNER JOIN Products AS p ON p.product_id = o.product_id;

-- Task 2: Display all possible combinations of customers and products using a CROSS JOIN.
SELECT
    c.customer_id,
    c.customer_name,
    p.product_id,
    p.product_name
FROM Customers AS c
CROSS JOIN Products AS p
ORDER BY c.customer_id, p.product_id;

-- Task 3: Display all customers and their orders, including customers who have not placed any orders.
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    p.product_name,
    o.quantity,
    o.order_date
FROM Customers AS c
LEFT JOIN Orders AS o ON o.customer_id = c.customer_id
LEFT JOIN Products AS p ON p.product_id = o.product_id;

-- Section 2: Subqueries
-- Task 4: Find products priced above the average product price.
SELECT product_id, product_name, category, price
FROM Products
WHERE price > (SELECT AVG(price) FROM Products);

-- Task 5: Display customers whose total purchase amount is greater 
-- than the average customer purchase amount.
SELECT customer_totals.customer_id,
       customer_totals.customer_name,
       customer_totals.total_purchase_amount
FROM (
    SELECT c.customer_id,
           c.customer_name,
           COALESCE(SUM(p.price * o.quantity), 0) AS total_purchase_amount
    FROM Customers AS c
    LEFT JOIN Orders AS o ON o.customer_id = c.customer_id
    LEFT JOIN Products AS p ON p.product_id = o.product_id
    GROUP BY c.customer_id, c.customer_name
) AS customer_totals
WHERE customer_totals.total_purchase_amount > (
    SELECT AVG(customer_spend.total_purchase_amount)
    FROM (
        SELECT c.customer_id,
               COALESCE(SUM(p.price * o.quantity), 0) AS total_purchase_amount
        FROM Customers AS c
        LEFT JOIN Orders AS o ON o.customer_id = c.customer_id
        LEFT JOIN Products AS p ON p.product_id = o.product_id
        GROUP BY c.customer_id
    ) AS customer_spend
);

-- Task 6: Find the highest-priced product in each category using a correlated subquery.
SELECT p.product_id, p.product_name, p.category, p.price
FROM Products AS p
WHERE p.price = (
    SELECT MAX(p2.price)
    FROM Products AS p2
    WHERE p2.category = p.category
);


-- Section 3: Set Operations
-- Task 7: Combine products from two different categories using UNION.
SELECT
	product_id,
	product_name
FROM Products WHERE category = 'Electronics'
UNION
SELECT
	product_id,
	product_name
FROM Products WHERE category = 'Home';

-- Task 8: Write MySQL alternatives for INTERSECT and EXCEPT using INNER JOIN and LEFT JOIN.
-- 8a: INTERSECT Alternative (Finding Common Rows)
SELECT
	p1.*
FROM Products p1 INNER JOIN Products p2
	ON p1.product_id = p2.product_id
	AND p1.category = 'Home';
    
-- 8b: EXCEPT Alternative (Finding Unique Rows)
SELECT
	p1.*
FROM Products p1 LEFT JOIN Products p2
	ON p1.product_id = p2.product_id
    AND p1.category = 'Electronics'
WHERE p2.product_id IS NULL;


-- Section 4: Window Functions
-- Task 9: Rank products by price within each category.
SELECT
	product_name,
	category,
	price,
	RANK() OVER (PARTITION BY category ORDER BY price) AS product_rank
FROM Products;

-- Task 10: Display the previous product price (LAG) and a running total of product prices using window functions.
SELECT
	product_name,
	price,
	LAG(price) OVER (PARTITION BY category ORDER BY price) AS previous_price,
    SUM(price) OVER (PARTITION BY category ORDER BY price) AS running_total_price
FROM Products;


-- Section 5: Common Table Expressions (CTEs)
-- Task 11: Create a CTE to display customers whose total purchase amount is above the average.
WITH customer_totals AS (
    SELECT c.customer_id,
           c.customer_name,
           COALESCE(SUM(p.price * o.quantity), 0) AS total_purchase_amount
    FROM Customers AS c
    LEFT JOIN Orders AS o ON o.customer_id = c.customer_id
    LEFT JOIN Products AS p ON p.product_id = o.product_id
    GROUP BY c.customer_id, c.customer_name
), average_spend AS (
    SELECT AVG(total_purchase_amount) AS average_purchase_amount
    FROM customer_totals
)
SELECT ct.customer_id, ct.customer_name, ct.total_purchase_amount
FROM customer_totals AS ct
CROSS JOIN average_spend AS av
WHERE ct.total_purchase_amount > av.average_purchase_amount;

-- Task 12: Create a recursive CTE to generate a sequence of numbers from 1 to 10.
WITH RECURSIVE number_sequence (n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1
    FROM number_sequence
    WHERE n < 10
)
SELECT n
FROM number_sequence;


-- Section 6: Views
-- Task 13: Create a view that displays products priced above ₹1,000 and retrieve data from the view.
CREATE OR REPLACE VIEW Products_Above_1000 AS
SELECT * FROM Products WHERE price > 1000.00;

SELECT * FROM Products_Above_1000;


-- Section 7: Indexes and Query Performance
-- Task 14: Create an index on the category column of the Products table.
CREATE INDEX idx_products_category ON Products (category);

-- Task 15: Use EXPLAIN to analyze a query that filters products by category.
EXPLAIN SELECT * FROM Products WHERE category = 'Home';

-- Section 8: Stored Procedures and Functions
-- Task 16: Create a stored procedure to retrieve products by category.
DELIMITER //
CREATE PROCEDURE GetProductsByCategory(IN p_category VARCHAR(50))
BEGIN
	SELECT * FROM Products WHERE category = p_category;
END//
DELIMITER ;

CALL GetProductsByCategory('Home');

-- Task 17: Create a function to calculate the total price of an order (price × quantity).
DELIMITER //
CREATE FUNCTION CalculateOrderTotal(p_order_id INT)
RETURNS DECIMAL(20, 2)
READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(20, 2) DEFAULT 0.00;

    SELECT COALESCE(SUM(p.price * o.quantity), 0.00)
    INTO v_total
    FROM Orders AS o
    INNER JOIN Products AS p ON p.product_id = o.product_id
    WHERE o.order_id = p_order_id;

    RETURN v_total;
END//
DELIMITER ;

SELECT order_id, CalculateOrderTotal(order_id) AS order_total FROM Orders;

-- Section 9: Transactions
-- Task 18a: Update and COMMIT. This price change remains after the script runs.
START TRANSACTION;
UPDATE Products
SET price = price + 10.00
WHERE product_id = 1;
SELECT product_id, product_name, price
FROM Products
WHERE product_id = 1;
COMMIT;

-- Task 18b: Update and ROLLBACK. The extra Rs. 100 change is undone.
START TRANSACTION;
UPDATE Products
SET price = price + 100.00
WHERE product_id = 1;
ROLLBACK;

SELECT product_id, product_name, price
FROM Products
WHERE product_id = 1;


-- Section 10: SQL Triggers
-- Task 19: Create a trigger that automatically records new orders in an Order_Audit table whenever a new order is inserted.
CREATE TABLE IF NOT EXISTS Order_Audit (
    audit_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    audited_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;

DROP TRIGGER IF EXISTS trg_orders_after_insert;
DELIMITER //
CREATE TRIGGER trg_orders_after_insert
AFTER INSERT ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Order_Audit (order_id, customer_id, product_id, quantity, order_date)
    VALUES (NEW.order_id, NEW.customer_id, NEW.product_id, NEW.quantity, NEW.order_date);
END//
DELIMITER ;

-- Demonstrate the trigger with order 21. Run this insert once on the fresh data.
INSERT INTO Orders (order_id, customer_id, product_id, quantity, order_date)
VALUES (21, 10, 1, 1, CURRENT_DATE);

SELECT audit_id, order_id, customer_id, product_id, quantity, order_date, audited_at
FROM Order_Audit
WHERE order_id = 21;


-- Section 11: Performance Tuning
-- Task 20: Optimize the queries by applying SQL performance tuning best practices
CREATE INDEX idx_orders_order_date ON Orders (order_date);

SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    p.product_id,
    p.product_name,
    p.category,
    o.quantity,
    p.price
FROM Orders AS o
INNER JOIN Customers AS c ON c.customer_id = o.customer_id
INNER JOIN Products AS p ON p.product_id = o.product_id
WHERE p.category = 'Electronics'
  AND o.order_date >= '2024-01-01'
  AND o.order_date < '2025-01-01'
ORDER BY o.order_date, o.order_id;

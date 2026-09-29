-- Create database
CREATE DATABASE IF NOT EXISTS sql_assignment;
USE sql_assignment;

-- Create Authors Table
CREATE TABLE IF NOT EXISTS Authors (
	author_id INT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL
    );

-- Create Books Table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author_id INT NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    published_year INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

INSERT INTO Authors (author_id, author_name, country) VALUES
	(1, 'Anita Desai', 'India'),
	(2, 'George Orwell', 'United Kingdom'),
	(3, 'Ursula Le Guin', 'United States'),
	(4, 'Kazuo Ishiguro', 'Japan'),
	(5, 'Chinua Achebe', 'Nigeria');

INSERT INTO Books (book_id, title, author_id, category, price, published_year) VALUES
	(1, 'SQL for Beginners', 1, 'Programming', 550.00, 2021),
	(2, 'Software Design Patterns', 2, 'Programming', 820.00, 2022),
	(3, 'The Silent Forest', 3, 'Fiction', 640.00, 2019),
	(4, 'Stories of Tomorrow', 4, 'Fiction', 720.00, 2023),
	(5, 'Data Science Essentials', 5, 'Programming', 900.00, 2024),
	(6, 'A Brief History of Time', 1, 'Science', 780.00, 2018),
	(7, 'Space and Beyond', 2, 'Science', 680.00, 2021),
	(8, 'The Art of Writing', 3, 'Education', 500.00, 2020),
	(9, 'Success Through Practice', 4, 'Education', 700.00, 2022),
	(10, 'Modern World History', 5, 'History', 860.00, 2017);
    
-- Section 1: Basic Queries
-- Task 1: Display all books.
SELECT * FROM Books;

-- Task 2: Display only the book title and price.
SELECT title, price FROM Books;
    
-- Task 3: Display the book title as Book Name and price as Book Price using column aliases.
SELECT 
	title AS 'Book Title',
    price AS 'Book Price'
FROM Books;

-- Task 4: Display all unique book categories.
SELECT DISTINCT category FROM Books;

-- Section 2: Filtering Data
-- Task 5: Display books priced above ₹700.
SELECT * FROM Books WHERE price > 700;

-- Task 6: Display books priced between ₹500 and ₹800.
SELECT * FROM Books WHERE price BETWEEN 500 AND 800;

-- Task 7: Display books that belong to the Programming category.
SELECT * FROM Books WHERE category = 'Programming';

-- Task 8: Display books whose titles start with the letter S.
SELECT * FROM Books WHERE title like 'S%';

-- Task 9: Display books published after 2020.
SELECT * FROM Books WHERE published_year > 2020;

-- Section 3: Sorting and Limiting Results
-- Task 10: Display books sorted by price in descending order.
SELECT * FROM Books ORDER BY price DESC;

-- Task 11: Display the top 3 most expensive books.
SELECT * FROM Books ORDER BY price DESC LIMIT 3;

-- Section 4: Aggregate Functions
-- Task 12: Find:
		-- Total number of books
		-- Total price of all books
		-- Average book price
		-- Highest book price
		-- Lowest book price

SELECT 
	COUNT(*) AS 'Total number of books',
	SUM(price) AS 'Total price of all books',
	AVG(price) AS 'Average book price',
	MAX(price) AS 'Highest book price',
	MIN(price) AS 'Lowest book price'
FROM Books;

-- Section 5: GROUP BY and HAVING
-- Task 13: Display the average book price for each category.
SELECT 
	category, AVG(price) AS 'Avrage Price'
FROM Books
GROUP BY category;

-- Task 14: Display only those categories whose average book price is greater than ₹650.
SELECT 
	category, AVG(price) AS 'Avrage Price'
	FROM Books
GROUP BY category
HAVING AVG(price) > 650;


-- Section 6: Joins
-- Task 15: Display each book along with its author's name using an INNER JOIN.
SELECT
	b.title,
    b.category,
    b.price,
    b.published_year,
    a.author_name
FROM Books b 
INNER JOIN Authors a
ON b.author_id = a.author_id;

-- Task 16: Display all authors along with the books they have written using a LEFT JOIN.
SELECT
	b.title,
    a.author_name
FROM Books b 
LEFT JOIN Authors a
ON b.author_id = a.author_id;

-- Task 17: Display all books along with their author details using a RIGHT JOIN.
SELECT
	b.title,
    a.*
FROM Books b 
RIGHT JOIN Authors a
ON b.author_id = a.author_id;

-- Section 7: Data Manipulation
-- Task 18: Insert a new book into the Books table.
INSERT INTO Books (book_id, title, author_id, category, price, published_year)
	VALUES (11, 'JAVA Fundamentals', 1, 'Programming', 1000.00, 2027);
    
-- Task 19: Update the price of the book you inserted.
UPDATE Books SET price = 1200.00 WHERE book_id = 11;

-- Task 20: Delete the book record that you inserted.
DELETE FROM Books WHERE book_id = 11;

-- Section 8: Creating Tables and Constraints
-- Task 21: Create a new table named Publishers with the following columns:
		-- publisher_id
		-- publisher_name
		-- country
		-- established_year
-- Apply the following constraints:
		-- PRIMARY KEY
		-- NOT NULL
		-- UNIQUE
		-- DEFAULT
CREATE TABLE Publishers (
    publisher_id INT PRIMARY KEY,
    publisher_name VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(50) NOT NULL,
    established_year INT NOT NULL DEFAULT 2026
);




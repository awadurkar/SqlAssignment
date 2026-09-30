# Advanced SQL Assignment: Online Shopping Platform

## Overview

This assignment models an online shopping platform and demonstrates advanced SQL for reporting, sales analysis, database automation, transaction management, and query performance. The complete, sectioned solution is in [sql_advance_assignment.sql](sql_advance_assignment.sql).

## Database Schema

- `Customers`: `customer_id` (primary key), `customer_name`, `city`, `email`
- `Products`: `product_id` (primary key), `product_name`, `category`, `price`
- `Orders`: `order_id` (primary key), `customer_id` and `product_id` (foreign keys), `quantity`, `order_date`
- `Order_Audit`: records order details and the audit timestamp when a new order is inserted

The sample data includes 10 customers, 12 products, and 20 initial orders. One customer intentionally has no orders so the outer join can demonstrate retaining customers with no matching order. The trigger section inserts one additional sample order for its audit demonstration.

## Requirements

- MySQL 8.0 or newer
- A MySQL account with permission to create a database, tables, indexes, views, stored procedures, functions, and triggers

## Run

From this directory, run the script with your MySQL credentials:

```sh
mysql -u your_username -p < sql_advance_assignment.sql
```

The script creates and selects the `sql_assignment` database. Run it against a clean database and only once: the sample inserts, indexes, routine definitions, and trigger demonstration are not all repeatable. Do not drop an existing `sql_assignment` database if it contains data you need.

## Concepts Covered

- Advanced joins: `INNER JOIN`, `CROSS JOIN`, and `LEFT JOIN`
- Subqueries, including correlated subqueries and average-spend comparisons
- `UNION` and MySQL join-based alternatives for `INTERSECT` and `EXCEPT`
- Window functions: `RANK`, `LAG`, and running totals
- Common Table Expressions (CTEs), including a recursive CTE
- Views and indexes
- Query-plan analysis with `EXPLAIN`
- Stored procedures and functions
- Transactions with `COMMIT` and `ROLLBACK`
- Triggers and order auditing
- Performance tuning with explicit columns and index-friendly date ranges

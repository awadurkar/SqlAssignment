# SQL Basic Assignment

A SQL exercise using a small library catalog. The script creates an `sql_assignment` database, defines `Authors` and `Books` tables, inserts sample records, and demonstrates common SQL operations.

## Requirements

- MySQL 8.0 or a compatible MySQL client/server

## Run

From this directory, run the script with a MySQL account that can create databases and tables:

```sh
mysql -u your_username -p < sql_basic_assignment.sql
```

The script selects the `sql_assignment` database after creating it. Run it against a clean database: although the database creation is guarded, the table creation and sample inserts are not designed for repeated execution and may fail on a second run.

## Topics Covered

- Selecting columns and using aliases
- `DISTINCT`, `WHERE`, `BETWEEN`, and `LIKE`
- Sorting and limiting results
- Aggregate functions, `GROUP BY`, and `HAVING`
- `INNER JOIN`, `LEFT JOIN`, and `RIGHT JOIN`
- Inserting, updating, and deleting rows
- Creating a table with primary key, not-null, unique, and default constraints

The script includes 21 numbered tasks, followed by the `Publishers` table definition.
🛒 E-commerce Transactions Analysis (SQL Project)
📌 Project Overview

This project analyzes an E-commerce transactions dataset using MySQL to answer key business questions related to revenue, sales performance, discounts, and payment behavior.
The objective is to simulate a real-world business scenario and demonstrate practical SQL skills for data analytics roles.
🗂 Dataset Information

Database: sql_portfolio_projects
Dataset: ecommerce_transactions
Source: Kaggle
| Column Name    | Description                |
| -------------- | -------------------------- |
| user_id        | Unique customer identifier |
| product_id     | Unique product identifier  |
| category       | Product category           |
| price          | Original product price     |
| discount       | Discount applied           |
| final_price    | Final price paid           |
| payment_method | Payment method used        |
| purchase_date  | Date of transaction        |
🎯 Business Questions

Which product categories generate the highest revenue?
How does sales performance change over time?
Which product categories receive the most discounts?
What is the most used payment method and the maximum purchase per method?

🧹 Data Cleaning & Validation
Before conducting analysis, the dataset was validated using SQL:
Checked total number of rows
Verified column structure and data types
Identified missing values
Checked duplicate transactions
Validated logical inconsistencies:
Negative prices
Invalid discount values
Final price greater than original price
Verified transaction date range
This ensured data accuracy and reliability before answering business questions.

⚙️ Analysis Approach
The analysis was performed using:
Aggregation functions (SUM, COUNT, AVG, MAX)
GROUP BY and ORDER BY
Date functions (YEAR, MONTH)
ALTER TABLE and UPDATE
Business-driven SQL queries
🛠 Skills Demonstrated

SQL data cleaning
Business problem translation into queries
Aggregation & grouping
Time-based analysis
Structured project documentation
Writing production-ready SQL

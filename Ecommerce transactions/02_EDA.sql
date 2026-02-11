-- ============================================================
-- SQL Portfolio Project
-- File: 02_exploratory_data_analysis.sql
-- Project: E-commerce Transactions Analysis
-- Database: sql_portfolio_projects
-- Dataset: ecommerce_transactions
-- Objective: Analyze sales patterns, revenue, discounts, and payment behavior
-- ============================================================


-- ============================================================
-- 1️⃣ Business Problems / Questions
-- ============================================================
-- 1. Which products or categories generate the highest revenue and why?
-- 2. How does sales performance change over time?
-- 3. Which product categories receive the most discounts?
-- 4. What is the most used payment method and the maximum purchase per method?


-- ============================================================
-- 2️⃣ Basic Data Quality Checks (EDA)
-- ============================================================

-- ---- 2.1 Quick Dataset Overview ----
-- Check total number of rows
SELECT COUNT(*) AS total_rows
FROM ecommerce_transactions;

-- View columns, data types, and nullability
DESCRIBE ecommerce_transactions;


-- ---- 2.2 Missing Values Check ----
-- Count missing values in key columns
SELECT
    SUM(price IS NULL) AS price_nulls,
    SUM(final_price IS NULL) AS final_price_nulls,
    SUM(category IS NULL) AS category_nulls,
    SUM(purchase_date IS NULL) AS purchase_date_nulls
FROM ecommerce_transactions;


-- ---- 2.3 Duplicate Records Check ----
-- Identify users who bought the same product on the same day more than once
SELECT
    user_id,
    product_id,
    purchase_date,
    COUNT(*) AS duplicate_count
FROM ecommerce_transactions
GROUP BY user_id, product_id, purchase_date
HAVING duplicate_count > 1;


-- ---- 2.4 Logical Value Checks ----
-- Transactions with negative price or final_price
SELECT *
FROM ecommerce_transactions
WHERE price < 0 OR final_price < 0;

-- Discounts outside the valid 0-100% range
SELECT *
FROM ecommerce_transactions
WHERE discount < 0 OR discount > 100;

-- Ensure final_price does not exceed original price
SELECT *
FROM ecommerce_transactions
WHERE final_price > price;


-- ---- 2.5 Optional Categorical Checks ----
-- Transaction count by product category
SELECT category, COUNT(*) AS total_transactions
FROM ecommerce_transactions
GROUP BY category;

-- Transaction count by payment method
SELECT payment_method, COUNT(*) AS total_transactions
FROM ecommerce_transactions
GROUP BY payment_method;


-- ---- 2.6 Optional Date Range Check ----
-- Identify earliest and latest purchase dates
SELECT
    MIN(purchase_date) AS earliest_purchase,
    MAX(purchase_date) AS latest_purchase
FROM ecommerce_transactions;


-- ============================================================
-- 3️⃣ Business Problem 1.1: Highest Revenue by Category
-- ============================================================

-- Add a new revenue column
ALTER TABLE ecommerce_transactions
ADD COLUMN revenue DECIMAL(10,2);

-- Fill the revenue column
UPDATE ecommerce_transactions
SET revenue = price - discount;

-- Aggregate total revenue by category
SELECT category,
       SUM(revenue) AS total_revenue_per_category
FROM ecommerce_transactions
GROUP BY category
ORDER BY total_revenue_per_category DESC;

-- Insight 1.1:
-- Clothing category generates the highest revenue,
-- likely due to higher prices and frequent purchases.


-- ============================================================
-- 4️⃣ Business Problem 1.2: Sales Performance Over Time
-- ============================================================

-- Aggregate total revenue by year and month
SELECT
    YEAR(purchase_date) AS year,
    MONTH(purchase_date) AS month,
    SUM(revenue) AS total_revenue
FROM ecommerce_transactions
GROUP BY YEAR(purchase_date), MONTH(purchase_date)
ORDER BY year ASC, month ASC;

-- Insight 1.2:
-- Revenue shows seasonal fluctuations throughout the year,
-- which may be influenced by promotions, holidays, or customer buying behavior.


-- ============================================================
-- 5️⃣ Business Problem 1.3: Categories with the Most Discounts
-- ============================================================

-- Aggregate total discount by category (top 5)
SELECT category,
       SUM(discount) AS total_discount_by_category
FROM ecommerce_transactions
GROUP BY category
ORDER BY total_discount_by_category DESC
LIMIT 5;

-- Insight 1.3:
-- Home & Kitchen and Textiles categories receive the highest total discounts,
-- likely due to promotions and seasonal campaigns.


-- ============================================================
-- 6️⃣ Business Problem 1.4: Most Used Payment Method & Maximum Purchase
-- ============================================================

SELECT 
    payment_method,
    COUNT(*) AS total_transactions,
    MAX(final_price) AS max_purchase
FROM ecommerce_transactions
GROUP BY payment_method
ORDER BY total_transactions DESC
LIMIT 1;

-- Insight 1.4:
-- Credit Card is the most frequently used payment method,
-- with the maximum single purchase of 492.41,
-- showing both popularity and high-value transactions.

/********************************************************************************************
    PROJECT: Retail Sales Dataset
    STEP: Exploratory Data Analysis (EDA)
    DATABASE: sql_portfolio_projects
    DESCRIPTION:
    This script performs exploratory data analysis on the cleaned retail_sales2 dataset.
    The analysis focuses on:
        1. Customer behavior by age and gender
        2. Sales patterns over time
        3. Top product categories
        4. Relationships between age, spending, and product preferences
********************************************************************************************/

-- ==========================================================================================
-- STEP 0: Use Project Database
-- ==========================================================================================

USE sql_portfolio_projects;

-- Preview cleaned dataset
SELECT * FROM retail_sales2;

-- ==========================================================================================
-- BUSINESS PROBLEMS ADDRESSED
-- ==========================================================================================
-- 1. Understand customer behavior by demographics (age, gender)
-- 2. Identify sales trends and seasonality
-- 3. Determine top-performing product categories
-- 4. Analyze relationships between age, spending, and product preferences

-- ==========================================================================================
/********************************************************************************************
    BUSINESS PROBLEM 1: CUSTOMER BEHAVIOR BY AGE AND GENDER
    OBJECTIVE: Understand how demographics influence purchasing patterns
               to enable targeted marketing and personalized offers
********************************************************************************************/

-- 1.1 Total spending and transactions per age/gender group
SELECT 
    Gender,
    Age,
    SUM(Total_amount) AS total_spent,       -- Total revenue per group
    COUNT(*) AS total_transactions,         -- Total transactions per group
    AVG(Total_amount) AS avg_spent          -- Average spending per transaction
FROM retail_sales2
GROUP BY Gender, Age
ORDER BY Gender, Age;

-- 1.2 Quantity purchased per age/gender group
SELECT 
    Gender,
    Age,
    SUM(Quantity) AS total_quantity,        -- Total items purchased
    AVG(Quantity) AS avg_quantity           -- Average items per transaction
FROM retail_sales2
GROUP BY Gender, Age
ORDER BY Gender, Age;

-- 1.3 Product category preferences per age/gender group
SELECT 
    Gender,
    Age,
    Product_category,
    COUNT(*) AS transactions_count,         -- Number of transactions per category
    SUM(Total_amount) AS total_spent        -- Total spending per category
FROM retail_sales2
GROUP BY Gender, Age, Product_category
ORDER BY Gender, Age, total_spent DESC;

-- ==========================================================================================
/********************************************************************************************
    BUSINESS PROBLEM 2: SALES PATTERNS OVER TIME
    OBJECTIVE: Identify trends and seasonal variations in sales
               to support inventory management and marketing planning
********************************************************************************************/

SELECT 
    YEAR(Date) AS year,                      -- Extract year
    MONTH(Date) AS month,                    -- Extract month
    SUM(Total_amount) AS total_sales,        -- Total revenue per month
    COUNT(Transaction_id) AS total_transactions,  -- Total transactions per month
    SUM(Quantity) AS total_items_sold        -- Total items sold
FROM retail_sales2
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY year, month;

-- ==========================================================================================
/********************************************************************************************
    BUSINESS PROBLEM 3: TOP PRODUCT CATEGORIES
    OBJECTIVE: Determine which products are most popular to optimize
               stock, promotions, and marketing strategies
********************************************************************************************/

-- 3.1 Overall performance of each product category
SELECT 
    Product_category,
    SUM(Total_amount) AS total_sales,        -- Total revenue per category
    SUM(Quantity) AS total_items_sold,       -- Total items sold per category
    COUNT(Transaction_id) AS total_transactions  -- Total transactions per category
FROM retail_sales2
GROUP BY Product_category
ORDER BY total_sales DESC;

-- 3.2 Spending by age and product category
-- Objective: Understand age-wise product preferences and spending
SELECT 
    Age,
    Product_category,
    SUM(Total_amount) AS total_spent,        -- Total revenue per age/category
    SUM(Quantity) AS total_quantity,         -- Total items purchased per age/category
    COUNT(Transaction_id) AS total_transactions  -- Transactions per age/category
FROM retail_sales2
GROUP BY Age, Product_category
ORDER BY Age, total_spent DESC;

-- ==========================================================================================
/********************************************************************************************
    SUMMARY
    - Customer spending and purchase patterns analyzed by age and gender
    - Monthly and seasonal sales trends identified
    - Top-performing product categories determined
    - Relationships between age, spending, and product preferences explored

    The dataset retail_sales2 is now ready to inform business decisions,
    marketing strategies, and inventory planning.
********************************************************************************************/

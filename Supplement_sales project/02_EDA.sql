-- SQL PORTFOLIO PROJECT
-- Purpose: Exploratory Data Analysis (EDA) on supplement_sales2 dataset
-- Tools: MySQL / SQL Workbench
USE sql_Portfolio_projects;
-- View all available data
SELECT * FROM supplement_sales2;
-- Basic EDA queries I.E COUNT ROWS, DATA QUALITY CHECKS I.E MISSING VALUES & DUPLICATES,SUMMARY STATISTICS: 
-- 1_Missing values:
SELECT COUNT(*) - COUNT(*) AS missing_values
FROM supplement_sales2;
-- 2.Duplicate values:
SELECT date, COUNT(*) 
FROM supplement_sales2
GROUP BY date
HAVING COUNT(*) > 1;
-- 3.Summary statistics:
-- price column
SELECT MIN(Price), MAX(Price), AVG(Price), SUM(Price)
FROM supplement_sales2;
-- Units_sold column
SELECT MIN(Units_sold), MAX(Units_sold), AVG(Units_sold), SUM(Units_sold)
FROM supplement_sales2;
-- Units_sold column
SELECT MIN(revenue), MAX(revenue), AVG(revenue), SUM(revenue)
FROM supplement_sales2;
-- Discount column
SELECT MIN(Discount), MAX(Discount)
FROM supplement_sales2;
SELECT MIN(Units_returned), MAX(Units_returned), AVG(Units_returned), SUM(Units_returned)
FROM supplement_sales2;
-- DEEP EXPLORATORY DATA ANALYSIS (DEDA)
-- The goal is to explore the dataset, identify patterns, trends, or insights.
-- We will analyze discounts, revenue, categories, platforms, and time trends.
-- ====================================================================
-- problem_1: Which countries give the most discounts or promotions?
-- Goal: Find the average discount offered by each country to identify
--       which locations are more promotion-heavy.
-- Skills: GROUP BY, AGGREGATION (AVG)
SELECT 
    location,
    AVG(discount) AS avg_discount
FROM supplement_sales2
GROUP BY location
order by avg_discount desc;
-- Insight:
-- This query helps identify which countries tend to offer higher discounts
-- Insight: The United States offers the highest average discount (12.75%), 
-- slightly ahead of Canada (12.74%) and the 
-- United Kingdom (12.59%), indicating a highly competitive promotional strategy in North American markets.

-- problem_2: Which are the top 5 categories and platforms generating the most revenue?
-- 
-- Goal: Identify the most profitable combinations of product category 
--       and sales platform.
-- Skills: GROUP BY, SUM, ORDER BY, LIMIT, CTE

-- (check and View all data)
SELECT * FROM supplement_sales2;

-- Step 1: Aggregate total revenue per category and platform
SELECT 
    category,
    platform,
    SUM(revenue) AS sum_rev_product_and_platform
FROM supplement_sales2
GROUP BY category, platform
ORDER BY sum_rev_product_and_platform DESC
LIMIT 5;

-- Step 2: Use a CTE for a clean, reusable query structure
WITH product_totals AS (
    SELECT 
        category,
        platform,
        SUM(revenue) AS total_revenue
    FROM supplement_sales2
    GROUP BY category, platform
    ORDER BY total_revenue DESC
    LIMIT 5
)
SELECT * FROM product_totals;

-- Insight:
-- Minerals from the platform “iHerb” generated the maximum revenue in this dataset,
-- outperforming other platforms such as Amazon.

-- problem_3: How does revenue grow or decline over the years?
-- Goal: Analyze revenue growth trend year over year.
-- Skills: CTE, WINDOW FUNCTION (LAG), CALCULATIONS, ROUNDING

WITH yearly_revenue AS (
    SELECT 
        YEAR(date) AS year,
        SUM(revenue) AS total_revenue
    FROM supplement_sales2
    GROUP BY YEAR(date)
)
SELECT
    year,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY year) AS prev_year_revenue,
    total_revenue - LAG(total_revenue) OVER (ORDER BY year) AS revenue_change,
    ROUND(
        (total_revenue - LAG(total_revenue) OVER (ORDER BY year)) 
        / LAG(total_revenue) OVER (ORDER BY year) * 100, 2
    ) AS growth_percentage
FROM yearly_revenue
ORDER BY year;

-- Insight:
-- Each row shows the total revenue for that year and compares it to the previous year.
-- Positive growth_percentage = revenue increased.
-- Negative growth_percentage = revenue declined.

-- problem_4: Which platforms perform the best overall?
-- Goal: Identify top-performing platforms by total revenue and units sold.
-- Skills: GROUP BY, CTE, AGGREGATION, WINDOW FUNCTION (SUM OVER)
-- (check and  View raw data)
SELECT * FROM supplement_sales2;
-- Step 1: Basic aggregation
SELECT 
    platform,
    SUM(units_sold) AS total_units_sold,
    SUM(revenue) AS total_revenue
FROM supplement_sales2
GROUP BY platform
ORDER BY total_revenue DESC;

-- Step 2: Add percentage share for deeper insight
WITH best_performing AS (
    SELECT 
        platform,
        SUM(units_sold) AS total_units_sold,
        SUM(revenue) AS total_revenue
    FROM supplement_sales2
    GROUP BY platform
),
platform_share AS (
    SELECT 
        platform,
        total_units_sold,
        total_revenue,
        CONCAT(
            ROUND(total_revenue * 100.0 / SUM(total_revenue) OVER (), 2), '%'
        ) AS revenue_percentage
    FROM best_performing
)
SELECT * 
FROM platform_share
ORDER BY total_revenue DESC;

-- Insight:
-- Displays each platform’s total revenue, total units sold, and its percentage 
-- contribution to the overall revenue.
-- Platform performing: iHerb contributes 34.28% of total revenue, making it the top performer.

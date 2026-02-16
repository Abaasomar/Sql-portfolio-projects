/********************************************************************************************
    PROJECT: Retail Sales Dataset
    STEP: Exploratory Data Analysis (EDA)
    DATABASE: sql_portfolio_projects
    DESCRIPTION:
    This script performs exploratory data analysis on the cleaned retail_sales2 dataset.
    The analysis focuses on:
        1. Customer behavior by age and gender
        2. Sales patterns over time
        3. Top product categories (overall and by age)
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
-- 2. Identify sales trends and seasonal variations
-- 3. Determine top-performing product categories
-- 4. Analyze age-wise product preferences

-- ==========================================================================================
/********************************************************************************************
    BUSINESS PROBLEM 1: CUSTOMER BEHAVIOR BY AGE AND GENDER
    OBJECTIVE: Understand how demographics influence purchasing patterns to enable targeted
               marketing and personalized offers
********************************************************************************************/

-- 1.1 Top 5 Age/Gender Groups by Average Spending
SELECT 
    Gender,
    Age,
    SUM(Total_amount) AS total_spent,       
    COUNT(*) AS total_transactions,         
    AVG(Total_amount) AS avg_spent          
FROM retail_sales2
GROUP BY Gender, Age
ORDER BY avg_spent DESC, Age ASC
LIMIT 5;

-- 1.2 Total and Average Quantity Purchased by Age and Gender
SELECT 
    Gender,
    Age,
    SUM(Quantity) AS total_quantity,        
    AVG(Quantity) AS avg_quantity           
FROM retail_sales2
GROUP BY Gender, Age
ORDER BY Gender ASC, Age ASC;

-- 1.3 Product Category Preferences by Age and Gender
SELECT 
    Gender,
    Age,
    Product_category,
    COUNT(*) AS transactions_count,         
    SUM(Total_amount) AS total_spent        
FROM retail_sales2
GROUP BY Gender, Age, Product_category
ORDER BY Gender ASC, Age ASC, total_spent DESC;

-- ==========================================================================================
/********************************************************************************************
    BUSINESS PROBLEM 2: SALES PATTERNS OVER TIME
    OBJECTIVE: Identify trends and seasonal variations in sales to support inventory
               management and marketing planning
********************************************************************************************/

SELECT 
    YEAR(Date) AS year,                      
    MONTH(Date) AS month,                    
    SUM(Total_amount) AS total_sales,        
    COUNT(Transaction_id) AS total_transactions,  
    SUM(Quantity) AS total_items_sold        
FROM retail_sales2
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY year ASC, month ASC;

-- ==========================================================================================
/********************************************************************************************
    BUSINESS PROBLEM 3: TOP PRODUCT CATEGORIES
    OBJECTIVE: Determine which products are most popular and contribute most to revenue
********************************************************************************************/

-- 3.1 Overall Performance of Each Product Category
SELECT 
    Product_category,
    SUM(Total_amount) AS total_sales,        
    SUM(Quantity) AS total_items_sold,       
    COUNT(Transaction_id) AS total_transactions  
FROM retail_sales2
GROUP BY Product_category
ORDER BY total_sales DESC;

-- 3.2 Age-Based Spending by Product Category
SELECT 
    Age,
    Product_category,
    SUM(Total_amount) AS total_spent,        
    SUM(Quantity) AS total_quantity,         
    COUNT(Transaction_id) AS total_transactions  
FROM retail_sales2
GROUP BY Age, Product_category
ORDER BY Age ASC, total_spent DESC;

-- ==========================================================================================
/********************************************************************************************
    SUMMARY
    - Top age/gender segments by spending identified
    - Quantity and spending patterns analyzed by demographics
    - Monthly sales trends evaluated for seasonality
    - Product category performance analyzed overall and by age
    - Dataset ready for further business insights, reporting, and visualization
********************************************************************************************/

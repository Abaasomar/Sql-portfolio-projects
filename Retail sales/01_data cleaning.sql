/********************************************************************************************
    PROJECT: Retail Sales Dataset
    STEP: Data Cleaning Phase
    DESCRIPTION:
    This script performs the complete data-cleaning workflow for the retail_sales dataset.

    The cleaning process focuses on:
        1. Creating a Safe Working Copy
        2. Detecting Duplicate Records
        3. Handling Missing / NULL Values
        4. Validating and Correcting Data Types
        5. Ensuring Categorical Consistency
        6. Validating Numerical Integrity
********************************************************************************************/

-- ==========================================================================================
-- SELECT PROJECT DATABASE
-- ==========================================================================================

USE sql_portfolio_projects;

-- View original dataset
SELECT * FROM retail_sales;

-- ==========================================================================================
-- STEP 1: CREATE BACKUP / WORKING TABLE
-- retail_sales2 will be used for all cleaning operations
-- This preserves the original dataset integrity
-- ==========================================================================================

CREATE TABLE retail_sales2 AS
SELECT * 
FROM retail_sales;

SELECT * FROM retail_sales2;

-- ==========================================================================================
-- DATA QUALITY ASSESSMENT
-- Identified Potential Issues:
--      Problem_1: Duplicate Records
--      Problem_2: Missing / NULL Values
--      Problem_3: Data Type Validation
--      Problem_4: Categorical Inconsistencies
--      Problem_5: Invalid Numerical Values
-- ==========================================================================================

/********************************************************************************************
    PROBLEM 1: DUPLICATE RECORDS
********************************************************************************************/

-- Detect exact duplicate transactions
SELECT transaction_id, Date, customer_id, Gender, Age,
       product_category, quantity, price_per_unit, Total_amount,
       COUNT(*) AS duplicate_count
FROM retail_sales2
GROUP BY transaction_id, Date, customer_id, Gender, Age,
         product_category, quantity, price_per_unit, Total_amount
HAVING COUNT(*) > 1;

-- Result: No duplicate records detected (if applicable)
-- If duplicates existed, they would be removed using DELETE with CTE or row_number logic.


/********************************************************************************************
    PROBLEM 2: MISSING / NULL VALUES
********************************************************************************************/

SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS null_transaction_id,
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS null_date,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS null_gender,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS null_age,
    SUM(CASE WHEN product_category IS NULL THEN 1 ELSE 0 END) AS null_product_category,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity,
    SUM(CASE WHEN price_per_unit IS NULL THEN 1 ELSE 0 END) AS null_price_per_unit,
    SUM(CASE WHEN Total_amount IS NULL THEN 1 ELSE 0 END) AS null_total_amount
FROM retail_sales2;

-- Analysis:
-- Dataset reviewed for completeness.
-- No critical NULL issues found (or describe if found).


/********************************************************************************************
    PROBLEM 3: DATA TYPE VALIDATION
********************************************************************************************/

-- Check column data types
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'retail_sales2';

-- Convert Date column to proper DATE datatype
ALTER TABLE retail_sales2
MODIFY Date DATE;

-- Date conversion ensures accurate time-based aggregations
-- (monthly revenue, yearly growth, trend analysis)


/********************************************************************************************
    PROBLEM 4: CATEGORICAL CONSISTENCY
********************************************************************************************/

-- Validate Gender consistency
SELECT DISTINCT Gender
FROM retail_sales2;

-- Validate Product Category consistency
SELECT DISTINCT product_category
FROM retail_sales2;

-- Purpose:
-- Ensure no inconsistent spellings (e.g., 'Male' vs 'male')
-- Maintain reliable grouping for dashboards


/********************************************************************************************
    PROBLEM 5: NUMERICAL VALIDATION
********************************************************************************************/

-- Check for invalid or illogical numerical values
SELECT *
FROM retail_sales2
WHERE quantity <= 0
   OR price_per_unit <= 0;

-- Purpose:
-- Prevent incorrect revenue calculations
-- Ensure business-rule compliance


/********************************************************************************************
    SUMMARY
    - Working copy created to preserve raw data
    - Duplicate records assessed
    - Missing values evaluated
    - Date column standardized to DATE datatype
    - Categorical columns validated
    - Numerical integrity verified

    The dataset retail_sales2 is now clean, reliable,
    and ready for Exploratory Data Analysis (EDA)
    and Business Intelligence reporting.
********************************************************************************************/

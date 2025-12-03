/********************************************************************************************
    PROJECT: Grocery Store Sales Dataset (2025)
    STEP: Data Cleaning Phase
    DESCRIPTION:
    This script performs the complete data-cleaning workflow for the grocery_sales dataset.
    The cleaning process focuses on:
        1. Handling Missing Values
        2. Fixing Data Inconsistencies
        3. Addressing Negative Values
        4. Standardizing Date Formats
        5. Validating Data Types
********************************************************************************************/

-- Select project database
USE sql_portfolio_projects;

-- Rename original table to a clean working name
ALTER TABLE `sql_portfolio_projects`.`grocery store sales dataset in 2025` 
RENAME grocery_store;

SELECT * FROM grocery_store;

---------------------------------------------------------------------------------------------
--  Creating a Backup Table
--  grocery_store2 will be the main working table for all cleaning operations
---------------------------------------------------------------------------------------------

USE sql_portfolio_projects;

CREATE TABLE grocery_store2 LIKE grocery_store;
INSERT grocery_store2 SELECT * FROM grocery_store;

SELECT * FROM grocery_store2;

---------------------------------------------------------------------------------------------
--  DATA QUALITY ASSESSMENT
--  Notes:
--      Problem_1: Missing Values
--      Problem_2: Data Inconsistencies
--      Problem_3: Negative Values
--      Problem_4: Standardizing Date Format
--      Problem_5: Type Variations
---------------------------------------------------------------------------------------------

/********************************************************************************************
    PROBLEM 1: MISSING VALUES
********************************************************************************************/

-- Cleaning loyalty_points column
SELECT * FROM grocery_store2 
WHERE loyalty_points = 0;

SELECT t1.loyalty_points, t2.loyalty_points
FROM grocery_store2 t1
JOIN grocery_store2 t2
    ON t1.store_name = t2.store_name
WHERE t1.loyalty_points = 0;

UPDATE grocery_store2 t1
JOIN grocery_store2 t2
    ON t1.store_name = t2.store_name
SET t1.loyalty_points = t2.loyalty_points
WHERE t1.loyalty_points = 0
  AND t2.loyalty_points <> 0;

-- Cleaning promotions / discount_amount column
SELECT * FROM grocery_store2 WHERE discount_amount = 0;

SELECT t1.discount_amount, t2.discount_amount
FROM grocery_store2 t1
JOIN grocery_store2 t2
    ON t1.store_name = t2.store_name
WHERE t1.discount_amount = 0;

UPDATE grocery_store2 t1
JOIN grocery_store2 t2
    ON t1.store_name = t2.store_name
SET t1.discount_amount = t2.discount_amount
WHERE t1.discount_amount = 0
  AND t2.discount_amount <> 0;

-- Check for missing store_name values
SELECT * FROM grocery_store2 
WHERE store_name IS NULL OR store_name = '';

-- Step 1: Diagnose missing store_name using customer_id
SELECT customer_id, COUNT(*) AS count_rows
FROM grocery_store2
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Step 2: Identify aisle as a useful linking column
SELECT aisle, COUNT(*) AS count_rows
FROM grocery_store2
GROUP BY aisle
HAVING COUNT(*) > 1;

-- Step 3: Fill missing store_name values
UPDATE grocery_store2 t1
JOIN grocery_store2 t2
    ON t1.aisle = t2.aisle
SET t1.store_name = t2.store_name
WHERE (t1.store_name IS NULL OR t1.store_name = '')
  AND t2.store_name IS NOT NULL
  AND t2.store_name <> '';

/********************************************************************************************
    PROBLEM 2: DATA INCONSISTENCIES
********************************************************************************************/

SELECT * FROM grocery_store2 
WHERE quantity = 2.0;

-- Quantity values checked — all entries appear consistent.
-- No cleaning action needed.

/********************************************************************************************
    PROBLEM 3: NEGATIVE VALUES
********************************************************************************************/

SELECT * FROM grocery_store2 WHERE final_amount = 0.1;

SELECT final_amount, COUNT(*) AS count_rows
FROM grocery_store2
GROUP BY final_amount
HAVING COUNT(*) < 0;

UPDATE grocery_store2
SET final_amount = 0
WHERE final_amount < 0;

-- Negative values in final_amount identified and handled.

/********************************************************************************************
    PROBLEM 4: STANDARDIZE DATE FORMAT
********************************************************************************************/

SELECT transaction_date, 
       STR_TO_DATE(transaction_date, '%m/%d/%Y') AS formatted_date
FROM grocery_store2;

UPDATE grocery_store2
SET transaction_date = STR_TO_DATE(transaction_date, '%m/%d/%Y');

-- Convert transaction_date column from text to MySQL DATE type
ALTER TABLE grocery_store2 
MODIFY transaction_date DATE;

/********************************************************************************************
    SUMMARY
    - Missing store names filled
    - Loyalty points and discount amounts corrected
    - Quantity values verified
    - Negative final_amount values fixed
    - Date column standardized and converted to DATE type
    - Dataset is now ready for EDA and analysis
********************************************************************************************/


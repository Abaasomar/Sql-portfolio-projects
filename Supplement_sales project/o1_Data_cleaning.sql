/********************************************************************************************
  PROJECT: Supplement Sales Data Cleaning
  DATABASE: sql_Portfolio_projects
  WORKING TABLE: supplement_sales2
  SOURCE TABLE: supplement_sales (renamed from `supplement sales data`)
  PURPOSE: Clean and prepare data for EDA & analysis:
           - Fix date format
           - Handle missing values (discount, units_returned)
********************************************************************************************/

USE sql_Portfolio_projects;

-- ----------------------------------------------------------------
-- Step 0: Rename original table for clarity (if needed)
-- ----------------------------------------------------------------
ALTER TABLE `supplement sales data` RENAME supplement_sales;

-- ----------------------------------------------------------------
-- Step 1: Create backup working table for cleaning operations
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS supplement_sales2 LIKE supplement_sales;
INSERT INTO supplement_sales2 SELECT * FROM supplement_sales;

-- Optional: inspect initial data
SELECT * FROM supplement_sales2;

-- ----------------------------------------------------------------
-- Step 2: Fix date column (was stored as text) → convert to DATE type
-- ----------------------------------------------------------------
-- Preview conversion
SELECT date,
       STR_TO_DATE(date, '%m/%d/%Y') AS valid_date
FROM supplement_sales2;

-- Update with converted date
UPDATE supplement_sales2
SET date = STR_TO_DATE(date, '%m/%d/%Y');

-- Modify column type to DATE
ALTER TABLE supplement_sales2 
MODIFY date DATE;

-- Confirm changes
SELECT * FROM supplement_sales2 LIMIT 10;

-- ----------------------------------------------------------------
-- Step 3: Handle missing / zero values in units_returned
-- ----------------------------------------------------------------
-- Identify rows with units_returned = 0
SELECT * FROM supplement_sales2
WHERE units_returned = 0;

-- Impute zeros using category-level average (excluding zeros)
UPDATE supplement_sales2 AS t1
JOIN (
    SELECT category,
           ROUND(AVG(NULLIF(units_returned, 0))) AS avg_units
    FROM supplement_sales2
    GROUP BY category
) AS t2
ON t1.category = t2.category
SET t1.units_returned = t2.avg_units
WHERE t1.units_returned = 0
  AND t2.avg_units IS NOT NULL;

-- ----------------------------------------------------------------
-- Step 4: Handle missing / zero values in discount column
-- ----------------------------------------------------------------
-- Count zero discounts
SELECT COUNT(*) AS zero_discount_count
FROM supplement_sales2
WHERE discount = 0;

-- Impute discounts using category-level average (excluding zeros)
UPDATE supplement_sales2 AS t1
JOIN (
    SELECT category,
           ROUND(AVG(NULLIF(discount, 0))) AS avg_discount
    FROM supplement_sales2
    GROUP BY category
) AS t2
ON t1.category = t2.category
SET t1.discount = t2.avg_discount
WHERE t1.discount = 0
  AND t2.avg_discount IS NOT NULL;

-- ----------------------------------------------------------------
-- Step 5: Final check — view cleaned data
-- ----------------------------------------------------------------
SELECT * FROM supplement_sales2 LIMIT 50;

-- End of script.

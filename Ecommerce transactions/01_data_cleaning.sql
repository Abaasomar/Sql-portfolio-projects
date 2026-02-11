-- ============================================================
-- SQL Portfolio Project
-- File: 01_data_cleaning.sql
-- Project: E-commerce Transactions Analysis
-- ============================================================

-- ============================================================
-- Introduction
-- ============================================================
-- This phase focuses on cleaning and preparing the 
-- ecommerce_transactions dataset for analysis.
--
-- The dataset contains transaction information such as:
-- purchase dates, discounts, prices, and product categories.
--
-- Objective:
-- Identify and resolve data quality issues using SQL to ensure
-- accurate and reliable analysis in Phase 2.
-- ============================================================


-- ============================================================
-- Phase 1: Data Quality Issues Identified
-- ============================================================
-- 1. Discount column contained missing values (represented as 0).
-- 2. Purchase_Date column was stored as TEXT in inconsistent formats:
--    - DD/MM/YYYY
--    - DD-MM-YYYY
-- ============================================================


-- ============================================================
-- Step 1: Handling Missing Discount Values
-- ============================================================

-- Problem:
-- Some transactions had discount = 0.
-- This was misleading because other rows in the same category
-- had valid discount values.

-- ------------------------------------------------------------
-- 1.1 Identify rows with missing discounts
-- ------------------------------------------------------------
SELECT *
FROM ecommerce_transactions
WHERE discount = 0;


-- ------------------------------------------------------------
-- 1.2 Compare discount values within the same category
-- ------------------------------------------------------------
SELECT e1.category,
       e1.discount AS missing_discount,
       e2.discount AS valid_discount
FROM ecommerce_transactions e1
JOIN ecommerce_transactions e2
  ON e1.category = e2.category
WHERE e1.discount = 0
  AND e2.discount <> 0;


-- ------------------------------------------------------------
-- 1.3 Update missing discounts using category-level values
-- ------------------------------------------------------------
UPDATE ecommerce_transactions e1
JOIN ecommerce_transactions e2
  ON e1.category = e2.category
SET e1.discount = e2.discount
WHERE e1.discount = 0
  AND e2.discount <> 0;

-- Outcome:
-- Missing discount values were replaced using valid discounts
-- from the same product category to ensure consistency.


-- ============================================================
-- Step 2: Standardizing Purchase Dates
-- ============================================================

-- Problem:
-- Purchase_Date was stored as TEXT in mixed formats:
-- (12/11/2024) and (12-11-2024).
-- Direct conversion to DATE caused format errors.

-- ------------------------------------------------------------
-- 2.1 Inspect distinct date values
-- ------------------------------------------------------------
SELECT DISTINCT purchase_date
FROM ecommerce_transactions
LIMIT 20;


-- ------------------------------------------------------------
-- 2.2 Convert slash-formatted dates (DD/MM/YYYY)
-- ------------------------------------------------------------
UPDATE ecommerce_transactions
SET purchase_date = STR_TO_DATE(purchase_date, '%d/%m/%Y')
WHERE purchase_date LIKE '%/%';


-- ------------------------------------------------------------
-- 2.3 Convert dash-formatted dates (DD-MM-YYYY)
-- ------------------------------------------------------------
UPDATE ecommerce_transactions
SET purchase_date = STR_TO_DATE(purchase_date, '%d-%m-%Y')
WHERE purchase_date LIKE '%-%';


-- ------------------------------------------------------------
-- 2.4 Modify column type to DATE
-- ------------------------------------------------------------
ALTER TABLE ecommerce_transactions
MODIFY purchase_date DATE;

-- Outcome:
-- All purchase dates are now stored in MySQL’s native DATE format (YYYY-MM-DD),
-- enabling reliable filtering, sorting, and time-based analysis.


-- ============================================================
-- Final Validation
-- ============================================================

-- Preview cleaned dataset
SELECT *
FROM ecommerce_transactions;

-- Results:
-- ✔ Discount values are consistent.
-- ✔ Purchase dates are standardized.
-- ✔ Dataset is clean and ready for Phase 2: Business Analysis.
-- ============================================================

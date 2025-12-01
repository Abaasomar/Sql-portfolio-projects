-- Basic EDA queries I.E COUNT ROWS, DATA QUALITY CHECKS I.E MISSING VALUES & DUPLICATES,SUMMARY STATISTICS: 
use somaliafinancial_j;
-- COUNT ROWS:
SELECT COUNT(*) FROM somalia_financial_j;
-- DATA QUALITY CHECKS: 
-- 1_Missing values:
SELECT COUNT(*) - COUNT(*) AS missing_values
FROM somalia_financial_j;
SELECT 
    SUM(CASE WHEN year IS NULL THEN 1 ELSE 0 END) AS missing_years,
    SUM(CASE WHEN sector IS NULL THEN 1 ELSE 0 END) AS missing_sectors,
    SUM(CASE WHEN chapter IS NULL THEN 1 ELSE 0 END) AS missing_chapters,
	SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END) AS missing_Department,
	SUM(CASE WHEN Type IS NULL THEN 1 ELSE 0 END) AS missing_Type,
	SUM(CASE WHEN value IS NULL THEN 1 ELSE 0 END) AS missing_value
FROM somalia_financial_j;
-- 2.Duplicate values:
SELECT year, COUNT(*) 
FROM somalia_financial_j
GROUP BY year
HAVING COUNT(*) > 1;
-- 3.Summary statistics:
SELECT MIN(value), MAX(value), AVG(value), SUM(value)
FROM somalia_financial_j;
-- 5. Unique categories for key fields (useful for understanding dataset scope)
SELECT DISTINCT year FROM somalia_financial_j ORDER BY year;
SELECT DISTINCT sector FROM somalia_financial_j order by sector ;
SELECT DISTINCT chapter FROM somalia_financial_j ORDER BY chapter;
SELECT DISTINCT Department FROM somalia_financial_j ORDER BY Department;
SELECT DISTINCT type FROM somalia_financial_j ORDER BY type;

-- -------------------------------
-- 2: Problem description
-- -------------------------------
-- 2.1: Determine the average annual spending to identify which years had the highest financial activity.
-- -------------------------------
SELECT 
    year,
    ROUND(AVG(value), 2) AS avg_spending_per_year
FROM somalia_financial_j
GROUP BY year
ORDER BY avg_spending_per_year Desc;



-- -------------------------------
-- 2.2: Identify which government chapter or ministry spent the most each year based on average yearly spending.
-- -------------------------------
SELECT 
    year,
    chapter,
    ROUND(avg_spending_per_chapter_year, 2) AS avg_spending_per_chapter_year
FROM (
    SELECT 
        year,
        chapter,
        AVG(value) AS avg_spending_per_chapter_year,
        ROW_NUMBER() OVER (PARTITION BY year ORDER BY AVG(value) DESC) AS rn
    FROM somalia_financial_j
    GROUP BY year, chapter
) AS t
WHERE rn = 1
ORDER BY avg_spending_per_chapter_year DESC;



-- -------------------------------
-- 2.3: Determine which expense categories account for the highest spending to understand major cost drivers.
-- -------------------------------
SELECT 
    type AS expense_type,
    ROUND(AVG(value), 2) AS total_spending
FROM somalia_financial_j
GROUP BY type
ORDER BY total_spending DESC
LIMIT 5;



-- -------------------------------
-- 2.4: Calculate total spending on internationally funded projects to see which external programs receive the most funding.
-- -------------------------------
SELECT 
    department AS project_name,
    ROUND(SUM(value), 2) AS total_spending
FROM somalia_financial_j
WHERE department IN (
    'SFF project','EFG project','RCRF project','PFM project',
    'CIP project','Offshore fisheries development project',
    'SUIPP project','SCORE project'
)
GROUP BY department
ORDER BY total_spending DESC;

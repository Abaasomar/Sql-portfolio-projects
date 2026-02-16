# 🛒 E-commerce Transactions Analysis

This project analyzes **e-commerce transactions data** to uncover insights about revenue performance, discount strategies, product categories, sales trends, and customer payment behavior.  
The analysis is performed using **MySQL / SQL Workbench**.

---

## Project Overview

The main goals of this project are:  

- Clean and prepare the e-commerce transactions dataset for analysis.  
- Understand which products and categories generate the highest revenue.  
- Evaluate discount strategies and promotional effectiveness.  
- Analyze sales performance over time.  
- Identify the most used payment methods and high-value transactions.  
- Provide actionable insights to optimize sales, marketing, and inventory management.

By analyzing these patterns, actionable recommendations can be made to improve **revenue, customer engagement, and operational efficiency**.

---

## Data Cleaning Steps

- **Handling Missing Discounts:** Replaced missing discount values (`discount = 0`) with valid discounts from the same product category.  
- **Standardizing Purchase Dates:** Converted `purchase_date` from mixed text formats (`DD/MM/YYYY` and `DD-MM-YYYY`) to MySQL `DATE` format (`YYYY-MM-DD`).  
- **Validating Logical Values:** Checked for negative `price` or `final_price`, ensured `final_price ≤ price`, and verified discounts were within 0–100%.  
- **Duplicate Checks:** Verified that users did not have duplicate purchases of the same product on the same day.  

> ✅ After these steps, the dataset was clean, consistent, and ready for exploratory data analysis.

---

## Repository Structure

The project is organized for clarity and ease of use:

- [`01_data cleaning.sql`](01_data_cleaning.sql) – SQL scripts for cleaning and preparing the e-commerce transactions dataset.  
- [`02_EDA.sql`](02_EDA.sql) – SQL queries for exploratory data analysis and solving business problems.  
- [`03_Insights.md`](03_Insights/Insights.md) – Detailed insights derived from SQL queries, highlighting patterns and observations.  
- [`04_Recommendations.md`](04_Recommendations.md) – Actionable recommendations based on insights to guide strategic business decisions.  

> Hover over the links to navigate directly to the respective files in the repository.

---

## Business Problems Addressed

The analysis focuses on answering these key questions:

1. **Which products or categories generate the highest revenue and why?**  
   Identify top-performing categories to guide inventory and marketing strategies.

2. **How does sales performance change over time?**  
   Understand monthly and yearly trends to plan promotions and inventory.

3. **Which product categories receive the most discounts?**  
   Identify categories with heavy promotions to evaluate pricing strategies.

4. **What is the most used payment method and maximum purchase per method?**  
   Understand customer payment behavior and high-value transactions to optimize payment strategies.

---

## Key Insights

- **Highest Revenue Categories:** Clothing category generates the highest revenue due to higher prices and frequent purchases.  
- **Sales Trends Over Time:** Revenue shows seasonal fluctuations, peaking in January and declining toward November, indicating seasonal purchasing patterns.  
- **Discount Patterns:** Home & Kitchen and Textiles categories receive the highest total discounts, driven by promotions or inventory strategies.  
- **Payment Behavior:** Credit Card is the most frequently used payment method, with the maximum single purchase of 492.41, showing popularity and high-value transactions.

---

## Recommendations

- **Focus marketing and inventory** on high-revenue categories like Clothing to maximize profitability.  
- **Leverage seasonal trends** to plan promotions, campaigns, and inventory stocking.  
- **Optimize discount strategies** in high-discount categories to maintain profit margins while boosting sales.  
- **Promote popular payment methods** and ensure secure, efficient payment processes.  
- **Use insights for data-driven decision-making** to improve sales efficiency, platform performance, and customer satisfaction.

---

## Conclusion

This project provides a **data-driven approach** to understanding e-commerce sales performance.  
The **data cleaning, SQL analysis, insights, and recommendations** enable strategic business decisions to **increase revenue, optimize discounts, enhance customer experience, and streamline inventory management**.

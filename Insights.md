Grocery Store Sales Analysis — Insights & Root Causes

This document presents detailed insights from the SQL analysis performed on the grocery store dataset.
Each insight includes:

Summary of findings

Interpretation

Root causes

Observed patterns

2.1 — Highest Average Transaction Value
SQL Result Summary

Top product–store combinations with the highest average transaction value include:

Apples – Megamart West Side

Ground Beef – Corner Grocery

Orange Juice – Greengrocer Plaza

Bananas – Greengrocer Plaza

Rice – Greengrocer Plaza

Insight

Specific product–store combinations consistently generate higher revenue per transaction, showing that some stores have stronger demand or pricing power.

Possible Root Causes

Premium pricing on certain products

High customer demand in specific store locations

Targeted marketing or in-store promotions

Seasonal patterns affecting product popularity

Patterns Observed

High-value products are concentrated in a few stores

These products likely drive a large share of store revenue

2.2 — Discount Penetration Across Stores
SQL Result Summary

QuickStop Market shows 100% discount penetration
→ every single transaction had a discount.

Other stores show mixed or low discount penetration.

Insight

QuickStop Market relies heavily on discount-driven sales, unlike other stores with more selective discount strategies.

Possible Root Causes

Clearance sales or aggressive promotion model

High local competition requiring discounts

Customer expectations in certain neighborhoods

A store strategy that prioritizes sales volume over profit margin

Patterns Observed

Extremely high discount usage may reduce profit margins

Lower-discount stores may need targeted promotions to compete

2.3 — Products Contributing Most to Loyalty
SQL Result Summary

Products with the highest average loyalty points:

Cereal

Yogurt

Insight

These products strongly drive customer retention and repeat purchases, making them central to loyalty strategies.

Possible Root Causes

Frequent-purchase categories

Strong loyalty incentives linked to these items

Marketing campaigns tied to healthy or essential products

Patterns Observed

Loyalty impact is concentrated in a few product categories

Low-loyalty categories could benefit from bonus points

2.4 — Product Diversity Per Aisle
SQL Result Summary

Aisles with the highest product diversity:

Bakery — 18 unique products

Beverages — 18 unique products

Canned Soda — 18 unique products

Insight

High-diversity aisles offer more choices and likely drive more traffic compared to aisles with fewer unique items.

Possible Root Causes

Higher customer demand in these aisles

Broader supplier network

Seasonal or promotional product rotations

Patterns Observed

High diversity is linked to high purchase probability

Expanding product variety in weaker aisles could increase sales

2.5 — Geographic Store Coverage & Revenue Distribution
SQL Result Summary

Top-performing stores by revenue and transaction value:

Greengrocer Plaza

Megamart Westside

Freshmart Downtown

Insight

These stores generate the most revenue, indicating strong customer traffic, product mix, or strategic placement.

Possible Root Causes

Prime city locations

Better inventory management

Strong store branding

Higher-income customer neighborhoods

Patterns Observed

Revenue is heavily concentrated in a few stores

Underperforming stores may need localized strategies to increase sales

Overall Observations

Revenue is driven significantly by specific stores and high-value products

Discount strategies differ widely and strongly influence sales behavior

Loyalty programs work extremely well for certain product categories

Product diversity varies across aisles and affects customer choices

Geographic store location plays a major role in revenue performance

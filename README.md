# Project Title: Pizza Data Analysis

Short summary: SQL-driven analysis of pizza sales and customer behavior with a Power BI reference dashboard.

## Objectives
- Build a clean, usable pizza sales dataset and simple relational model.
- Clean and validate data (remove nulls, normalize types and categories).
- Perform EDA to uncover time, product, and customer patterns.
- Produce actionable business insights for menu, marketing, and operations.

## Database Structure (tables)
- `orders` — order_id, custid, order_date, order_time, status
- `order_details` — order_details_id, order_id, pizza_id, quantity
- `pizzas` — pizza_id, pizza_type_id, size, price
- `pizza_types` — pizza_type_id, name, category, ingredients

Note: This repo currently contains `orders_2025.csv` and `pizzas_info_2025.csv`. Either rename to match SQL (`orders_2026` / `pizzas_2026`) or update `sql_queries_analysis.sql` to use the existing filenames.

## Data cleaning & exploration
- Count records per table and verify primary keys.
- Check and fix missing or inconsistent values in critical fields.
- Enforce correct types for dates, times, numeric price, and integer quantities.
- Standardize categorical values (size, category) and trim whitespace.

## Analysis checklist (queries & insights)
- Orders volume: unique orders, monthly and weekday trends, peak hours.
- Revenue: total revenue, cumulative revenue, revenue by category/size.
- Menu performance: top/bottom sellers, top 3 by category, price-based rankings.
- Customer analysis: repeat customers, simple RFM-like segmentation, CLV.
- Operational metrics: avg order size, pizzas per day, staffing windows.
- Advanced: basket combinations, profitability estimates, simple next-month forecast.

## Key findings (example outcomes)
- Order trends: clear peak hours and weekend lifts, seasonality by month.
- Menu insights: a small number of pizzas contribute most revenue; sizes skew toward M/L.
- Revenue dynamics: monthly growth and category-level share identified.
- Operational action: staffing and promo windows recommended around peak hours.

## Files to review
- `sql_queries_analysis.sql` — analysis queries (update names if needed)
- `dataset/` — source CSVs (`orders_2025.csv`, `order_details.csv`, `pizzas_info_2025.csv`, `pizza_types.csv`)
- `sales_dashboard_kpis.pbix` — Power BI reference file

If you want, I can standardize filenames in the repo or update the SQL to match the existing CSVs.



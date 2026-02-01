-- PIZZA SALES ANALYSIS QUERIES
-- Using direct CSV data: orders_2026, order_details, pizzas_2026, pizza_types

-- BASIC ANALYSIS QUERIES

-- 1. Total Orders and Revenue Overview
SELECT
    COUNT(DISTINCT o.order_id) as total_orders,
    ROUND(SUM(od.quantity * p.price), 2) as total_revenue,
    ROUND(AVG(od.quantity * p.price), 2) as avg_order_value,
    SUM(od.quantity) as total_pizzas_sold
FROM orders_2026 o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id;

-- 2. Orders by Month
SELECT
    strftime('%Y-%m', o.order_date) as month,
    COUNT(DISTINCT o.order_id) as orders_count,
    ROUND(SUM(od.quantity * p.price), 2) as revenue,
    SUM(od.quantity) as pizzas_sold
FROM orders_2026 o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
GROUP BY strftime('%Y-%m', o.order_date)
ORDER BY month;

-- 3. Orders by Day of Week
SELECT
    CASE strftime('%w', o.order_date)
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END as day_of_week,
    COUNT(DISTINCT o.order_id) as orders_count,
    ROUND(SUM(od.quantity * p.price), 2) as revenue
FROM orders_2026 o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
GROUP BY strftime('%w', o.order_date)
ORDER BY strftime('%w', o.order_date);

-- 4. Orders by Hour of Day
SELECT
    strftime('%H', o.order_time) as hour,
    COUNT(DISTINCT o.order_id) as orders_count,
    ROUND(SUM(od.quantity * p.price), 2) as revenue,
    ROUND(AVG(od.quantity), 2) as avg_pizzas_per_order
FROM orders_2026 o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
GROUP BY strftime('%H', o.order_time)
ORDER BY hour;

-- 5. Revenue by Pizza Category
SELECT
    pt.category,
    ROUND(SUM(od.quantity * p.price), 2) as revenue,
    SUM(od.quantity) as quantity_sold,
    ROUND(AVG(od.quantity * p.price), 2) as avg_price_per_pizza,
    COUNT(DISTINCT o.order_id) as orders_count
FROM orders_2026 o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY revenue DESC;

-- 6. Top 10 Pizza Types by Revenue
SELECT
    pt.name as pizza_name,
    pt.category,
    ROUND(SUM(od.quantity * p.price), 2) as revenue,
    SUM(od.quantity) as quantity_sold,
    ROUND(AVG(od.quantity * p.price), 2) as avg_order_value,
    COUNT(DISTINCT o.order_id) as orders_count
FROM orders_2026 o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name, pt.category
ORDER BY revenue DESC
LIMIT 10;

-- 7. Revenue by Pizza Size
SELECT
    p.size,
    ROUND(SUM(od.quantity * p.price), 2) as revenue,
    SUM(od.quantity) as quantity_sold,
    ROUND(AVG(p.price), 2) as avg_price,
    COUNT(DISTINCT o.order_id) as orders_count
FROM orders_2026 o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY revenue DESC;

-- 8. Customer Analysis
SELECT
    COUNT(DISTINCT o.custid) as total_customers,
    AVG(customer_orders.total_orders) as avg_orders_per_customer,
    AVG(customer_orders.total_spent) as avg_spent_per_customer,
    MAX(customer_orders.total_orders) as max_orders_by_customer
FROM orders_2026 o
JOIN (
    SELECT
        custid,
        COUNT(DISTINCT order_id) as total_orders,
        ROUND(SUM(od.quantity * p.price), 2) as total_spent
    FROM orders_2026 o2
    JOIN order_details od ON o2.order_id = od.order_id
    JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
    GROUP BY custid
) customer_orders ON o.custid = customer_orders.custid;

-- 9. Repeat Customers Analysis
SELECT
    CASE
        WHEN customer_stats.order_count = 1 THEN 'One-time'
        WHEN customer_stats.order_count BETWEEN 2 AND 5 THEN 'Regular'
        WHEN customer_stats.order_count BETWEEN 6 AND 10 THEN 'Frequent'
        ELSE 'VIP'
    END as customer_segment,
    COUNT(*) as customer_count,
    ROUND(AVG(customer_stats.total_spent), 2) as avg_total_spent,
    ROUND(AVG(customer_stats.order_count), 2) as avg_order_count
FROM (
    SELECT
        o.custid,
        COUNT(DISTINCT o.order_id) as order_count,
        ROUND(SUM(od.quantity * p.price), 2) as total_spent
    FROM orders_2026 o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
    GROUP BY o.custid
) customer_stats
GROUP BY
    CASE
        WHEN customer_stats.order_count = 1 THEN 'One-time'
        WHEN customer_stats.order_count BETWEEN 2 AND 5 THEN 'Regular'
        WHEN customer_stats.order_count BETWEEN 6 AND 10 THEN 'Frequent'
        ELSE 'VIP'
    END
ORDER BY avg_total_spent DESC;

-- 10. Monthly Trends and Growth
WITH monthly_stats AS (
    SELECT
        strftime('%Y-%m', o.order_date) as month,
        COUNT(DISTINCT o.order_id) as orders,
        ROUND(SUM(od.quantity * p.price), 2) as revenue,
        SUM(od.quantity) as pizzas_sold
    FROM orders_2026 o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
    GROUP BY strftime('%Y-%m', o.order_date)
)
SELECT
    month,
    orders,
    revenue,
    pizzas_sold,
    LAG(orders) OVER (ORDER BY month) as prev_month_orders,
    LAG(revenue) OVER (ORDER BY month) as prev_month_revenue,
    ROUND(
        (orders - LAG(orders) OVER (ORDER BY month)) * 100.0 /
        NULLIF(LAG(orders) OVER (ORDER BY month), 0),
        2
    ) as orders_growth_pct,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY month)) * 100.0 /
        NULLIF(LAG(revenue) OVER (ORDER BY month), 0),
        2
    ) as revenue_growth_pct
FROM monthly_stats
ORDER BY month;

-- ADVANCED ANALYSIS QUERIES

-- 11. Size-Category Performance Matrix
SELECT
    pt.category,
    p.size,
    COUNT(DISTINCT o.order_id) as orders_count,
    SUM(od.quantity) as total_quantity,
    ROUND(SUM(od.quantity * p.price), 2) as total_revenue,
    ROUND(AVG(od.quantity * p.price), 2) as avg_order_value,
    ROUND(
        SUM(od.quantity * p.price) * 100.0 /
        SUM(SUM(od.quantity * p.price)) OVER (PARTITION BY pt.category),
        2
    ) as category_revenue_share_pct
FROM orders_2026 o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category, p.size
ORDER BY pt.category, total_revenue DESC;

-- 12. Time Slot Analysis (Breakfast, Lunch, Dinner, Late Night)
SELECT
    CASE
        WHEN CAST(strftime('%H', o.order_time) AS INTEGER) BETWEEN 6 AND 10 THEN 'Breakfast (6-10)'
        WHEN CAST(strftime('%H', o.order_time) AS INTEGER) BETWEEN 11 AND 14 THEN 'Lunch (11-14)'
        WHEN CAST(strftime('%H', o.order_time) AS INTEGER) BETWEEN 15 AND 17 THEN 'Afternoon (15-17)'
        WHEN CAST(strftime('%H', o.order_time) AS INTEGER) BETWEEN 18 AND 21 THEN 'Dinner (18-21)'
        WHEN CAST(strftime('%H', o.order_time) AS INTEGER) >= 22 OR
             CAST(strftime('%H', o.order_time) AS INTEGER) <= 5 THEN 'Late Night (22-5)'
        ELSE 'Other'
    END as time_slot,
    COUNT(DISTINCT o.order_id) as orders_count,
    ROUND(SUM(od.quantity * p.price), 2) as revenue,
    SUM(od.quantity) as pizzas_sold,
    ROUND(AVG(od.quantity), 2) as avg_pizzas_per_order,
    ROUND(
        SUM(od.quantity * p.price) * 100.0 /
        SUM(SUM(od.quantity * p.price)) OVER (),
        2
    ) as revenue_share_pct
FROM orders_2026 o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
GROUP BY
    CASE
        WHEN CAST(strftime('%H', o.order_time) AS INTEGER) BETWEEN 6 AND 10 THEN 'Breakfast (6-10)'
        WHEN CAST(strftime('%H', o.order_time) AS INTEGER) BETWEEN 11 AND 14 THEN 'Lunch (11-14)'
        WHEN CAST(strftime('%H', o.order_time) AS INTEGER) BETWEEN 15 AND 17 THEN 'Afternoon (15-17)'
        WHEN CAST(strftime('%H', o.order_time) AS INTEGER) BETWEEN 18 AND 21 THEN 'Dinner (18-21)'
        WHEN CAST(strftime('%H', o.order_time) AS INTEGER) >= 22 OR
             CAST(strftime('%H', o.order_time) AS INTEGER) <= 5 THEN 'Late Night (22-5)'
        ELSE 'Other'
    END
ORDER BY revenue DESC;

-- 13. Customer Order Patterns
SELECT
    order_size_category,
    COUNT(*) as order_count,
    ROUND(AVG(order_value), 2) as avg_order_value,
    ROUND(SUM(order_value), 2) as total_revenue,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) as percentage_of_orders
FROM (
    SELECT
        o.order_id,
        SUM(od.quantity) as order_size,
        ROUND(SUM(od.quantity * p.price), 2) as order_value,
        CASE
            WHEN SUM(od.quantity) = 1 THEN 'Single Pizza'
            WHEN SUM(od.quantity) BETWEEN 2 AND 3 THEN 'Small Order (2-3)'
            WHEN SUM(od.quantity) BETWEEN 4 AND 6 THEN 'Medium Order (4-6)'
            ELSE 'Large Order (7+)'
        END as order_size_category
    FROM orders_2026 o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
    GROUP BY o.order_id
) order_patterns
GROUP BY order_size_category
ORDER BY total_revenue DESC;

-- 14. Seasonal Analysis by Month
SELECT
    CASE strftime('%m', o.order_date)
        WHEN '01' THEN 'January'
        WHEN '02' THEN 'February'
        WHEN '03' THEN 'March'
        WHEN '04' THEN 'April'
        WHEN '05' THEN 'May'
        WHEN '06' THEN 'June'
        WHEN '07' THEN 'July'
        WHEN '08' THEN 'August'
        WHEN '09' THEN 'September'
        WHEN '10' THEN 'October'
        WHEN '11' THEN 'November'
        WHEN '12' THEN 'December'
    END as month_name,
    strftime('%m', o.order_date) as month_num,
    COUNT(DISTINCT o.order_id) as orders_count,
    ROUND(SUM(od.quantity * p.price), 2) as revenue,
    SUM(od.quantity) as pizzas_sold,
    ROUND(AVG(od.quantity * p.price), 2) as avg_order_value
FROM orders_2026 o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
GROUP BY strftime('%m', o.order_date)
ORDER BY month_num;

-- 15. Pizza Performance by Size and Category
SELECT
    pt.category,
    p.size,
    pt.name as pizza_name,
    SUM(od.quantity) as quantity_sold,
    ROUND(SUM(od.quantity * p.price), 2) as revenue,
    ROUND(AVG(p.price), 2) as avg_price,
    COUNT(DISTINCT o.order_id) as orders_with_this_pizza,
    ROUND(
        SUM(od.quantity * p.price) * 100.0 /
        SUM(SUM(od.quantity * p.price)) OVER (PARTITION BY pt.category),
        2
    ) as category_revenue_pct
FROM orders_2026 o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category, p.size, pt.name
ORDER BY pt.category, revenue DESC;

-- 16. Order Timing Patterns
SELECT
    strftime('%H', o.order_time) as order_hour,
    COUNT(DISTINCT DATE(o.order_date)) as days_with_orders,
    COUNT(DISTINCT o.order_id) as total_orders,
    ROUND(SUM(od.quantity * p.price), 2) as total_revenue,
    ROUND(AVG(od.quantity), 2) as avg_pizzas_per_order,
    ROUND(
        COUNT(DISTINCT o.order_id) * 1.0 / COUNT(DISTINCT DATE(o.order_date)),
        2
    ) as avg_orders_per_active_day
FROM orders_2026 o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
GROUP BY strftime('%H', o.order_time)
ORDER BY order_hour;

-- 17. Customer Value Segmentation (RFM-like)
WITH customer_rfm AS (
    SELECT
        o.custid,
        COUNT(DISTINCT o.order_id) as frequency,
        ROUND(SUM(od.quantity * p.price), 2) as monetary,
        JULIANDAY('2026-12-31') - JULIANDAY(MAX(o.order_date)) as recency_days
    FROM orders_2026 o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
    GROUP BY o.custid
),
rfm_scores AS (
    SELECT
        custid,
        frequency,
        monetary,
        recency_days,
        NTILE(3) OVER (ORDER BY recency_days ASC) as r_score,
        NTILE(3) OVER (ORDER BY frequency DESC) as f_score,
        NTILE(3) OVER (ORDER BY monetary DESC) as m_score
    FROM customer_rfm
)
SELECT
    CASE
        WHEN r_score = 3 AND f_score = 3 AND m_score = 3 THEN 'Champions'
        WHEN r_score >= 2 AND f_score >= 2 AND m_score >= 2 THEN 'Loyal Customers'
        WHEN r_score >= 2 AND f_score >= 1 THEN 'Potential Loyalists'
        WHEN r_score = 1 THEN 'At Risk'
        ELSE 'Lost'
    END as customer_segment,
    COUNT(*) as customer_count,
    ROUND(AVG(frequency), 2) as avg_frequency,
    ROUND(AVG(monetary), 2) as avg_monetary,
    ROUND(AVG(recency_days), 2) as avg_recency_days,
    ROUND(SUM(monetary), 2) as total_monetary
FROM rfm_scores
GROUP BY
    CASE
        WHEN r_score = 3 AND f_score = 3 AND m_score = 3 THEN 'Champions'
        WHEN r_score >= 2 AND f_score >= 2 AND m_score >= 2 THEN 'Loyal Customers'
        WHEN r_score >= 2 AND f_score >= 1 THEN 'Potential Loyalists'
        WHEN r_score = 1 THEN 'At Risk'
        ELSE 'Lost'
    END
ORDER BY total_monetary DESC;

-- 18. Basket Analysis - Popular Pizza Combinations
WITH order_compositions AS (
    SELECT
        o.order_id,
        GROUP_CONCAT(DISTINCT pt.name ORDER BY pt.name) as pizza_combination,
        COUNT(DISTINCT pt.name) as unique_pizzas,
        ROUND(SUM(od.quantity * p.price), 2) as order_value
    FROM orders_2026 o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY o.order_id
    HAVING unique_pizzas > 1
)
SELECT
    pizza_combination,
    COUNT(*) as frequency,
    ROUND(AVG(order_value), 2) as avg_order_value,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(DISTINCT order_id) FROM orders_2026),
        2
    ) as pct_of_total_orders
FROM order_compositions
GROUP BY pizza_combination
HAVING frequency >= 2
ORDER BY frequency DESC
LIMIT 15;

-- 19. Size Popularity Trends
SELECT
    p.size,
    COUNT(DISTINCT o.order_id) as orders_with_size,
    SUM(od.quantity) as total_quantity,
    ROUND(SUM(od.quantity * p.price), 2) as total_revenue,
    ROUND(AVG(p.price), 2) as avg_price_per_pizza,
    ROUND(
        SUM(od.quantity) * 100.0 / SUM(SUM(od.quantity)) OVER (),
        2
    ) as quantity_share_pct,
    ROUND(
        SUM(od.quantity * p.price) * 100.0 / SUM(SUM(od.quantity * p.price)) OVER (),
        2
    ) as revenue_share_pct
FROM orders_2026 o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_revenue DESC;

-- 20. Category Performance Deep Dive
SELECT
    pt.category,
    COUNT(DISTINCT pt.name) as unique_pizza_types,
    COUNT(DISTINCT o.order_id) as total_orders,
    SUM(od.quantity) as total_quantity,
    ROUND(SUM(od.quantity * p.price), 2) as total_revenue,
    ROUND(AVG(od.quantity * p.price), 2) as avg_order_value,
    ROUND(AVG(p.price), 2) as avg_pizza_price,
    ROUND(
        COUNT(DISTINCT o.order_id) * 100.0 / SUM(COUNT(DISTINCT o.order_id)) OVER (),
        2
    ) as order_share_pct,
    ROUND(
        SUM(od.quantity * p.price) * 100.0 / SUM(SUM(od.quantity * p.price)) OVER (),
        2
    ) as revenue_share_pct
FROM orders_2026 o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas_2026 p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_revenue DESC;
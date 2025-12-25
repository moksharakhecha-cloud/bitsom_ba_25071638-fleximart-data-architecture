Query 1: Monthly Sales Drill-Down Analysis

-- Query 1: Monthly Sales Drill-Down
-- Business Scenario: CEO wants yearly → quarterly → monthly sales for 2024
-- Demonstrates: Drill-down analysis using time dimensions

SELECT
    d.year,
    d.quarter,
    d.month_name,
    SUM(f.sales_amount) AS total_sales,
    SUM(f.quantity) AS total_quantity
FROM fact_sales f
JOIN dim_date d
    ON f.date_id = d.date_id
WHERE d.year = 2024
GROUP BY
    d.year,
    d.quarter,
    d.month_name,
    d.month_number
ORDER BY
    d.year,
    d.quarter,
    d.month_number;

Query 2: Product Performance Analysis

-- Query 2: Top 10 Products by Revenue
-- Business Scenario: Identify top-performing products by revenue
-- Includes: Revenue percentage calculation

SELECT
    p.product_name,
    p.category,
    SUM(f.quantity) AS units_sold,
    SUM(f.sales_amount) AS revenue,
    ROUND(
        (SUM(f.sales_amount) * 100.0) / SUM(SUM(f.sales_amount)) OVER (),
        2
    ) AS revenue_percentage
FROM fact_sales f
JOIN dim_product p
    ON f.product_id = p.product_id
GROUP BY
    p.product_name,
    p.category
ORDER BY
    revenue DESC
LIMIT 10;


Query 3: Customer Segmentation Analysis

-- Query 3: Customer Segmentation
-- Business Scenario: Segment customers based on total spending
-- Segments: High (>50000), Medium (20000-50000), Low (<20000)

WITH customer_spending AS (
    SELECT
        c.customer_id,
        SUM(f.sales_amount) AS total_spent
    FROM fact_sales f
    JOIN dim_customer c
        ON f.customer_id = c.customer_id
    GROUP BY
        c.customer_id
),
customer_segments AS (
    SELECT
        customer_id,
        total_spent,
        CASE
            WHEN total_spent > 50000 THEN 'High Value'
            WHEN total_spent BETWEEN 20000 AND 50000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM customer_spending
)

SELECT
    customer_segment,
    COUNT(customer_id) AS customer_count,
    SUM(total_spent) AS total_revenue,
    ROUND(AVG(total_spent), 2) AS avg_revenue_per_customer
FROM customer_segments
GROUP BY
    customer_segment
ORDER BY
    total_revenue DESC;

USE mealmetrics;

-- 1. Total Customers
SELECT
    COUNT(*) AS total_customers
FROM customers_medium;


-- 2. Active Customers
-- Customers who have placed at least one order
SELECT
    COUNT(DISTINCT customer_id) AS active_customers
FROM orders_medium;


-- 3. Inactive Customers
-- Customers who have never placed an order
SELECT
    COUNT(*) AS inactive_customers
FROM customers_medium AS c
LEFT JOIN orders_medium AS o
    ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;


-- 4. Orders per Customer
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders_medium
GROUP BY customer_id
ORDER BY total_orders DESC;


-- 5. Average Orders per Active Customer
SELECT
    ROUND(AVG(order_count), 2) AS avg_orders_per_customer
FROM (
    SELECT
        customer_id,
        COUNT(order_id) AS order_count
    FROM orders_medium
    GROUP BY customer_id
) AS customer_orders;


-- 6. One-Time Customers
-- Customers who placed exactly one order
SELECT
    COUNT(*) AS one_time_customers
FROM (
    SELECT
        customer_id
    FROM orders_medium
    GROUP BY customer_id
    HAVING COUNT(order_id) = 1
) AS one_time;


-- 7. Repeat Customers
-- Customers who placed more than one order
SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT
        customer_id
    FROM orders_medium
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
) AS repeat_customer;


-- 8. One-Time vs Repeat Customer Distribution
SELECT
    CASE
        WHEN order_count = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM (
    SELECT
        customer_id,
        COUNT(order_id) AS order_count
    FROM orders_medium
    GROUP BY customer_id
) AS customer_orders
GROUP BY
    CASE
        WHEN order_count = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END;


-- 9. Customer Revenue
SELECT
    o.customer_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM orders_medium AS o
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY total_revenue DESC;


-- 10. Top 10 Customers by Revenue
SELECT
    o.customer_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM orders_medium AS o
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY total_revenue DESC
LIMIT 10;


-- 11. Top 10 Customers by Order Frequency
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders_medium
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;


-- 12. Average Order Value per Customer
SELECT
    o.customer_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        SUM(oi.quantity * oi.price) /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders_medium AS o
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY average_order_value DESC;


-- 13. Customer Revenue by City
SELECT
    c.city,
    COUNT(DISTINCT c.customer_id) AS customers,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM customers_medium AS c
JOIN orders_medium AS o
    ON c.customer_id = o.customer_id
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY c.city
ORDER BY total_revenue DESC;


-- 14. Average Customer Revenue by City
SELECT
    c.city,
    COUNT(DISTINCT c.customer_id) AS active_customers,
    ROUND(
        SUM(oi.quantity * oi.price) /
        COUNT(DISTINCT c.customer_id),
        2
    ) AS avg_revenue_per_customer
FROM customers_medium AS c
JOIN orders_medium AS o
    ON c.customer_id = o.customer_id
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY c.city
ORDER BY avg_revenue_per_customer DESC;


-- 15. Customer Orders by City
SELECT
    c.city,
    COUNT(DISTINCT c.customer_id) AS active_customers,
    COUNT(o.order_id) AS total_orders,
    ROUND(
        COUNT(o.order_id) /
        COUNT(DISTINCT c.customer_id),
        2
    ) AS avg_orders_per_customer
FROM customers_medium AS c
JOIN orders_medium AS o
    ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY avg_orders_per_customer DESC;


-- 16. Customer Order Frequency Segmentation
SELECT
    CASE
        WHEN order_count = 1 THEN '1 Order'
        WHEN order_count BETWEEN 2 AND 5 THEN '2-5 Orders'
        WHEN order_count BETWEEN 6 AND 10 THEN '6-10 Orders'
        ELSE '10+ Orders'
    END AS customer_segment,
    COUNT(*) AS customer_count
FROM (
    SELECT
        customer_id,
        COUNT(order_id) AS order_count
    FROM orders_medium
    GROUP BY customer_id
) AS customer_orders
GROUP BY
    CASE
        WHEN order_count = 1 THEN '1 Order'
        WHEN order_count BETWEEN 2 AND 5 THEN '2-5 Orders'
        WHEN order_count BETWEEN 6 AND 10 THEN '6-10 Orders'
        ELSE '10+ Orders'
    END
ORDER BY customer_count DESC;


-- 17. Highest Spending Customers with Their City
SELECT
    c.customer_id,
    c.city,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM customers_medium AS c
JOIN orders_medium AS o
    ON c.customer_id = o.customer_id
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.city
ORDER BY total_revenue DESC
LIMIT 10;
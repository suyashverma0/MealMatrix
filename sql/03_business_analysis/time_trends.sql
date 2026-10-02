USE mealmetrics;


-- 1. MONTHLY ORDERS

SELECT
    YEAR(order_time) AS order_year,
    MONTH(order_time) AS order_month,
    COUNT(*) AS total_orders
FROM orders_medium
GROUP BY
    YEAR(order_time),
    MONTH(order_time)
ORDER BY
    order_year,
    order_month;


-- 2. MONTHLY REVENUE

SELECT
    YEAR(o.order_time) AS order_year,
    MONTH(o.order_time) AS order_month,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM orders_medium AS o
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY
    YEAR(o.order_time),
    MONTH(o.order_time)
ORDER BY
    order_year,
    order_month;


-- 3. DAILY ORDERS

SELECT
    DATE(order_time) AS order_date,
    COUNT(*) AS total_orders
FROM orders_medium
GROUP BY DATE(order_time)
ORDER BY order_date;


-- 4. DAILY REVENUE

SELECT
    DATE(o.order_time) AS order_date,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM orders_medium AS o
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY DATE(o.order_time)
ORDER BY order_date;


-- 5. ORDERS BY DAY OF WEEK

SELECT
    DAYNAME(order_time) AS day_name,
    COUNT(*) AS total_orders
FROM orders_medium
GROUP BY DAYNAME(order_time)
ORDER BY total_orders DESC;


-- 6. REVENUE BY DAY OF WEEK

SELECT
    DAYNAME(o.order_time) AS day_name,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM orders_medium AS o
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY DAYNAME(o.order_time)
ORDER BY total_revenue DESC;


-- 7. ORDERS BY HOUR

SELECT
    HOUR(order_time) AS order_hour,
    COUNT(*) AS total_orders
FROM orders_medium
GROUP BY HOUR(order_time)
ORDER BY order_hour;

-- 8. REVENUE BY HOUR

SELECT
    HOUR(o.order_time) AS order_hour,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM orders_medium AS o
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY HOUR(o.order_time)
ORDER BY order_hour;


-- 9. MONTHLY AVERAGE ORDER VALUE

SELECT
    YEAR(o.order_time) AS order_year,
    MONTH(o.order_time) AS order_month,
    ROUND(
        SUM(oi.quantity * oi.price) /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders_medium AS o
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY
    YEAR(o.order_time),
    MONTH(o.order_time)
ORDER BY
    order_year,
    order_month;


-- 10. MONTHLY DELIVERY TIME

SELECT
    YEAR(order_time) AS order_year,
    MONTH(order_time) AS order_month,
    ROUND(
        AVG(
            TIMESTAMPDIFF(
                MINUTE,
                order_time,
                delivery_time
            )
        ),
        2
    ) AS avg_delivery_time_minutes
FROM orders_medium
WHERE delivery_time IS NOT NULL
GROUP BY
    YEAR(order_time),
    MONTH(order_time)
ORDER BY
    order_year,
    order_month;


-- 11. YEAR-WISE BUSINESS PERFORMANCE

SELECT
    YEAR(o.order_time) AS order_year,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue,
    ROUND(
        SUM(oi.quantity * oi.price) /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders_medium AS o
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_time)
ORDER BY order_year;


-- 12. YEAR-WISE DELIVERY PERFORMANCE

SELECT
    YEAR(order_time) AS order_year,
    COUNT(*) AS total_orders,
    ROUND(
        AVG(
            TIMESTAMPDIFF(
                MINUTE,
                order_time,
                delivery_time
            )
        ),
        2
    ) AS avg_delivery_time_minutes
FROM orders_medium
WHERE delivery_time IS NOT NULL
GROUP BY YEAR(order_time)
ORDER BY order_year;


-- 13. PEAK ORDERING HOURS

SELECT
    HOUR(order_time) AS order_hour,
    COUNT(*) AS total_orders
FROM orders_medium
GROUP BY HOUR(order_time)
ORDER BY total_orders DESC
LIMIT 10;


-- 14. PEAK REVENUE HOURS

SELECT
    HOUR(o.order_time) AS order_hour,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM orders_medium AS o
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY HOUR(o.order_time)
ORDER BY total_revenue DESC
LIMIT 10;


-- 15. MONTHLY ORDERS AND REVENUE

SELECT
    YEAR(o.order_time) AS order_year,
    MONTH(o.order_time) AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM orders_medium AS o
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY
    YEAR(o.order_time),
    MONTH(o.order_time)
ORDER BY
    order_year,
    order_month;
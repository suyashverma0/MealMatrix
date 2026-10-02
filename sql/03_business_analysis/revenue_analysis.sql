USE mealmetrics;

-- 1. Total Revenue
SELECT
    ROUND(SUM(quantity * price), 2) AS total_revenue
FROM `order_items (2)`;


-- 2. Average Order Value (AOV)
SELECT
    ROUND(AVG(order_revenue), 2) AS average_order_value
FROM (
    SELECT
        order_id,
        SUM(quantity * price) AS order_revenue
    FROM `order_items (2)`
    GROUP BY order_id
) AS order_revenue_table;


-- 3. Total Revenue and Total Orders
SELECT
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM `order_items (2)` AS oi;


-- 4. Revenue by Restaurant
SELECT
    r.restaurant_id,
    r.city,
    r.cuisine,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM `order_items (2)` AS oi
JOIN orders_medium AS o
    ON oi.order_id = o.order_id
JOIN restaurants AS r
    ON o.restaurant_id = r.restaurant_id
GROUP BY
    r.restaurant_id,
    r.city,
    r.cuisine
ORDER BY total_revenue DESC;


-- 5. Top 10 Restaurants by Revenue
SELECT
    r.restaurant_id,
    r.city,
    r.cuisine,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM `order_items (2)` AS oi
JOIN orders_medium AS o
    ON oi.order_id = o.order_id
JOIN restaurants AS r
    ON o.restaurant_id = r.restaurant_id
GROUP BY
    r.restaurant_id,
    r.city,
    r.cuisine
ORDER BY total_revenue DESC
LIMIT 10;


-- 6. Revenue by Cuisine
SELECT
    r.cuisine,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM `order_items (2)` AS oi
JOIN orders_medium AS o
    ON oi.order_id = o.order_id
JOIN restaurants AS r
    ON o.restaurant_id = r.restaurant_id
GROUP BY r.cuisine
ORDER BY total_revenue DESC;


-- 7. Revenue by City
SELECT
    r.city,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM `order_items (2)` AS oi
JOIN orders_medium AS o
    ON oi.order_id = o.order_id
JOIN restaurants AS r
    ON o.restaurant_id = r.restaurant_id
GROUP BY r.city
ORDER BY total_revenue DESC;


-- 8. Revenue by Menu Item
SELECT
    oi.item_id,
    m.restaurant_id,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM `order_items (2)` AS oi
JOIN menu_items AS m
    ON oi.item_id = m.item_id
GROUP BY
    oi.item_id,
    m.restaurant_id
ORDER BY total_revenue DESC;


-- 9. Top 10 Revenue-Generating Menu Items
SELECT
    oi.item_id,
    m.restaurant_id,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue,
    SUM(oi.quantity) AS total_quantity_sold
FROM `order_items (2)` AS oi
JOIN menu_items AS m
    ON oi.item_id = m.item_id
GROUP BY
    oi.item_id,
    m.restaurant_id
ORDER BY total_revenue DESC
LIMIT 10;


-- 10. Revenue by Order Status
SELECT
    o.status,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM orders_medium AS o
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY o.status
ORDER BY total_revenue DESC;


-- 11. Revenue by Customer
SELECT
    o.customer_id,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders_medium AS o
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY total_revenue DESC;


-- 12. Top 10 Customers by Revenue
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


-- 13. Monthly Revenue
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


-- 14. Daily Revenue
SELECT
    DATE(o.order_time) AS order_date,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM orders_medium AS o
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY DATE(o.order_time)
ORDER BY order_date;


-- 15. Revenue by Day of Week
SELECT
    DAYNAME(o.order_time) AS day_name,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM orders_medium AS o
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY DAYNAME(o.order_time)
ORDER BY total_revenue DESC;

-- 16. Revenue by Hour
SELECT
    DATE_FORMAT(o.order_time, '%h %p') AS order_hour,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM orders_medium AS o
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY
    HOUR(o.order_time),
    DATE_FORMAT(o.order_time, '%h %p')
ORDER BY HOUR(o.order_time);



-- 17. Revenue Contribution by Restaurant
SELECT
    r.restaurant_id,
    r.city,
    ROUND(SUM(oi.quantity * oi.price), 2) AS restaurant_revenue,
    ROUND(
        SUM(oi.quantity * oi.price) * 100.0 /
        (SELECT SUM(quantity * price)
         FROM `order_items (2)`),
        2
    ) AS revenue_contribution_percentage
FROM `order_items (2)` AS oi
JOIN orders_medium AS o
    ON oi.order_id = o.order_id
JOIN restaurants AS r
    ON o.restaurant_id = r.restaurant_id
GROUP BY
    r.restaurant_id,
    r.city
ORDER BY restaurant_revenue DESC;
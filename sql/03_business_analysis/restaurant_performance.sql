USE mealmetrics;

-- 1. RESTAURANT-WISE TOTAL ORDERS

SELECT
    r.restaurant_id,
    r.city,
    r.cuisine,
    r.rating,
    COUNT(o.order_id) AS total_orders
FROM restaurants AS r
LEFT JOIN orders_medium AS o
    ON r.restaurant_id = o.restaurant_id
GROUP BY
    r.restaurant_id,
    r.city,
    r.cuisine,
    r.rating
ORDER BY total_orders DESC;


-- 2. RESTAURANT-WISE REVENUE

SELECT
    r.restaurant_id,
    r.city,
    r.cuisine,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM restaurants AS r
JOIN orders_medium AS o
    ON r.restaurant_id = o.restaurant_id
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY
    r.restaurant_id,
    r.city,
    r.cuisine
ORDER BY total_revenue DESC;


-- 3. TOP 10 RESTAURANTS BY REVENUE

SELECT
    r.restaurant_id,
    r.city,
    r.cuisine,
    r.rating,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM restaurants AS r
JOIN orders_medium AS o
    ON r.restaurant_id = o.restaurant_id
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY
    r.restaurant_id,
    r.city,
    r.cuisine,
    r.rating
ORDER BY total_revenue DESC
LIMIT 10;


-- 4. TOP 10 RESTAURANTS BY ORDER VOLUME

SELECT
    r.restaurant_id,
    r.city,
    r.cuisine,
    r.rating,
    COUNT(o.order_id) AS total_orders
FROM restaurants AS r
JOIN orders_medium AS o
    ON r.restaurant_id = o.restaurant_id
GROUP BY
    r.restaurant_id,
    r.city,
    r.cuisine,
    r.rating
ORDER BY total_orders DESC
LIMIT 10;


-- 5. RESTAURANT AVERAGE ORDER VALUE

SELECT
    r.restaurant_id,
    r.city,
    r.cuisine,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        SUM(oi.quantity * oi.price) /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM restaurants AS r
JOIN orders_medium AS o
    ON r.restaurant_id = o.restaurant_id
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY
    r.restaurant_id,
    r.city,
    r.cuisine
ORDER BY average_order_value DESC;


-- 6. RESTAURANT RATING VS ORDER VOLUME

SELECT
    r.restaurant_id,
    r.city,
    r.cuisine,
    r.rating,
    COUNT(o.order_id) AS total_orders
FROM restaurants AS r
LEFT JOIN orders_medium AS o
    ON r.restaurant_id = o.restaurant_id
GROUP BY
    r.restaurant_id,
    r.city,
    r.cuisine,
    r.rating
ORDER BY
    r.rating DESC,
    total_orders DESC;


-- 7. RESTAURANT RATING VS REVENUE

SELECT
    r.restaurant_id,
    r.city,
    r.cuisine,
    r.rating,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM restaurants AS r
JOIN orders_medium AS o
    ON r.restaurant_id = o.restaurant_id
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY
    r.restaurant_id,
    r.city,
    r.cuisine,
    r.rating
ORDER BY
    r.rating DESC,
    total_revenue DESC;


-- 8. CUISINE-WISE RESTAURANT PERFORMANCE

SELECT
    r.cuisine,
    COUNT(DISTINCT r.restaurant_id) AS total_restaurants,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue,
    ROUND(
        SUM(oi.quantity * oi.price) /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM restaurants AS r
JOIN orders_medium AS o
    ON r.restaurant_id = o.restaurant_id
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY r.cuisine
ORDER BY total_revenue DESC;


-- 9. CITY-WISE RESTAURANT PERFORMANCE

SELECT
    r.city,
    COUNT(DISTINCT r.restaurant_id) AS total_restaurants,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue
FROM restaurants AS r
JOIN orders_medium AS o
    ON r.restaurant_id = o.restaurant_id
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY r.city
ORDER BY total_revenue DESC;


-- 10. RESTAURANT DELIVERY PERFORMANCE

SELECT
    r.restaurant_id,
    r.city,
    r.cuisine,
    COUNT(o.order_id) AS total_orders,
    ROUND(
        AVG(
            TIMESTAMPDIFF(
                MINUTE,
                o.order_time,
                o.delivery_time
            )
        ),
        2
    ) AS avg_delivery_time_minutes
FROM restaurants AS r
JOIN orders_medium AS o
    ON r.restaurant_id = o.restaurant_id
WHERE o.delivery_time IS NOT NULL
GROUP BY
    r.restaurant_id,
    r.city,
    r.cuisine
ORDER BY avg_delivery_time_minutes;


-- 11. TOP 10 SLOWEST RESTAURANTS

SELECT
    r.restaurant_id,
    r.city,
    r.cuisine,
    r.rating,
    ROUND(
        AVG(
            TIMESTAMPDIFF(
                MINUTE,
                o.order_time,
                o.delivery_time
            )
        ),
        2
    ) AS avg_delivery_time_minutes
FROM restaurants AS r
JOIN orders_medium AS o
    ON r.restaurant_id = o.restaurant_id
WHERE o.delivery_time IS NOT NULL
GROUP BY
    r.restaurant_id,
    r.city,
    r.cuisine,
    r.rating
ORDER BY avg_delivery_time_minutes DESC
LIMIT 10;


-- 12. RESTAURANT REVENUE CONTRIBUTION %

SELECT
    r.restaurant_id,
    r.city,
    r.cuisine,
    ROUND(SUM(oi.quantity * oi.price), 2) AS restaurant_revenue,
    ROUND(
        SUM(oi.quantity * oi.price) * 100.0 /
        (
            SELECT SUM(quantity * price)
            FROM `order_items (2)`
        ),
        2
    ) AS revenue_contribution_percentage
FROM restaurants AS r
JOIN orders_medium AS o
    ON r.restaurant_id = o.restaurant_id
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY
    r.restaurant_id,
    r.city,
    r.cuisine
ORDER BY restaurant_revenue DESC;


-- 13. RESTAURANT PERFORMANCE SUMMARY

SELECT
    r.restaurant_id,
    r.city,
    r.cuisine,
    r.rating,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.price), 2) AS total_revenue,
    ROUND(
        SUM(oi.quantity * oi.price) /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value,
    ROUND(
        AVG(
            TIMESTAMPDIFF(
                MINUTE,
                o.order_time,
                o.delivery_time
            )
        ),
        2
    ) AS avg_delivery_time_minutes
FROM restaurants AS r
JOIN orders_medium AS o
    ON r.restaurant_id = o.restaurant_id
JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
WHERE o.delivery_time IS NOT NULL
GROUP BY
    r.restaurant_id,
    r.city,
    r.cuisine,
    r.rating
ORDER BY total_revenue DESC;
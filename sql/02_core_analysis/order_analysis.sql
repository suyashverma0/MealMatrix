USE mealmetrics;

-- 1. Total Orders
SELECT
    COUNT(*) AS total_orders
FROM orders_medium;


-- 2. Orders by Status
SELECT
    status,
    COUNT(*) AS order_count
FROM orders_medium
GROUP BY status
ORDER BY order_count DESC;


-- 3. Order Percentage by Status
SELECT
    status,
    COUNT(*) AS order_count,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders_medium),
        2
    ) AS percentage
FROM orders_medium
GROUP BY status
ORDER BY order_count DESC;


-- 4. Orders by Restaurant
SELECT
    restaurant_id,
    COUNT(*) AS total_orders
FROM orders_medium
GROUP BY restaurant_id
ORDER BY total_orders DESC;


-- 5. Orders by Customer
SELECT
    customer_id,
    COUNT(*) AS total_orders
FROM orders_medium
GROUP BY customer_id
ORDER BY total_orders DESC;


-- 6. Top 10 Customers by Number of Orders
SELECT
    customer_id,
    COUNT(*) AS total_orders
FROM orders_medium
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;


-- 7. Top 10 Restaurants by Number of Orders
SELECT
    restaurant_id,
    COUNT(*) AS total_orders
FROM orders_medium
GROUP BY restaurant_id
ORDER BY total_orders DESC
LIMIT 10;


-- 8. Orders by Date
SELECT
    DATE(order_time) AS order_date,
    COUNT(*) AS total_orders
FROM orders_medium
GROUP BY DATE(order_time)
ORDER BY order_date;


-- 9. Orders by Month
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


-- 10. Orders by Day of Week
SELECT
    DAYNAME(order_time) AS day_name,
    COUNT(*) AS total_orders
FROM orders_medium
GROUP BY DAYNAME(order_time)
ORDER BY total_orders DESC;


-- 11. Orders by Hour
SELECT
    HOUR(order_time) AS order_hour,
    COUNT(*) AS total_orders
FROM orders_medium
GROUP BY HOUR(order_time)
ORDER BY order_hour;


-- 12. Average Delivery Time in Minutes
SELECT
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
WHERE delivery_time IS NOT NULL;


-- 13. Minimum and Maximum Delivery Time
SELECT
    MIN(
        TIMESTAMPDIFF(
            MINUTE,
            order_time,
            delivery_time
        )
    ) AS minimum_delivery_time_minutes,

    MAX(
        TIMESTAMPDIFF(
            MINUTE,
            order_time,
            delivery_time
        )
    ) AS maximum_delivery_time_minutes
FROM orders_medium
WHERE delivery_time IS NOT NULL;


-- 14. Restaurant-wise Average Delivery Time
SELECT
    restaurant_id,
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
GROUP BY restaurant_id
ORDER BY avg_delivery_time_minutes;


-- 15. Customer-wise Average Delivery Time
SELECT
    customer_id,
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
GROUP BY customer_id
ORDER BY avg_delivery_time_minutes;


-- 16. Orders with Delivery Time Greater Than 60 Minutes
SELECT
    order_id,
    customer_id,
    restaurant_id,
    order_time,
    delivery_time,
    TIMESTAMPDIFF(
        MINUTE,
        order_time,
        delivery_time
    ) AS delivery_time_minutes
FROM orders_medium
WHERE delivery_time IS NOT NULL
  AND TIMESTAMPDIFF(
        MINUTE,
        order_time,
        delivery_time
      ) > 60
ORDER BY delivery_time_minutes DESC;


-- 17. Orders with Restaurant Information
SELECT
    o.order_id,
    o.customer_id,
    o.restaurant_id,
    r.cuisine,
    r.city,
    r.rating,
    o.order_time,
    o.delivery_time,
    o.status
FROM orders_medium AS o
JOIN restaurants AS r
    ON o.restaurant_id = r.restaurant_id
ORDER BY o.order_time;


-- 18. Orders by City
SELECT
    r.city,
    COUNT(o.order_id) AS total_orders
FROM orders_medium AS o
JOIN restaurants AS r
    ON o.restaurant_id = r.restaurant_id
GROUP BY r.city
ORDER BY total_orders DESC;


-- 19. Orders by Cuisine
SELECT
    r.cuisine,
    COUNT(o.order_id) AS total_orders
FROM orders_medium AS o
JOIN restaurants AS r
    ON o.restaurant_id = r.restaurant_id
GROUP BY r.cuisine
ORDER BY total_orders DESC;


-- 20. Order Items per Order
SELECT
    o.order_id,
    COUNT(oi.item_id) AS total_items
FROM orders_medium AS o
LEFT JOIN `order_items (2)` AS oi
    ON o.order_id = oi.order_id
GROUP BY o.order_id
ORDER BY total_items DESC;


-- 21. Average Items per Order
SELECT
    ROUND(
        AVG(item_count),
        2
    ) AS avg_items_per_order
FROM (
    SELECT
        order_id,
        COUNT(item_id) AS item_count
    FROM `order_items (2)`
    GROUP BY order_id
) AS order_item_counts;


-- 22. Total Quantity of Items Sold per Order
SELECT
    order_id,
    SUM(quantity) AS total_quantity
FROM `order_items (2)`
GROUP BY order_id
ORDER BY total_quantity DESC;


-- 23. Top 10 Orders by Quantity of Items
SELECT
    order_id,
    SUM(quantity) AS total_quantity
FROM `order_items (2)`
GROUP BY order_id
ORDER BY total_quantity DESC
LIMIT 10;


-- 24. Order Summary with Customer and Restaurant Details
SELECT
    o.order_id,
    o.customer_id,
    c.city AS customer_city,
    o.restaurant_id,
    r.cuisine,
    r.city AS restaurant_city,
    r.rating,
    o.order_time,
    o.delivery_time,
    o.status
FROM orders_medium AS o
JOIN customers_medium AS c
    ON o.customer_id = c.customer_id
JOIN restaurants AS r
    ON o.restaurant_id = r.restaurant_id
ORDER BY o.order_time;
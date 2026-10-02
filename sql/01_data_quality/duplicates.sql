USE mealmetrics;


-- DUPLICATE ANALYSIS



-- Customers
SELECT
    customer_id,
    COUNT(*) AS duplicate_count
FROM customers_medium
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- Menu Items
SELECT
    item_id,
    COUNT(*) AS duplicate_count
FROM menu_items
GROUP BY item_id
HAVING COUNT(*) > 1;


-- Orders
SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM orders_medium
GROUP BY order_id
HAVING COUNT(*) > 1;


-- Restaurants
SELECT
    restaurant_id,
    COUNT(*) AS duplicate_count
FROM restaurants
GROUP BY restaurant_id
HAVING COUNT(*) > 1;


-- Order Items


SELECT
    order_id,
    item_id,
    COUNT(*) AS duplicate_count
FROM `order_items (2)`
GROUP BY order_id, item_id
HAVING COUNT(*) > 1;
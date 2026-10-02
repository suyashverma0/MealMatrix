USE mealmetrics;

-- Row count of all tables

SELECT 
    'customers_medium' AS table_name,
    COUNT(*) AS row_count
FROM customers_medium

UNION ALL

SELECT 
    'menu_items',
    COUNT(*)
FROM menu_items

UNION ALL

SELECT 
    'order_items (2)',
    COUNT(*)
FROM `order_items (2)`

UNION ALL

SELECT 
    'orders_medium',
    COUNT(*)
FROM orders_medium

UNION ALL

SELECT 
    'restaurants',
    COUNT(*)
FROM restaurants;

DESCRIBE customers_medium;
DESCRIBE menu_items;
DESCRIBE `order_items (2)`;
DESCRIBE orders_medium;
DESCRIBE restaurants;
USE mealmetrics;



-- Customers
SELECT
    'customers_medium' AS table_name,
    SUM(customer_id IS NULL) AS customer_id_nulls,
    SUM(city IS NULL) AS city_nulls,
    SUM(signup_date IS NULL) AS signup_date_nulls
FROM customers_medium;


-- Menu Items
SELECT
    'menu_items' AS table_name,
    SUM(item_id IS NULL) AS item_id_nulls,
    SUM(restaurant_id IS NULL) AS restaurant_id_nulls,
    SUM(price IS NULL) AS price_nulls
FROM menu_items;


-- Order Items
SELECT
    'order_items (2)' AS table_name,
    SUM(order_id IS NULL) AS order_id_nulls,
    SUM(item_id IS NULL) AS item_id_nulls,
    SUM(quantity IS NULL) AS quantity_nulls,
    SUM(price IS NULL) AS price_nulls
FROM `order_items (2)`;


-- Orders
SELECT
    'orders_medium' AS table_name,
    SUM(order_id IS NULL) AS order_id_nulls,
    SUM(customer_id IS NULL) AS customer_id_nulls,
    SUM(restaurant_id IS NULL) AS restaurant_id_nulls,
    SUM(order_time IS NULL) AS order_time_nulls,
    SUM(delivery_time IS NULL) AS delivery_time_nulls,
    SUM(status IS NULL) AS status_nulls
FROM orders_medium;


-- Restaurants
SELECT
    'restaurants' AS table_name,
    SUM(restaurant_id IS NULL) AS restaurant_id_nulls,
    SUM(cuisine IS NULL) AS cuisine_nulls,
    SUM(city IS NULL) AS city_nulls,
    SUM(rating IS NULL) AS rating_nulls
FROM restaurants;
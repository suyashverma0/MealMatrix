USE mealmetrics;

-- 1. Total Menu Items
SELECT
    COUNT(*) AS total_menu_items
FROM menu_items;


-- 2. Average Price of Menu Items
SELECT
    ROUND(AVG(price), 2) AS average_item_price
FROM menu_items;


-- 3. Minimum and Maximum Menu Item Price
SELECT
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price
FROM menu_items;


-- 4. Number of Menu Items Offered by Each Restaurant
SELECT
    restaurant_id,
    COUNT(item_id) AS menu_item_count
FROM menu_items
GROUP BY restaurant_id
ORDER BY menu_item_count DESC;


-- 5. Average Menu Price for Each Restaurant
SELECT
    restaurant_id,
    ROUND(AVG(price), 2) AS average_item_price
FROM menu_items
GROUP BY restaurant_id
ORDER BY average_item_price DESC;


-- 6. Most Expensive Menu Items
SELECT
    item_id,
    restaurant_id,
    price
FROM menu_items
ORDER BY price DESC
LIMIT 10;


-- 7. Cheapest Menu Items
SELECT
    item_id,
    restaurant_id,
    price
FROM menu_items
ORDER BY price ASC
LIMIT 10;


-- 8. Menu Items with Restaurant Information
SELECT
    m.item_id,
    m.restaurant_id,
    r.city,
    r.cuisine,
    r.rating,
    m.price
FROM menu_items AS m
JOIN restaurants AS r
    ON m.restaurant_id = r.restaurant_id
ORDER BY m.price DESC;


-- 9. Average Menu Price by Cuisine
SELECT
    r.cuisine,
    COUNT(m.item_id) AS total_items,
    ROUND(AVG(m.price), 2) AS average_item_price
FROM menu_items AS m
JOIN restaurants AS r
    ON m.restaurant_id = r.restaurant_id
GROUP BY r.cuisine
ORDER BY average_item_price DESC;


-- 10. Top 10 Restaurants with Largest Menus
SELECT
    r.restaurant_id,
    r.city,
    r.cuisine,
    COUNT(m.item_id) AS total_menu_items
FROM restaurants AS r
JOIN menu_items AS m
    ON r.restaurant_id = m.restaurant_id
GROUP BY
    r.restaurant_id,
    r.city,
    r.cuisine
ORDER BY total_menu_items DESC
LIMIT 10;
USE mealmetrics;

-- Total number of restaurants

SELECT
    COUNT(*) AS total_restaurants
FROM restaurants;

-- Number of restaurants in each city

SELECT
    city,
    COUNT(*) AS restaurant_count
FROM restaurants
GROUP BY city
ORDER BY restaurant_count DESC;

-- Number of restaurants by cuisine

SELECT
    cuisine,
    COUNT(*) AS restaurant_count
FROM restaurants
GROUP BY cuisine
ORDER BY restaurant_count DESC;

-- Average restaurant rating for each cuisine

SELECT
    cuisine,
    ROUND(AVG(rating), 2) AS avg_rating
FROM restaurants
GROUP BY cuisine
ORDER BY avg_rating DESC;

-- Number of orders received by each restaurant

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

-- Restaurants that have not received any orders

SELECT
    r.restaurant_id,
    r.city,
    r.cuisine,
    r.rating
FROM restaurants AS r
LEFT JOIN orders_medium AS o
    ON r.restaurant_id = o.restaurant_id
WHERE o.order_id IS NULL;

-- Restaurant performance overview

SELECT
    r.restaurant_id,
    r.city,
    r.cuisine,
    ROUND(r.rating, 2) AS rating,
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

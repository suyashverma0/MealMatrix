USE mealmetrics;

-- Total customers
SELECT COUNT(*) AS total_customers
FROM customers_medium;
-- Customers by city
SELECT
    city,
    COUNT(*) AS customer_count
FROM customers_medium
GROUP BY city
ORDER BY customer_count DESC;

-- Customers by signup date
SELECT
    signup_date,
    COUNT(*) AS new_customers
FROM customers_medium
GROUP BY signup_date
ORDER BY signup_date;

-- Orders placed by each customer

SELECT
    c.customer_id,
    COUNT(o.order_id) AS total_orders
FROM customers_medium AS c
LEFT JOIN orders_medium AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_orders DESC;

-- Average number of orders per customer

SELECT
    ROUND(AVG(order_count), 2) AS avg_orders_per_customer
FROM (
    SELECT
        customer_id,
        COUNT(order_id) AS order_count
    FROM orders_medium
    GROUP BY customer_id
) AS customer_orders;


-- Customers who placed more than one order

SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders_medium
GROUP BY customer_id
HAVING COUNT(order_id) > 1
ORDER BY total_orders DESC;

-- Customers who have placed at least one order

SELECT
    COUNT(DISTINCT customer_id) AS active_customers
FROM orders_medium;
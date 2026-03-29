CREATE VIEW clean_orders AS
SELECT * FROM olist_orders_dataset
WHERE order_status = 'delivered' AND
order_purchase_timestamp < '2018-09-01';

-- Monthly Revenue Trend
SELECT DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS `year_month`, 
SUM(p.payment_value) AS revenue FROM 
clean_orders o 
JOIN olist_order_payments_dataset p
ON o.order_id = p.order_id
WHERE o.order_status = 'delivered' 
GROUP BY `year_month`
ORDER BY `year_month`;

-- Top Product Categories
SELECT 
pt.product_category_name_english AS category,
SUM(oi.price) AS revenue
FROM clean_orders o
JOIN olist_order_items_dataset oi 
    ON o.order_id = oi.order_id
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
JOIN product_category_name_translation pt
    ON pt.product_category_name = p.product_category_name
GROUP BY category
ORDER BY revenue DESC
LIMIT 10;

-- Average Order Value
SELECT SUM(p.payment_value)/COUNT(DISTINCT p.order_id)
AS avg_order_value
FROM clean_orders_table o
JOIN olist_order_payments_dataset p
ON o.order_id = p.order_id;

-- Top Customer Cities
SELECT COUNT(DISTINCT o.order_id) AS total_orders , c.customer_city 
FROM clean_orders_table o
JOIN olist_customers_dataset c
ON o.customer_id = c.customer_id
GROUP BY c.customer_city
ORDER BY total_orders DESC
LIMIT 10;

-- Customer Spend Analysis
SELECT c.customer_unique_id, SUM(p.payment_value) AS customer_spend
FROM clean_orders_table o
JOIN olist_customers_dataset c 
ON o.customer_id = c.customer_id
JOIN olist_order_payments_dataset p 
ON p.order_id = o.order_id
GROUP BY c.customer_unique_id
ORDER BY customer_spend DESC;

-- Segment Customers
SELECT CASE
WHEN total_spend < 100 THEN 'Low Value' 
WHEN total_spend BETWEEN 100 AND 500 THEN 'Medium Value'
ELSE 'High Value'
END AS customer_segment,
COUNT(*) AS num_customers
FROM
( SELECT c.customer_unique_id, SUM(p.payment_value)
AS total_spend
FROM clean_orders_table o
JOIN olist_customers_dataset c
ON o.customer_id = c.customer_id
JOIN olist_order_payments_dataset p
ON p.order_id = o.order_id
GROUP BY c.customer_unique_id
) t
GROUP BY customer_segment;

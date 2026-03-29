-- RFM core table
WITH payment_per_order AS(
SELECT order_id, SUM(payment_value) AS total_payment
FROM olist_order_payments_dataset
GROUP BY order_id)
SELECT c.customer_unique_id, 
MAX(o.order_purchase_timestamp) AS last_purchase,
DATEDIFF('2018-08-31', MAX(o.order_purchase_timestamp)) AS recency,
COUNT(DISTINCT o.order_id) AS frequency,
SUM(p.payment_value) AS monetary
FROM clean_orders_table o
JOIN olist_customers_dataset c
ON c.customer_id = o.customer_id
JOIN olist_order_payments_dataset p 
ON p.order_id = o.order_id 
GROUP BY c.customer_unique_id
ORDER BY frequency DESC;

-- Create a view
CREATE VIEW rfm_base AS
SELECT c.customer_unique_id, 
MAX(o.order_purchase_timestamp) AS last_purchase,
DATEDIFF('2018-08-31', MAX(o.order_purchase_timestamp)) AS recency,
COUNT(DISTINCT o.order_id) AS frequency,
SUM(DISTINCT p.payment_value) AS monetary
FROM clean_orders_table o
JOIN olist_customers_dataset c
ON c.customer_id = o.customer_id
JOIN olist_order_payments_dataset p 
ON p.order_id = o.order_id 
GROUP BY c.customer_unique_id
ORDER BY frequency DESC;

-- Number of rows
SELECT COUNT(*) FROM rfm_base;

-- Top spending customers
SELECT * FROM rfm_base
ORDER BY monetary DESC
LIMIT 5;

-- Date of purchase range
SELECT MIN(last_purchase) , MAX(last_purchase)
FROM rfm_base;

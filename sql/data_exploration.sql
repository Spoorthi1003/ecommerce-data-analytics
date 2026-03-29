-- Find total number of orders
SELECT COUNT(*) AS total_orders FROM olist_orders_dataset;

-- Find number of unique customers
SELECT COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM olist_customers_dataset;

-- Find the total revenue
SELECT SUM(payment_value) AS total_revenue
from olist_order_payments_dataset;

-- Time range of the data
SELECT MIN(order_purchase_timestamp) AS start_date,
MAX(order_purchase_timestamp) AS end_date
FROM olist_orders_dataset;

-- Find out the status of the orders
SELECT order_status, COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY order_status;

-- Monthly Order Trend
SELECT DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS `year_month`,
COUNT(*) AS order_count
FROM olist_orders_dataset
GROUP BY `year_month`
ORDER BY `year_month` ;

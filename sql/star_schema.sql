-- Creating dimension tables for the schema

CREATE TABLE dim_customers AS
SELECT DISTINCT customer_id, customer_unique_id,
customer_city, customer_state
FROM olist_customers_dataset;

CREATE TABLE dim_products AS
SELECT DISTINCT p.product_id,
t.product_category_name_english
FROM olist_products_dataset p 
LEFT JOIN product_category_name_translation t
ON p.product_category_name = t.product_category_name;

-- Creating fact tables for the schema

CREATE TABLE fact_order_items AS
SELECT oi.order_id, oi.product_id, 
oi.seller_id, oi.price
FROM olist_order_items_dataset oi 
JOIN clean_orders_table co
ON co.order_id = oi.order_id;

CREATE TABLE fact_orders AS
WITH payment_per_order AS(
SELECT order_id, SUM(payment_value) AS total_payment
FROM olist_order_payments_dataset 
GROUP BY order_id
)
SELECT co.order_id, co.customer_id,
DATE(co.order_purchase_timestamp) AS order_date,
co.order_status , p.total_payment
FROM clean_orders_table co 
JOIN payment_per_order p 
ON p.order_id = co.order_id;

-- Table to store dates

CREATE TABLE dim_dates AS
WITH RECURSIVE date_series AS(
SELECT DATE('2016-04-01') AS full_date
UNION
SELECT DATE_ADD(full_date, INTERVAL 1 DAY)
FROM date_series
WHERE full_date < '2018-09-01'
)
SELECT full_date,
YEAR(full_date) AS `year`,
MONTH(full_date) AS month_number,
MONTHNAME(full_date) AS month_name, 
QUARTER(full_date) AS `quarter`,
DATE_FORMAT(full_date, '%Y-%m') AS year_mth
FROM date_series;

-- Cross checking DAX formula results with SQL queries
-- Total revenue
SELECT SUM(total_payment) AS total_revenue
FROM fact_orders;

-- Total orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM fact_orders;

-- Total customers
SELECT COUNT(DISTINCT customer_unique_id) AS total_customers
FROM dim_customers;

-- Average order value
SELECT SUM(total_payment)/COUNT(DISTINCT order_id)
AS average_order_value
FROM fact_orders;

-- Total items sold
SELECT COUNT(*) AS total_items
FROM fact_order_items;

-- Repeat Customers
SELECT COUNT(*) AS repeat_customer_count
FROM (
SELECT dc.customer_unique_id
FROM dim_customers dc 
JOIN fact_orders fo 
ON fo.customer_id = dc.customer_id
GROUP BY dc.customer_unique_id
HAVING COUNT(fo.order_id) >1
)t;


  


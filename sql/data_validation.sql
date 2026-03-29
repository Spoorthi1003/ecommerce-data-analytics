-- Checking for duplicate orders
SELECT order_id , COUNT(*) 
FROM olist_orders_dataset
GROUP BY order_id
HAVING COUNT(*)>1;

-- Check for NULL purchase dates
SELECT COUNT(*) AS null_dates
FROM olist_orders_dataset
WHERE order_purchase_timestamp IS NULL;

-- Check for invalid payments
SELECT order_id, payment_value
FROM olist_order_payments_dataset
WHERE payment_value <= 0;

-- Check orders without payment
SELECT COUNT(*) 
FROM olist_orders_dataset o 
LEFT JOIN olist_order_payments_dataset p
ON o.order_id = p.order_id
WHERE p.order_id IS NULL;

-- Check empty categories
SELECT COUNT(*) AS empty_categories
FROM olist_products_dataset
WHERE product_category_name IS NULL;
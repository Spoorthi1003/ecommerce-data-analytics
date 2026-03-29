CREATE INDEX idx_orders_order_id
ON olist_orders_dataset(order_id);

CREATE INDEX idx_items_order_id
ON olist_order_items_dataset(order_id);

CREATE INDEX idx_items_product_id
ON olist_order_items_dataset(product_id);

CREATE INDEX idx_products_product_category
ON olist_products_dataset(product_category_name);

CREATE INDEX idx_products_product_id
ON olist_products_dataset(product_id);

CREATE index idx_products_category_translation
ON product_category_name_translation(product_category_name);

-- Create table for clean orders as we cannot create index on view
CREATE TABLE clean_orders_table AS
SELECT * FROM olist_orders_dataset
WHERE order_status='delivered' AND
order_purchase_timestamp < '2018-09-01';

CREATE INDEX idx_clean_orders_order_id
ON clean_orders_table(order_id);

CREATE INDEX idx_payment_order_id
ON olist_order_payments_dataset(order_id);

CREATE INDEX idx_customers_customer_id
ON olist_customers_dataset(customer_id);

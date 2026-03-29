CREATE DATABASE ecommerce_project;
USE ecommerce_project;

SET GLOBAL local_infile = 1;

CREATE TABLE olist_orders_dataset (
order_id VARCHAR(50),
customer_id VARCHAR(50),
order_status VARCHAR(20),
order_purchase_timestamp TEXT,
order_approved_at TEXT,
order_delivered_carrier_date TEXT,
order_delivered_customer_date TEXT,
order_estimated_delivery_date TEXT
);


LOAD DATA LOCAL INFILE 'C:/Users/sua5/Desktop/CWH/ecommerce-project/olist_orders_dataset.csv'
INTO TABLE olist_orders_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM olist_customers_dataset;

CREATE TABLE olist_products_dataset (
product_id VARCHAR(50),
product_category_name VARCHAR(50),
product_name_lenght INT,
product_description_lenght INT,
product_photos_qty INT,
product_weight_g INT,
product_length_cm INT,
product_height_cm INT,
product_width_cm INT );

LOAD DATA LOCAL INFILE 'C:/Users/sua5/Desktop/CWH/ecommerce-project/olist_products_dataset.csv'
INTO TABLE olist_products_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE olist_customers_dataset(
customer_id VARCHAR(50),
customer_unique_id VARCHAR(50),
customer_zip_code_prefix INT,
customer_city VARCHAR(50),
customer_state VARCHAR(10)
);

LOAD DATA LOCAL INFILE 'C:/Users/sua5/Desktop/CWH/ecommerce-project/olist_customers_dataset.csv'
INTO TABLE olist_customers_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE product_category_name_translation(
product_category_name VARCHAR(50),
product_category_name_english VARCHAR(50)
);

LOAD DATA LOCAL INFILE 'C:/Users/sua5/Desktop/CWH/ecommerce-project/product_category_name_translation.csv'
INTO TABLE product_category_name_translation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE olist_order_items_dataset(
order_id VARCHAR(50),
order_item_id INT,
product_id VARCHAR(50),
seller_id VARCHAR(50),
shipping_limit_date TEXT,
price DECIMAL(10,2),
freight_value DECIMAL(10,2)
);

LOAD DATA LOCAL INFILE 'C:/Users/sua5/Desktop/CWH/ecommerce-project/olist_order_items_dataset.csv'
INTO TABLE olist_order_items_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE olist_order_payments_dataset(
order_id VARCHAR(50),
payment_sequential INT,
payment_type VARCHAR(50),
payment_installments INT,
payment_value DECIMAL(10,2)
);

LOAD DATA LOCAL INFILE 'C:/Users/sua5/Desktop/CWH/ecommerce-project/olist_order_payments_dataset.csv'
INTO TABLE olist_order_payments_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


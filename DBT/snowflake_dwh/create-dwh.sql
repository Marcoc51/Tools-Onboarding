CREATE OR REPLACE WAREHOUSE finance_wh
WITH WAREHOUSE_SIZE = 'XSMALL'
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE
INITIALLY_SUSPENDED = TRUE;

CREATE OR REPLACE DATABASE finance_db;
CREATE OR REPLACE SCHEMA raw;

CREATE OR REPLACE TABLE raw.customers (
    id INT PRIMARY KEY
    ,name VARCHAR
    ,email VARCHAR
    ,country VARCHAR
);

CREATE OR REPLACE TABLE raw.orders (
    id INT PRIMARY KEY
    ,customer_id INT
    ,order_date DATE
    ,total_amount INT
    ,status VARCHAR
);

CREATE OR REPLACE TABLE raw.order_items (
    id INT
    ,order_id INT
    ,product_id INT
    ,quantity INT
    ,unit_price INT
);

CREATE OR REPLACE TABLE raw.products (
    id INT PRIMARY KEY
    ,name STRING
    ,category STRING
    ,price INT
);


CREATE OR REPLACE STAGE finance_stage
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1);

COPY INTO raw.products
FROM @finance_stage/products.csv
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1);


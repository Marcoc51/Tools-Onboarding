CREATE TABLE retail.fact_sales (
    sale_id INT PRIMARY KEY
    ,customer_id INT REFERENCES retail.dim_customers(customer_id)
    ,product_id INT REFERENCES retail.dim_products(product_id)
    ,store_id INT REFERENCES retail.dim_stores(store_id)
    ,sale_date DATE REFERENCES retail.dim_time(date_id)
    ,quantity_sold INT
    ,total_amount DECIMAL(10, 2)
);

CREATE TABLE retail.fact_inventory (
    inventory_id INT PRIMARY KEY
    ,product_id INT REFERENCES retail.dim_products(product_id)
    ,store_id INT REFERENCES retail.dim_stores(store_id)
    ,stock_date DATE REFERENCES retail.dim_time(date_id)
    ,stock_level INT
);
INSERT INTO retail.dim_customers (customer_id, customer_name, email, region, signup_date)
SELECT 
    ROW_NUMBER() OVER () AS customer_id,
    'Customer_' || TRIM(TO_CHAR(ROW_NUMBER() OVER (), '000000')) AS customer_name,
    'customer' || ROW_NUMBER() OVER () || '@example.com' AS email,
    CASE WHEN RANDOM() < 0.2 THEN 'North'
         WHEN RANDOM() < 0.4 THEN 'South'
         WHEN RANDOM() < 0.6 THEN 'East'
         WHEN RANDOM() < 0.8 THEN 'West'
         ELSE 'Central'
    END AS region,
    DATEADD(day, FLOOR(RANDOM() * 1000)::INT, '2020-01-01') AS signup_date
FROM stv_blocklist
LIMIT 100000;

INSERT INTO retail.dim_products (product_id, product_name, category, price)
SELECT 
    ROW_NUMBER() OVER () AS product_id,
    'Product_' || TRIM(TO_CHAR(ROW_NUMBER() OVER (), '000000')) AS product_name,
    CASE WHEN RANDOM() < 0.3 THEN 'Electronics'
         WHEN RANDOM() < 0.6 THEN 'Footwear'
         ELSE 'Apparel'
    END AS category,
    ROUND(10 + (RANDOM() * 490)::NUMERIC, 2) AS price -- between 10 and 500
FROM stv_blocklist
LIMIT 100000;

INSERT INTO retail.dim_stores (store_id, store_name, location, manager_name)
SELECT 
    ROW_NUMBER() OVER () AS store_id,
    'Store_' || TRIM(TO_CHAR(ROW_NUMBER() OVER (), '000000')) AS store_name,
    CASE WHEN RANDOM() < 0.25 THEN 'New York, NY'
         WHEN RANDOM() < 0.5 THEN 'Chicago, IL'
         WHEN RANDOM() < 0.75 THEN 'Austin, TX'
         ELSE 'Miami, FL'
    END AS location,
    'Manager_' || TRIM(TO_CHAR(ROW_NUMBER() OVER (), '000000')) AS manager_name
FROM stv_blocklist
LIMIT 100000;

INSERT INTO retail.dim_time (date_id, year, quarter, month, day, day_of_week)
SELECT 
    DATEADD(day, ROW_NUMBER() OVER (), '2020-01-01')::DATE AS date_id,
    EXTRACT(YEAR FROM DATEADD(day, ROW_NUMBER() OVER (), '2020-01-01')) AS year,
    CEILING(EXTRACT(MONTH FROM DATEADD(day, ROW_NUMBER() OVER (), '2020-01-01')) / 3.0) AS quarter,
    EXTRACT(MONTH FROM DATEADD(day, ROW_NUMBER() OVER (), '2020-01-01')) AS month,
    EXTRACT(DAY FROM DATEADD(day, ROW_NUMBER() OVER (), '2020-01-01')) AS day,
    CASE EXTRACT(DOW FROM DATEADD(day, ROW_NUMBER() OVER (), '2020-01-01'))
        WHEN 0 THEN 'Sunday'
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
        WHEN 6 THEN 'Saturday'
    END AS day_of_week
FROM stv_blocklist
LIMIT 100000;

INSERT INTO retail.dim_employees (employee_id, employee_name, department, employment_type, hire_date, store_id)
SELECT 
    ROW_NUMBER() OVER () AS employee_id,
    'Employee_' || TRIM(TO_CHAR(ROW_NUMBER() OVER (), '000000')) AS employee_name,
    CASE WHEN RANDOM() < 0.5 THEN 'Sales'
         ELSE 'Support'
    END AS department,
    CASE WHEN RANDOM() < 0.7 THEN 'Full-Time'
         ELSE 'Part-Time'
    END AS employment_type,
    DATEADD(day, FLOOR(RANDOM() * 1000)::INT, '2018-01-01') AS hire_date,
    FLOOR(RANDOM() * 5000)::INT + 1 AS store_id -- assuming 5000 stores exist
FROM stv_blocklist
LIMIT 100000;

INSERT INTO retail.fact_sales (sale_id, customer_id, product_id, store_id, sale_date, quantity_sold, total_amount)
SELECT 
    ROW_NUMBER() OVER () AS sale_id,
    FLOOR(RANDOM() * 100000)::INT + 1 AS customer_id,    -- Random customer_id between 1 and 100000
    FLOOR(RANDOM() * 100000)::INT + 1 AS product_id,      -- Random product_id between 1 and 100000
    FLOOR(RANDOM() * 100000)::INT + 1 AS store_id,        -- Random store_id between 1 and 100000
    DATEADD(day, FLOOR(RANDOM() * 1000)::INT, '2020-01-01')::DATE AS sale_date, -- Random sale date
    FLOOR(RANDOM() * 10)::INT + 1 AS quantity_sold,       -- Between 1 and 10 units
    ROUND((10 + RANDOM() * 490) * (FLOOR(RANDOM() * 10)::INT + 1), 2) AS total_amount -- Price * Quantity
FROM stv_blocklist
LIMIT 100000;

INSERT INTO retail.fact_inventory (inventory_id, product_id, store_id, stock_date, stock_level)
SELECT 
    ROW_NUMBER() OVER () AS inventory_id,
    FLOOR(RANDOM() * 100000)::INT + 1 AS product_id,       -- Random product_id
    FLOOR(RANDOM() * 100000)::INT + 1 AS store_id,         -- Random store_id
    DATEADD(day, FLOOR(RANDOM() * 1000)::INT, '2020-01-01')::DATE AS stock_date, -- Random stock date
    FLOOR(RANDOM() * 500)::INT + 1 AS stock_level          -- Stock between 1 and 500 units
FROM stv_blocklist
LIMIT 100000;

SELECT * FROM retail.fact_sales LIMIT 10;
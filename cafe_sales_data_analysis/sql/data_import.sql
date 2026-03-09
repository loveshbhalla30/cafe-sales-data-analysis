-- Create table
CREATE TABLE cafe_sales_dirty (
    transaction_id TEXT,
    item TEXT,
    quantity TEXT,
    price_per_unit TEXT,
    total_spent TEXT,
    payment_method TEXT,
    location TEXT,
    transaction_date TEXT
);
-- Import CSV in psql
\copy cafe_sales_dirty FROM 'C:\Users\HP\Desktop\dirty_cafe_sales.csv' DELIMITER ',' CSV HEADER;
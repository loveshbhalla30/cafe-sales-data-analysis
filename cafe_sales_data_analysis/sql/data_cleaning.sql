-- Replace invalid numeric values
UPDATE cafe_sales_dirty
SET quantity = NULL
WHERE quantity IN ('ERROR','UNKNOWN');

UPDATE cafe_sales_dirty
SET price_per_unit = NULL
WHERE price_per_unit IN ('ERROR','UNKNOWN');

UPDATE cafe_sales_dirty
SET total_spent = NULL
WHERE total_spent IN ('ERROR','UNKNOWN');


-- Convert datatype
ALTER TABLE cafe_sales_dirty
ALTER COLUMN quantity TYPE INTEGER
USING quantity::INTEGER;

ALTER TABLE cafe_sales_dirty
ALTER COLUMN price_per_unit TYPE FLOAT
USING price_per_unit::FLOAT;

ALTER TABLE cafe_sales_dirty
ALTER COLUMN total_spent TYPE FLOAT
USING total_spent::FLOAT;


-- Calculate missing quantity
UPDATE cafe_sales_dirty
SET quantity = total_spent / price_per_unit
WHERE quantity IS NULL
AND total_spent IS NOT NULL
AND price_per_unit IS NOT NULL;


-- Calculate missing price
UPDATE cafe_sales_dirty
SET price_per_unit = total_spent / quantity
WHERE price_per_unit IS NULL
AND total_spent IS NOT NULL
AND quantity IS NOT NULL;


-- Fix totals
UPDATE cafe_sales_dirty
SET total_spent = quantity * price_per_unit
WHERE total_spent IS NULL
AND quantity IS NOT NULL
AND price_per_unit IS NOT NULL;


-- Remove unusable rows
DELETE FROM cafe_sales_dirty
WHERE quantity IS NULL
AND price_per_unit IS NULL;


-- Clean payment method
UPDATE cafe_sales_dirty
SET payment_method = 'UNKNOWN'
WHERE payment_method IS NULL
OR payment_method = 'ERROR';


-- Clean date values
UPDATE cafe_sales_dirty
SET transaction_date = NULL
WHERE transaction_date IN ('ERROR','UNKNOWN');


-- Convert Excel serial date to PostgreSQL date
ALTER TABLE cafe_sales_dirty
ALTER COLUMN transaction_date TYPE DATE
USING DATE '1899-12-30' + transaction_date::INT;


-- Remove rows with missing date
DELETE FROM cafe_sales_dirty
WHERE transaction_date IS NULL;


-- Remove missing values rows where total_spent and either quantity or price_per_unit is null
DELETE FROM cafe_sales_dirty WHERE (quantity IS NULL AND price_per_unit IS NULL)
OR (quantity IS NULL AND total_spent IS NULL) OR 
(price_per_unit IS NULL AND total_spent IS NULL);
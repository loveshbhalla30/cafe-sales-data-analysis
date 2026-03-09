-- Total revenue
SELECT SUM(total_spent) AS total_revenue
FROM cafe_sales_dirty
WHERE item IS NOT NULL
AND item NOT IN ('UNKNOWN','ERROR')
AND payment_method <> 'UNKNOWN';


--Total dirty revenue
SELECT 
    SUM(total_spent) AS dirty_revenue
FROM cafe_sales_dirty
WHERE item IS NULL
OR item IN ('UNKNOWN','ERROR')
OR payment_method = 'UNKNOWN';


-- Top selling items
SELECT item,
       SUM(quantity) AS total_quantity_sold
FROM cafe_sales_dirty
WHERE item IS NOT NULL
AND item NOT IN ('UNKNOWN','ERROR')
GROUP BY item
ORDER BY total_quantity_sold DESC;


-- Revenue by item
SELECT item,
       SUM(total_spent) AS revenue
FROM cafe_sales_dirty
WHERE item IS NOT NULL
AND item NOT IN ('UNKNOWN','ERROR')
GROUP BY item
ORDER BY revenue DESC;


-- Revenue by payment method
SELECT payment_method,
       SUM(total_spent) AS revenue
FROM cafe_sales_dirty
WHERE payment_method <> 'UNKNOWN'
GROUP BY payment_method
ORDER BY revenue DESC;


-- Sales by location
SELECT location,
       SUM(total_spent) AS revenue
FROM cafe_sales_dirty
WHERE location NOT IN ('UNKNOWN','ERROR')
AND location IS NOT NULL
GROUP BY location
ORDER BY revenue DESC;


-- Monthly revenue trend
SELECT DATE_TRUNC('month', transaction_date) AS month,
       SUM(total_spent) AS revenue
FROM cafe_sales_dirty
GROUP BY month
ORDER BY month;


--Dirty Data
SELECT COUNT(*) FROM CAFE_SALES_DIRTY
WHERE item IS NOT NULL
AND item NOT IN ('UNKNOWN','ERROR')
AND payment_method <> 'UNKNOWN'


--Unknown and Error Items
SELECT COUNT(*)
FROM cafe_sales_dirty
WHERE item IS NULL
OR item IN ('UNKNOWN','ERROR');


--Unknown Payment Method
SELECT COUNT(*)
FROM cafe_sales_dirty
WHERE payment_method = 'UNKNOWN';


--Total of invalid data
SELECT COUNT(*)
FROM cafe_sales_dirty
WHERE item IS NULL
OR item IN ('UNKNOWN','ERROR')
OR payment_method = 'UNKNOWN';
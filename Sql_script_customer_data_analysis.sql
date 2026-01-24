SELECT * FROM project_customer_segmentation.customer;
DESCRIBE project_customer_segmentation.customer;
-- I first understood the schema and data types.

SELECT COUNT(*) AS total_rows
FROM project_customer_segmentation.customer;
-- Total records

SELECT * 
FROM project_customer_segmentation.customer
LIMIT 10;
-- Sample data 

SELECT
 SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS age_nulls,
 SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS gender_nulls,
 SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS price_nulls
FROM project_customer_segmentation.customer;
-- Data Quality Checks

SELECT invoice_no, COUNT(*)
FROM project_customer_segmentation.customer
GROUP BY invoice_no
HAVING COUNT(*) > 1;
-- Duplicate invoices

SELECT
 price * quantity AS total_amount,
 YEAR(STR_TO_DATE(invoice_date, '%Y-%m-%d')) AS year,
 MONTH(STR_TO_DATE(invoice_date, '%Y-%m-%d')) AS month
FROM project_customer_segmentation.customer;
-- Revenue + Date features

-- TASK 

-- 1.How is the shopping distribution according to gender? 
SELECT gender,
       COUNT(*) AS total_transactions
FROM project_customer_segmentation.customer
 GROUP BY gender;

-- 2.Which gender did we sell more products to?
SELECT gender,
       SUM(quantity) AS total_products_sold
FROM project_customer_segmentation.customer
GROUP BY gender;

-- 3.Which gender generated more revenue?
SELECT 
  gender,
  SUM(price * quantity) AS total_revenue
FROM project_customer_segmentation.customer
GROUP BY gender;

-- 4.Distribution of purchase categories relative to other columns?
-- Category vs Gender
SELECT gender, category,
       SUM(price * quantity) AS revenue
FROM project_customer_segmentation.customer
GROUP BY gender, category
ORDER BY gender, revenue DESC;


-- Category vs Mall
SELECT shopping_mall, category,
       SUM(price * quantity) AS revenue
FROM project_customer_segmentation.customer
GROUP BY shopping_mall, category;

-- Category vs Payment Method
SELECT payment_method , CATEGORY,
SUM(PRICE*QUANTITY) AS REVENUE
	FROM project_customer_segmentation.customer
group by payment_method, category;

-- 5.How is the shopping distribution according to age?
-- Create Age Groups
SELECT CASE
 WHEN age BETWEEN 18 AND 25 THEN '18-25'
 WHEN age BETWEEN 26 AND 35 THEN '26-35'
 WHEN age BETWEEN 36 AND 45 THEN '36-45'
 ELSE '46+'
END AS age_group,
COUNT(*) AS transactions
FROM project_customer_segmentation.customer
GROUP BY age_group;

-- 6.Which age cat did we sell more products to?
-- Products sold by age group
SELECT
CASE
 WHEN age BETWEEN 18 AND 25 THEN '18-25'
 WHEN age BETWEEN 26 AND 35 THEN '26-35'
 WHEN age BETWEEN 36 AND 45 THEN '36-45'
 ELSE '46+'
END AS age_group,
SUM(quantity) AS products_sold
FROM project_customer_segmentation.customer
GROUP BY age_group;

-- 7.Which age cat generated more revenue?
-- Revenue by age group
SELECT
CASE
 WHEN age BETWEEN 18 AND 25 THEN '18-25'
 WHEN age BETWEEN 26 AND 35 THEN '26-35'
 WHEN age BETWEEN 36 AND 45 THEN '36-45'
 ELSE '46+'
END AS age_group,
SUM(PRICE * quantity) AS revenue
FROM  project_customer_segmentation.customer
GROUP BY age_group;
 
-- 8. Distribution of purchase categories relative to other columns?
-- Payment distribution
SELECT payment_method,
       COUNT(*) AS transactions
FROM project_customer_segmentation.customer
GROUP BY payment_method;

-- 9.Does the payment method have a relation with other columns?
-- Payment method vs Revenue
SELECT payment_method,
       SUM(PRICE * quantity) AS revenue
FROM project_customer_segmentation.customer
GROUP BY payment_method;

-- 10.How is the distribution of the payment method?
-- Payment vs Age Group
SELECT
payment_method,
CASE
 WHEN age BETWEEN 18 AND 25 THEN '18-25'
 WHEN age BETWEEN 26 AND 35 THEN '26-35'
 WHEN age BETWEEN 36 AND 45 THEN '36-45'
 ELSE '46+'
END AS age_group,
COUNT(*) AS transactions
FROM project_customer_segmentation.customer
GROUP BY payment_method, age_group;
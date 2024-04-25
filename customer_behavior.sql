CREATE DATABASE IF NOT EXISTS customerbehavior;

CREATE TABLE IF NOT EXISTS customer(
id INTEGER PRIMARY KEY,
age INTEGER,
gender TEXT,
income INTEGER,
education TEXT,
region TEXT,
loyalty_status TEXT,
purchase_freq TEXT,
purchase_amount INTEGER,
product_cat TEXT,
promotion_usage INTEGER,
satisfaction INTEGER

);

--
SELECT *
FROM customer;
-- before starting this analysis on cutomer behavior Id like to categorize the data in 5 different categories which are: 
-- Demographic Analysis
-- Loyalty and Engagement
-- Purchase Behavior
-- Promotion Analysis
-- Customer Satisfaction

 -- --------------------------------------------------------------- Demographic Analysis-------------------------------------------------

 -- What is the distribution of customers based on age, gender, income, and education?
 
 -- Age --
SELECT age, COUNT(*) AS count
FROM customer
GROUP BY age
ORDER BY age;

-- Gender --
SELECT gender, COUNT(*) AS count
FROM customer
GROUP BY gender;

-- Income --
SELECT 
    CASE 
        WHEN income < 30000 THEN 'Low Income'
        WHEN income BETWEEN 30000 AND 60000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS income_level,
    COUNT(*) AS num_customers,
    AVG(purchase_freq) AS avg_purchase_frequency,
    AVG(purchase_amount) AS avg_purchase_amount,
    AVG(satisfaction) AS avg_satisfaction_score
FROM customer
GROUP BY income_level
ORDER BY income_level;

-- Education --
SELECT education, COUNT(*) AS count
FROM customer
GROUP BY education;

-- How does customer age correlate with purchase frequency and amount?

SELECT DISTINCT age,COUNT(purchase_amount) AS number_of_purchases, purchase_freq
FROM customer
WHERE age BETWEEN 25 AND 40
GROUP BY age, purchase_freq
ORDER BY age;

-- Is there a pattern in purchase behavior based on customer region or income level?


SELECT region, 
	COUNT(*) AS customer_count,
	SUM(purchase_amount) AS total_purchase_amount,
	AVG(purchase_amount) AS avg_purchase_amount,
	COUNT(DISTINCT id)AS unique_customers
FROM customer
GROUP BY region;

-- -------------------------- Loyalty and Engagement -----------------------------

-- What percentage of customers fall into different loyalty status categories (e.g., loyal, occasional, new)?

SELECT *
FROM customer;

SELECT 
loyalty_status,
COUNT(*) AS num_customers,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer), 2) AS percentage
FROM customer
GROUP BY loyalty_status;
 
 
 -- How does loyalty status relate to purchase purchase amount and product category preferences?

SELECT 
loyalty_status,
AVG(purchase_amount) AS avg_purchase_amount,
MAX(product_cat) AS most_purchased_category
FROM customer
GROUP BY loyalty_status;

-- ------------------------------------- Purchase Behavior -------------------------------------

-- What are the top product categories purchased by customers?

SELECT product_cat, COUNT(purchase_amount) AS purchase_amount
FROM customer
GROUP BY product_cat
ORDER BY purchase_amount DESC;

-- -------------------------------------Promotion Analysis ---------------------------------------

-- What is the effectiveness of promotions in terms of increasing purchase frequency and amount?


SELECT promotion_usage, purchase_freq, purchase_amount
FROM customer
WHERE promotion_usage = 1;

-- How do different customer segments (based on demographics or loyalty status) respond to promotions?

SELECT *
FROM customer;

SELECT 
    CASE
        WHEN age < 30 THEN 'Young'
        WHEN age >= 30 AND age < 50 THEN 'Middle-aged'
        ELSE 'Senior'
    END AS age_segment,
    loyalty_status,
    AVG(promotion_usage) AS avg_promotion_usage,
    AVG(purchase_amount) AS avg_purchase_amount
FROM customer
GROUP BY age_segment, loyalty_status
ORDER BY age_segment, loyalty_status;

-- --------------------------------------- Customer Satisfaction ---------------------------

-- What is the overall satisfaction score distribution among customers?

SELECT 
satisfaction,
COUNT(*) AS num_customers
FROM customer
GROUP BY satisfaction
ORDER BY satisfaction;


-- Are there any factors (such as age, gender, or income) that correlate with higher satisfaction scores?


SELECT DISTINCT(gender), income, satisfaction, age
FROM customer
GROUP BY satisfaction, age, gender, income
ORDER BY Satisfaction DESC;

-- How does satisfaction score impact customer loyalty and repeat purchases?

SELECT loyalty_status, purchase_freq, satisfaction
FROM customer
ORDER BY satisfaction DESC
 
 




--
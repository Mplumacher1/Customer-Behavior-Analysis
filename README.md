## Customer-Behavior

# Dataset used: https://www.kaggle.com/datasets/sanyamgoyal401/customer-purchases-behaviour-dataset

# Overview
- In this GitHub repository analysis project, we aim to gain comprehensive insights into customer behavior and preferences across various categories. Our analysis delves into demographic factors such as age, gender, income, and education, exploring how these attributes influence customer engagement and purchasing patterns. Additionally, we investigate loyalty status segments to understand the dynamics between customer loyalty and key metrics like purchase frequency, amount, and product preferences. Furthermore, we examine the impact of promotions on different customer segments, aiming to uncover patterns in promotional response and its correlation with customer behavior. Lastly, we assess overall satisfaction scores to gauge customer sentiment and satisfaction levels, providing a holistic view of customer experience within the analyzed repository. Through these inquiries, we seek to inform strategic decision-making and optimize marketing efforts tailored to diverse customer segments and preferences.

# Tools/Software used:
- MySQL 
- Microsoft Excel


# Demographic Analysis:
- What is the distribution of customers based on age, gender, income, and education?
```sql 
SELECT age, COUNT(*) AS count
FROM customer
GROUP BY age
ORDER BY age;
```
age | count |
----|-------|
26	| 5691  |
27	| 6794  |
28	| 8018 |
29	| 8334 |
30	| 8599 |
31	| 8372 |
32	|7796 |
33	| 6987 |
34	| 5724 |
35	| 4737 |
36	| 3484 |
37	|2600 |
38	|1736 |
39	|1161 |
40	|652 |
41	|473 |
42	|240 |
43	| 118 |
44	| 57 |
45	| 35 |
46	|10 |
47	|13 |
48	|2 |
49	| 1 |

The highest count of customers appears to be in the late 20s to early 30s, with a peak around ages 29-33. 
There's a generally declining trend in customer count as age increases beyond the peak range.


```sql
SELECT gender, COUNT(*) AS count
FROM customer
GROUP BY gender;
```
gender| count|
------|------|
Male	| 48392|
Female	|48518|

```sql
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
```
income_level | num_customers | avg_purchase_frequency | avg_purchase_amount | avg_satisfaction_score|
-------------| -------------- |----------------------|----------------------|----------------------|
Low Income |	53601|	0|	6115.0399	|5.0052|
Medium Income|	43309	|0	|13992.2321|	5.0137|

```sql
SELECT education, COUNT(*) AS count
FROM customer
GROUP BY education;
```
education | count|
----------|-----|
Bachelor|	29319|
Masters|	9515|
HighSchool	|19416|
College|	38660|

- How does customer age correlate with purchase frequency and amount?
```sql
SELECT DISTINCT age,COUNT(purchase_amount) AS number_of_purchases, purchase_freq
FROM customer
WHERE age BETWEEN 25 AND 40
GROUP BY age, purchase_freq
ORDER BY age;
```
age | number_of_purchases | purchase_freq|
---- | ------------------| ---------------
25	|939	|frequent|
25	|1377	|occasional|
25|	2385	|rare|
26	|1141	|frequent|
26	|1709|	occasional|
26	|2841	|rare|
27	|1375|	frequent|
27	|2081|	occasional|
27|	3338	|rare|
28	|1621|	frequent|
28	|2487	|occasional|
28	|3910	|rare|
29	|1690	|frequent|
29	|2546	|occasional|
29	|4098	|rare|
30	|1763	|frequent|
30	|2517|	occasional|
30	|4319	|rare|
31	|1652|	frequent|
31	|2544	|occasional|
31	|4176|	rare|
32	|1585|	frequent|
32	|2284	|occasional|
32|	3927	|rare|
33	|1425	|frequent|
33|	2079	|occasional|
33	|3483|	rare|
34	|1169|	frequent|
34	|1664|	occasional|
34	|2891|	rare|
35	|944|	frequent|
35|	1382|	occasional|
35	|2411	|rare|
36	|676	|frequent|
36	|1023	|occasional|
36	|1785|	rare|
37	|541|	frequent|
37	|767|	occasional|
37	|1292	|rare|
38	|324	|frequent|
38	|502	|occasional|
38	|910|	rare|
39|	248	|frequent|
39	|353	|occasional|
39|	560	|rare|
40	|142|	frequent|
40	|213|occasional|
40	|297	|rare|

- Is there a pattern in purchase behavior based on customer region or income level?
```sql
SELECT region, 
COUNT(*) AS customer_count,
SUM(purchase_amount) AS total_purchase_amount,
AVG(purchase_amount) AS avg_purchase_amount,
COUNT(DISTINCT id)AS unique_customers
FROM customer
GROUP BY region;
```
region | customer_count | total_purchase_amount | avg_purchase_amount | unique_customers|
-------|---------------|-----------------------|---------------------|------------------|
East	|29159	280373013|	9615.3165|	29159|
North	|19293	|186741054	|9679.2129	|19293|
South	|19404|	187248309	|9649.9850	|19404|
West|	29054|	279399457|	9616.5573	|29054|


# Loyalty and Engagement:
- What percentage of customers fall into different loyalty status categories (e.g., loyal, occasional, new)?
```sql
loyalty_status,
COUNT(*) AS num_customers,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer), 2) AS percentage
FROM customer
GROUP BY loyalty_status;
```
loyalty_status| num_customers | percentage|
-------------|--------------|------------|
Gold	|9568	|9.87|
Regular|	58316|	60.18|
Silver	|29026|	29.95|

- How does loyalty status relate to purchase frequency, purchase amount, and product category preferences?
```sql
SELECT 
loyalty_status,
AVG(purchase_amount) AS avg_purchase_amount,
MAX(product_cat) AS most_purchased_category
FROM customer
GROUP BY loyalty_status;
```
loyalty_status | avg_purchase_amount | most_purchased_category|
---------------|--------------------|--------------------------|
Gold	|9628.4349|	Home|
Regular	|9636.6232	|Home|
Silver	|9635.0737|	Home|

# Purchase Behavior:
- What are the top product categories purchased by customers?
```sql
  SELECT product_cat, COUNT(purchase_amount) AS purchase_amount
FROM customer
GROUP BY product_cat
ORDER BY purchase_amount DESC;
```
product_cat | purchase_amount|
-----------|-----------------|
Electronics	|29099|
Clothing	|19378|
Books	|14449|
Food	|14331|
Health	|9822|
Home	|4929|
Beauty	|4902|

# Promotion Analysis:
- How do different customer segments respond to promotions based on demographics or loyalty status?
```sql
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
```
age_segment | loyalty_status|avg_promotion_usage|avg_purchase_amount
------------|--------------|-------------------|--------------------|
Middle-aged	|Gold|	0.3001|	9588.3577|
Middle-aged	|Regular|	0.3035|	9650.4861|
Middle-aged	|Silver|	0.3023|	9630.5404|
Young	|Gold	|0.2965	|9677.1213|
Young	|Regular	|0.2974|	9620.1100|
Young|Silver|	0.3015|	9640.5249|

- What is the effectiveness of promotions in terms of increasing purchase frequency and amount?
```sql
SELECT promotion_usage, purchase_freq, purchase_amount
FROM customer
WHERE promotion_usage = 1
LIMIT 10;
```
promotion_usage|purchase_freq|purchase_amount|
---------------|-------------|---------------|
1	|rare	|4557|
1	|occasional|	19685|
1	|rare	|16158|
1|	occasional|	2450|
1	|occasional	|5579|
1	|rare|	12901|
1	|rare|	12764|
1	|frequent|	12633|
1	|occasional|	12137|
1	|occasional	|2080|

# Customer Satisfaction:
- What is the overall satisfaction score distribution among customers?
```sql
SELECT 
satisfaction,
COUNT(*) AS num_customers
FROM customer
GROUP BY satisfaction
ORDER BY satisfaction;
```
satisfaction | num_customers|
-------------|--------------|
0	|1|
1	|17|
2	|522|
3	|5851|
4	|23129|
5	|37275|
6	|23550|
7	|5932|
8	|603|
9	|29|
10	|1|



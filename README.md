## Customer-Behavior

# Data set used: https://www.kaggle.com/datasets/sanyamgoyal401/customer-purchases-behaviour-dataset

- In this GitHub repository analysis project, we aim to gain comprehensive insights into customer behavior and preferences across various categories. Our analysis delves into demographic factors such as age, gender, income, and education, exploring how these attributes influence customer engagement and purchasing patterns. Additionally, we investigate loyalty status segments to understand the dynamics between customer loyalty and key metrics like purchase frequency, amount, and product preferences. Furthermore, we examine the impact of promotions on different customer segments, aiming to uncover patterns in promotional response and its correlation with customer behavior. Lastly, we assess overall satisfaction scores to gauge customer sentiment and satisfaction levels, providing a holistic view of customer experience within the analyzed repository. Through these inquiries, we seek to inform strategic decision-making and optimize marketing efforts tailored to diverse customer segments and preferences.


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
- Is there a pattern in purchase behavior based on customer region or income level?
# Loyalty and Engagement:
- What percentage of customers fall into different loyalty status categories (e.g., loyal, occasional, new)?
- How does loyalty status relate to purchase frequency, purchase amount, and product category preferences?
- Are there differences in promotion usage and satisfaction scores among different loyalty segments?
# Purchase Behavior by Product Category:
- How does purchase frequency vary across different product categories?
- What are the top product categories purchased by customers?
- Is there a correlation between purchase amount and satisfaction score within each product category?
# Promotion Analysis:
- How do different customer segments respond to promotions based on demographics or loyalty status?
- What is the effectiveness of promotions in terms of increasing purchase frequency and amount?
- Can we identify any trends or patterns in promotion usage over time?
# Customer Satisfaction:
- What is the overall satisfaction score distribution among customers?
- How do satisfaction scores vary across different customer segments and product categories?
- Is there a correlation between satisfaction scores and loyalty status or purchase behavior?


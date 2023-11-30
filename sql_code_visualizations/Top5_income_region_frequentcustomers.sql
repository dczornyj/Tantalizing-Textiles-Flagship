--Creation of CTE with columns to include in final query, filtering by frequent purchases and categorizing states into their regions.
WITH freq_purchase_income AS (	
SELECT
	c.location, p.review_rating,c.customer_id,p.purchase_amount,c.average_freq_purchases,
	CASE
		WHEN c.location IN ('Connecticut','Maine','Massachusetts','New Hampshire','Rhode Island','Vermont',
						'New Jersey','New York','Pennsylvania','Delaware') THEN 'Northeast'
		WHEN c.location IN ('Illinois','Indiana','Michigan','Ohio','Wisconsin','Iowa','Kansas','Minnesota',
						 'Missouri','Nebraska','North Dakota','South Dakota') THEN 'Midwest'
		WHEN c.location IN ('Arizona','Colorado','Idaho','Montana','Nevada','New Mexico','Utah','Wyoming',
						 'Alaska','California','Hawaii','Oregon','Washington') THEN 'West'
		ELSE 'South'
	END AS region
FROM customers AS c
JOIN purchases AS p
ON c.customer_id=p.customer_id
WHERE average_freq_purchases IN ('Weekly','Fortnightly','Monthly')
),
--Grouping by state and region, query income by frequent purchasers and create partitioned ranking of state by region using sum of income. 
income_rank_by_region AS (
SELECT 
	location,region,sum(purchase_amount)::money,
	RANK()over(PARTITION BY region ORDER BY sum(purchase_amount) DESC) AS sales_rank
FROM freq_purchase_income
GROUP BY location,region
)
--Limit ranking results to only the top 5 states from each region
SELECT * 
FROM income_rank_by_region
WHERE sales_rank<=5




--Creation of CTE with columns to include in final query as well as categorize states into their respective regions.
WITH freq_purchase_cte AS (	
SELECT
	c.location,c.average_freq_purchases,c.customer_id,
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
)
/*Group by region and state, create new columns with summed count of each value in average_freq_purchases, turning string values into 1.*/
SELECT
	location,region,
	SUM(CASE WHEN average_freq_purchases = 'Weekly' THEN 1 ELSE 0 END) AS "Weekly Customers",
	SUM(CASE WHEN average_freq_purchases = 'Fortnightly' THEN 1 ELSE 0 END) AS "Fortnightly Customers",
	SUM(CASE WHEN average_freq_purchases='Monthly' THEN 1 ELSE 0 END) AS "Monthly Customers",
	SUM(CASE WHEN average_freq_purchases = 'Quarterly' THEN 1 ELSE 0 END) AS "Quarterly Customers",
	SUM(CASE WHEN average_freq_purchases = 'Annually' THEN 1 ELSE 0 END) AS "Annual Customers",
	COUNT(customer_id) AS total_cust
FROM freq_purchase_cte
GROUP BY location,region
HAVING COUNT(customer_id)>=75
ORDER BY total_cust DESC




	
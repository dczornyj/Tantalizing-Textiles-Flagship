--Creation of CTE with columns to include in final query as well as categorize states into their respective regions.
WITH regions_sub_store_cte AS (	
SELECT
	c.location,c.average_freq_purchases,c.customer_id,c.subscription,p.shipping_type,
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
/*Group by region and state, query the percentage of customers by state that are subscribed, rank each state by subscribed percentage,
and query the percentage of customers who purchased their last item in store*/
 SELECT 
	region,
	location,
	ROUND(100 * COUNT(customer_id) FILTER (WHERE subscription='Yes')::decimal/COUNT(customer_id),2) AS sub_percentage,
	ROW_NUMBER()OVER(ORDER BY 100* COUNT(customer_id) FILTER (WHERE subscription='Yes')::decimal/COUNT(customer_id) DESC) AS sub_rank,
	ROUND(100*COUNT(customer_id) FILTER (WHERE shipping_type='Store Pickup')::decimal/COUNT(customer_id),2) AS store_pickup_perc
FROM regions_sub_store_cte
GROUP BY region,location
ORDER BY sub_percentage  



	
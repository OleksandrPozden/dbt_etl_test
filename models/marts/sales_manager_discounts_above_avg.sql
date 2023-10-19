WITH avg_agent_discount AS (
	SELECT
		DISTINCT sales_agent_name
		sales_agent_name,
		AVG(discount_amount) OVER (PARTITION BY sales_agent_name) AS avg_discount
	FROM {{ ref('stg_local__gyb_data') }}
	WHERE sales_agent_name IS NOT NULL
	ORDER BY avg_discount desc
),
avg_discount_global AS (
	SELECT DISTINCT sales_agent_name, AVG(discount_amount) OVER () AS global_average_discount
	FROM {{ ref('stg_local__gyb_data') }}
	WHERE sales_agent_name IS NOT NULL
)
SELECT t1.sales_agent_name, t1.avg_discount - t2.global_average_discount AS diff, t2.global_average_discount
FROM avg_agent_discount t1
JOIN avg_discount_global t2 USING(sales_agent_name)
WHERE t1.avg_discount - t2.global_average_discount > 0
ORDER BY (t1.avg_discount - t2.global_average_discount) DESC
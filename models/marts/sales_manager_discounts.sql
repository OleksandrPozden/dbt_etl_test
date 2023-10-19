SELECT
	DISTINCT (sales_agent_name)
	sales_agent_name,
    AVG(discount_amount) OVER (PARTITION BY sales_agent_name) AS avg_discount
FROM {{ ref('stg_local__gyb_data') }}
WHERE sales_agent_name IS NOT NULL
ORDER BY avg_discount desc
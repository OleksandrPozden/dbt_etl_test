WITH current_month AS (
    SELECT *
    FROM {{ ref('int_data_current_month') }}
    WHERE sales_agent_name IS NOT NULL
),
ranked_products AS (
	SELECT 
        sales_agent_name, 
        product_name, 
        count(product_name) as product_appearence, 
        RANK() OVER (
		    PARTITION BY sales_agent_name
		    ORDER BY count(product_name) DESC
	    ) AS ranked
	FROM current_month
	GROUP BY sales_agent_name, product_name
)
SELECT sales_agent_name, product_name, product_appearence
FROM ranked_products
WHERE ranked = 1
ORDER BY sales_agent_name, product_name
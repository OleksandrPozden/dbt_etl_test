SELECT product_name, count(*) AS order_count
FROM {{ ref('int_data_previous_month') }}
GROUP BY product_name
ORDER BY order_count DESC
LIMIT 3
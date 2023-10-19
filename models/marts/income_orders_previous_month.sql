WITH current_month AS (
    SELECT * FROM {{ ref('int_data_previous_month') }}
)
SELECT 
	COUNT(*) as total_orders,  
	SUM(
		total_amount 
        - COALESCE(returned_amount, 0)
        + (
            CASE  
                WHEN DATE_TRUNC('month', {{get_latest_date('int_data_previous_month', 'order_date')}}) > last_rebill_date
                    AND last_rebill_date >= DATE_TRUNC('month', {{get_latest_date('int_data_previous_month', 'order_date')}} - INTERVAL '1 month')
                THEN total_rebill_amount/number_of_rebills
                ELSE 0 
            END
        )
	) AS income
FROM current_month

WITH current_month AS (
    SELECT * FROM {{ ref('int_data_previous_month') }}
)
SELECT 
	COUNT(*) as total_orders,  
    {{ calculate_income('total_amount', 'returned_amount', 'last_rebill_date', 'total_rebill_amount', 'number_of_rebills', 'order_date') }} AS income
FROM current_month

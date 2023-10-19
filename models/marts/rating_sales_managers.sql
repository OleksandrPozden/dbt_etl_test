WITH income_per_person AS (
    SELECT 
        sales_agent_name, 
        count(*) as total_sales,
        {{ calculate_income('total_amount', 'returned_amount', 'last_rebill_date', 'total_rebill_amount', 'number_of_rebills', 'order_date') }} AS total_income
    FROM {{ ref('stg_local__gyb_data')}}
    WHERE sales_agent_name IS NOT NULL
    GROUP BY sales_agent_name
    ORDER BY count(*) DESC

)
SELECT 
    RANK() OVER (
            ORDER BY total_sales DESC, total_income DESC
    ) AS rating,
    sales_agent_name,
    total_sales,
    total_income
FROM income_per_person
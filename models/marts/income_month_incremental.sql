WITH income AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        {{ calculate_income('total_amount', 'returned_amount', 'last_rebill_date', 'total_rebill_amount', 'number_of_rebills', 'order_date') }} AS monthly_income
    FROM
        {{ ref('stg_local__gyb_data')}}
    GROUP BY
        DATE_TRUNC('month', order_date)
),
incremental_income AS (
    SELECT
        month,
        monthly_income,
        100 * (monthly_income - LAG(monthly_income, 1) OVER (ORDER BY month)) / LAG(monthly_income, 1) OVER (ORDER BY month) AS percentage_increase
    FROM
        income
    ORDER BY
        month
)
SELECT
    {{ format_month('month') }} AS month,
    monthly_income,
    percentage_increase
FROM incremental_income

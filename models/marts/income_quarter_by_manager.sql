WITH quarter AS (
    SELECT * FROM{{ ref('int_data_previous_quarter') }}
    WHERE sales_agent_name IS NOT NULL
)
SELECT sales_agent_name, SUM(total_amount - COALESCE(returned_amount, 0)) AS income
FROM quarter
GROUP BY sales_agent_name
ORDER BY income DESC
{% test month_boundaries_within_one_month(model, column_name) %}

    WITH months AS (
        SELECT 
            DISTINCT(EXTRACT( MONTH FROM {{ column_name }} )) as month
        FROM {{ model }}
    ),
    ranked_months AS (
        SELECT 
            month,
            RANK() OVER (ORDER BY month ASC) as rank
        FROM months
    )
    SELECT *
    FROM ranked_months  
    WHERE rank = 2  
    
{% endtest %}
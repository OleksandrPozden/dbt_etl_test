{%- macro calculate_income(total_amount, returned_amount, last_rebill_date, total_rebill_amount, number_of_rebills, order_date) -%}
  SUM(
    {{ total_amount }} 
    - COALESCE({{ returned_amount }}, 0)
    + (
        CASE  
            WHEN DATE_TRUNC('month', {{ order_date }}) > {{ last_rebill_date }}
                AND {{ last_rebill_date }} >= DATE_TRUNC('month', {{ order_date }} - INTERVAL '1 month')
            THEN {{ total_rebill_amount }} / {{ number_of_rebills }}
            ELSE 0 
        END
    )
  ) AS income
{%- endmacro -%}

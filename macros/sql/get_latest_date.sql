{%- macro get_latest_date(relation, column_date) -%}

    (
        SELECT {{  column_date }}
        FROM {{ ref(relation) }}
        ORDER BY {{ column_date }} DESC
        LIMIT 1
    )
    
{%- endmacro -%}

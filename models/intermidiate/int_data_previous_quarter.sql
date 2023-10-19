SELECT * FROM {{ ref('stg_local__gyb_data') }}
WHERE order_date >= DATE_TRUNC('quarter', {{ get_latest_date('stg_local__gyb_data', 'order_date') }}) - INTERVAL '3 months'
AND order_date < DATE_TRUNC('quarter', {{ get_latest_date('stg_local__gyb_data', 'order_date') }})
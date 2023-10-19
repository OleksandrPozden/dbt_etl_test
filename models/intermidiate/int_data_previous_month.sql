SELECT *
FROM {{ ref('stg_local__gyb_data')}}
WHERE 
-- Recommend to put when you work with real data
-- order_date < DATE_TRUNC('month', current_timestamp)
-- AND order_date >= DATE_TRUNC('month', current_timestamp - INTERVAL '1 month')

-- Only used for testing static data
order_date < DATE_TRUNC('month', {{ get_latest_date('stg_local__gyb_data', 'order_date') }})
AND order_date >= DATE_TRUNC('month', {{ get_latest_date('stg_local__gyb_data', 'order_date') }} - INTERVAL '1 month')
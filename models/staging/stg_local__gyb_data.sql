WITH deduplicated AS (
    {{ dbt_utils.deduplicate(
    relation=ref('_base_local__gyb_data'),
    partition_by='reference_id',
    order_by='sales_agent_name asc, compaign_name asc',
   )
}}
)
SELECT * FROM deduplicated
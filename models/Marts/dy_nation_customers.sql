{{ config(
    materialized = 'dynamic_table',
    target_lag = '5 minutes',
    snowflake_warehouse = 'TRANSFORM_WH'
) }}
with dy as (
select
    n.name as nation_name,
    COUNT(c.customer_id)   AS total_customers,
    SUM(c.account_balance) AS account_balance
from {{ ref('stg_customers') }} c
join {{ ref('stg_nations') }} n on c.nation_id = n.nation_id
group by n.name
)
select * from dy
{{ config(materialized='table') }}

with customer_agg as (
    select
        c.customer_id                               as customer,
        max(o.order_date)                           as last_ordered_at,
        min(o.order_date)                           as first_ordered_at,
        count(o.order_id)                           as lifetime_orders,
        sum(o.total_price)                          as lifetime_total
    from {{ ref('stg_customers') }} c
    join {{ ref('stg_orders') }} o
        on c.customer_id = o.customer_id
    join {{ ref('stg_line_items') }} l
        on o.order_id = l.order_id
    group by c.customer_id
)

select
    customer,
    last_ordered_at,
    first_ordered_at,
    lifetime_orders,
    lifetime_total,
    case
        when lifetime_orders = 1 then 'new'
        else 'returning'
    end as cust_type
from customer_agg

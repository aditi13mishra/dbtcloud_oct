{% snapshot scd_orders %}

{{ config(
    target_database='ANALYTICS',
    target_schema='SCDS',
    unique_key='o_orderkey',        
    strategy='check',          
    check_cols=['o_orderpriority','o_orderdate','o_comment'],
    hard_deletes='new_record',
    alias='scd_orders_3',       
) }}

select * from {{ source ('src','orders') }}
{% endsnapshot %}



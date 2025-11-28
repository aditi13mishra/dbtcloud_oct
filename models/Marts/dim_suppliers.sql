{{ config(
    materialized='incremental'
) }}

with supplier as (
    select
        supplier_id,
        supplier_name,
        account_balance,
        phone_number,
        supplier_address,
        nation as nation_name,
        region as region_name,
        updated_time,
        {{ add_jinja_functions() }}
    from {{ ref('int_suppliers') }}

    {% if is_incremental() %}
        where updated_time > (
            select coalesce(max(updated_time), '1900-01-01'::timestamp)
            from {{ this }}
    )
    {% endif %}
)

select * from supplier
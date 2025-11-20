{{ config(
    materialized='incremental',
    unique_key = 'nation_id'
) }}

with nation as (
    select 
        nation_id,
        region_id,
        name,
        updated_at
    from {{ ref('stg_nations') }} as s

    {% if is_incremental() %}
    where updated_at > (
        select coalesce(max(updated_at), '1900-01-01'::timestamp)
        from {{ this }}
    )
    {% endif %}
)

select *
from nation
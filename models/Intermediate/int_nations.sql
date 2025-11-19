{{ config (
        materialized="incremental" ,
        unique_key="nation_id",
        on_schema_change="sync_all_columns"
        ) 
}}
with
    nation as (
        select 
            nation_id, 
            region_id, 
            name, 
            comment, 
            jodo_col,
            updated_at
        from {{ ref("stg_nations") }} s
        {% if is_incremental() %}
            where s.updated_at>
            coalesce((select max(updated_at) from {{ this }}), '19OO-01-01')
        {% endif %}
    )
select * from nation




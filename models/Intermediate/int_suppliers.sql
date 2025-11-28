{{ config(
    tags = 'sample',
    materialized='table'
)}}
with suppliers as (
    select *
    from {{ ref('stg_suppliers') }}
),

nations as (
    select *
    from {{ ref('stg_nations') }}
),

regions as (
    select *
    from {{ ref('stg_regions') }}
)

select s.* EXCLUDE (nation_id),
n.name as nation,
r.name as region
from suppliers s
join nations n
    on s.nation_id = n.nation_id
join regions r
    on n.region_id = r.region_id



{{ config(
    tags = 'sample'
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

select s.*,
n.name as nation_name,
n.updated_at,
r.region_id,
r.name as region_name,
r.comment as region_comment
from suppliers s
join nations n
    on s.nation_id = n.nation_id
join regions r
    on n.region_id = r.region_id



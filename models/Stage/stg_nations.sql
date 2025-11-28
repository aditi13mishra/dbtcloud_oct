{{ config(
    query_tag = 'TEST1',
    alias= this.name + var('v_id'),
    access= 'public'
) }}
with nation as(
select
        n_nationkey as nation_id,
        n_name as name,
        n_regionkey as region_id,
        Updated_at as updated_at,
         {{ add_jinja_functions() }}
from {{ source('src','nations') }}
)
select * from nation

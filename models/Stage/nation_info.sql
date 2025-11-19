with customer as(
select 
 n.nation_id,
 n.name as n_name,
 n.region_id,
 n.comment,
 r.name as r_name,
 r.comment as comments
 from {{ref('stg_nations')}} n 
 join {{ref('stg_regions')}} r 
 on  n.region_id=r.region_id 
)
select * from customer


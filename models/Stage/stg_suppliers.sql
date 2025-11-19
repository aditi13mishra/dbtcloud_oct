with supplier as(
select
 -- ids
        s_suppkey as supplier_id,
        s_nationkey as nation_id,

        -- descriptions
        s2.sname as supplier_name,
        s_address as supplier_address,
        s_phone as phone_number,
        s_comment as comment,

        -- amounts
        s_acctbal as account_balance,
        updated_time
from {{ source('src','suppliers') }} s1
LEFT JOIN {{ source('src4', 'suppliers') }} s2
ON s1.s_suppkey = s2.skey


)
select * from supplier
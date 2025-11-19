{{ config (
    materialized='table',
    post_hook=[ post_hook_unload(this) ]
) }}

with stg_employees_cte as (
    select
        EMPLOYEE_Key,
        EMPLOYEE_ID,
        EMPLOYEE_NAME,
        EMPLOYEE_ADDRESS,
        EMPLOYEE_CITY,
        EMPLOYEE_STATE,
        EMPLOYEE_ZIP_CODE,
        EMPLOYEE_MOBILE,
        EMPLOYEE_FIXED_LINE,
        EMPLOYEE_EMAIL,
        EMPLOYEE_GENDER,
        EMPLOYEE_AGE,
        AGEGROUP,
        POSITION_TYPE,
        DEALERSHIP_ID,
        DEALERSHIP_MANAGER,
        EMPLOYEE_SALARY,
        EMPLOYEE_REGION,
        HIRED_DATE_KEY,
        INSERTDK,
        current_date() as UPDATEDK
    from {{ source('src3', 'stg_employees') }}
)

select *
from stg_employees_cte
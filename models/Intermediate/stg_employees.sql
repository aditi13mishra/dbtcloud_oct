with source as(
    select * from {{ source('src2','stg_employees') }}
),
changed as (
  select 
    ANALYTICS.DBT_ADITI.XY.nextval as employee_key,
    employee_id as employee_id,
    {{ jodo('employee_first_name','employee_last_name') }} as employee_name,
    employee_address as employee_address,
    employee_city as employee_city,
    employee_state as employee_state,
    employee_zip_code as employee_zip_code,
    employee_mobile as employee_mobile,
     {{ phone('employee_fixedline') }}  as employee_fixed_line,
    employee_email as employee_email,
    {{ gender('employee_gender') }} as employee_gender,
    employee_age as employee_age ,
    {{ age_group('employee_age') }} agegroup,
    position_type as position_type,
    dealership_id as dealership_id,
    dealership_manager as dealership_manager,
    salary as employee_salary,
    region as employee_region,
    hire_date as hired_date_key,
    date_entered as insertdk,
    current_date() as updatedk

 from source   
)
select * from changed


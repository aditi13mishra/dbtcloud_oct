{% macro jodo(col1,col2) %}
    {{col1}} || ' ' || {{col2}}
{% endmacro %} 



{% macro phone(number) %}
    '(' || substr({{ number }}, 1, 3) || ') ' ||
    substr({{ number }}, 4, 3) || '-' ||
    substr({{ number }}, 7, 4)
{% endmacro %}


{% macro age_group(age) %}
    case
        when {{ age }} < 35 then 'Youngster'
        when {{ age }} < 60 then 'Middle'
        else 'Senior'
    end
{% endmacro %}


{% macro gender(gender) %}
    iff({{ gender }} = 'M', 'Male', 'Female')
{% endmacro %}



{% macro showemps() %}

    {% set results = run_query("select name from " ~ ref('stg_employees')) %}

    {% if execute %}
        {% for row in results.rows %}
            {{ print(row[0]) }}
        {% endfor %}
    {% endif %}
{% endmacro %}




{% macro upload() %}
{% do run_query (" create or replace stage stage_analytics ") %} 
{% do run_query (" copy into @stage_analytics from stg_nations partition
by (region_id) file_format=(type = csv compression = none null_if=(' ')) header=true ; ")  %} 
{% endmacro %}


{% macro add_jinja_functions() %}
    '{{ invocation_id }}'::string AS dbt_batch_id,
    '{{ run_started_at.strftime("%Y-%m-%d") }}'::timestamp as dbt_batch_ts
{% endmacro %}


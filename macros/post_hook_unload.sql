{% macro post_hook_unload(model) %}
    {{ unload_to_s3('SELECT * FROM ' ~ model ~ '', '@my_s3_stage', 'dm_employees_export.csv') }}
{% endmacro %}
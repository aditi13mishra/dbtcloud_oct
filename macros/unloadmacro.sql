{% macro unload_to_s3(query, stage_name, file_name) %}

{% set sql %}
COPY INTO {{ stage_name }}/{{ file_name }}
FROM ({{ query }})
FILE_FORMAT = MKMOTORS_DEV.STAGING.FF_CSV_HDR
OVERWRITE = TRUE;
{% endset %}

{{ run_query(sql) }}

{{ log("Data unloaded to S3 at stage: " ~ stage_name ~ '/' ~ file_name, info=True) }}

{% endmacro %}


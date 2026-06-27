{{ config(materialized='incremental') }}

Select * from {{ source('staging', 'hosts') }}


{% if is_incremental() %}
    WHERE created_at > (select coalesce(max(created_at),'1990-01-01')  FROM {{this}} )
{% endif %}
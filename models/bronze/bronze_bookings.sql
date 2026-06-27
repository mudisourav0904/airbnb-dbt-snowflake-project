{{ config(materialized='incremental') }}

SELECT * FROM {{ source('staging', 'bookings') }}


{% if is_incremental() %}
  WHERE
    created_at
    > (SELECT coalesce(max(created_at), '1990-01-01') FROM {{ this }})
{% endif %}

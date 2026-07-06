{{ config(
    materialized='incremental',
    unique_key='booking_id'
) }}

SELECT * FROM {{ source('staging', 'bookings') }}

{% if is_incremental() %}
  -- This filter will only be applied on an incremental run
  WHERE created_at > (SELECT COALESCE(MAX(created_at), '1900-01-01') FROM {{ this }})
{% endif %}
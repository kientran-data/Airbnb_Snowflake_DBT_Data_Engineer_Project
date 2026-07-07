{{ config(
    materialized='incremental',
    unique_key='booking_id',
    schema='gold'
) }}

SELECT
    b.booking_id,
    b.listing_id,
    b.booking_date,
    b.total_booking_amount,
    b.cleaning_fee,
    b.service_fee,
    -- Calculate total revenue explicitly for the Fact table
    (b.total_booking_amount + b.cleaning_fee + b.service_fee) AS total_revenue,
    b.created_at
FROM {{ ref('silver_bookings') }} b

{% if is_incremental() %}
  WHERE b.created_at > (SELECT COALESCE(MAX(created_at), '1900-01-01') FROM {{ this }})
{% endif %}
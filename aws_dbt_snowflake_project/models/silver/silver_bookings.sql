{{ config(
    unique_key='booking_id'
) }}

SELECT
    booking_id,
    listing_id,
    booking_date,
    -- Using our custom macro to calculate total amount
    {{ multiply('nights_booked', 'booking_amount') }} AS total_booking_amount,
    cleaning_fee,
    service_fee,
    booking_status,
    created_at
FROM {{ ref('bronze_bookings') }}

{% if is_incremental() %}
  WHERE created_at > (SELECT COALESCE(MAX(created_at), '1900-01-01') FROM {{ this }})
{% endif %}
{{ config(
    unique_key='listing_id'
) }}

SELECT
    listing_id,
    host_id,
    -- Using our trimmer macro
    {{ trimmer('property_type') }} AS property_type,
    room_type,
    city,
    country,
    accommodates,
    bedrooms,
    bathrooms,
    price_per_night,
    -- Using our tag macro
    {{ tag('price_per_night') }} AS price_per_night_tag,
    created_at
FROM {{ ref('bronze_listings') }}

{% if is_incremental() %}
  WHERE created_at > (SELECT COALESCE(MAX(created_at), '1900-01-01') FROM {{ this }})
{% endif %}
{{ config(
    unique_key='host_id'
) }}

SELECT
    host_id,
    -- Standardizing text: replacing spaces with underscores
    REPLACE(host_name, ' ', '_') AS host_name,
    host_since,
    is_superhost,
    response_rate,
    CASE 
        WHEN response_rate >= 95 THEN 'Very Good'
        WHEN response_rate >= 80 THEN 'Good'
        WHEN response_rate >= 50 THEN 'Fair'
        ELSE 'Poor'
    END AS response_rate_quality,
    created_at
FROM {{ ref('bronze_hosts') }}

{% if is_incremental() %}
  WHERE created_at > (SELECT COALESCE(MAX(created_at), '1900-01-01') FROM {{ this }})
{% endif %}
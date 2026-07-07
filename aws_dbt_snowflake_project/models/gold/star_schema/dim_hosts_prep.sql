{{ config(
    materialized='ephemeral'
) }}

SELECT
    host_id,
    host_name,
    is_superhost,
    response_rate_quality,
    created_at AS updated_at -- Used by snapshots to detect changes
FROM {{ ref('silver_hosts') }}
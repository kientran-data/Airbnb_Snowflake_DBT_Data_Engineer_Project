-- This test ensures no host has a response rate over 100% or under 0%

SELECT 
    host_id, 
    response_rate
FROM {{ ref('silver_hosts') }}
WHERE response_rate < 0 OR response_rate > 100
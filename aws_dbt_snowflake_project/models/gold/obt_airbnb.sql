{{ config(
    materialized='table',
    schema='gold'
) }}

-- 1. Define the Metadata Configuration Array
{% set pipeline_config = [
    {
        'table': 'silver_bookings',
        'alias': 'b',
        'columns': ['booking_id', 'booking_date', 'total_booking_amount', 'cleaning_fee', 'service_fee', 'booking_status', 'listing_id']
    },
    {
        'table': 'silver_listings',
        'alias': 'l',
        'join_condition': 'b.listing_id = l.listing_id',
        'columns': ['host_id', 'property_type', 'room_type', 'city', 'country', 'price_per_night_tag']
    },
    {
        'table': 'silver_hosts',
        'alias': 'h',
        'join_condition': 'l.host_id = h.host_id',
        'columns': ['host_name', 'is_superhost', 'response_rate_quality']
    }
] %}

-- 2. Dynamically Generate the SELECT Clause
SELECT
{%- for config in pipeline_config %}
    {%- set outer_loop_last = loop.last %}
    {%- for col in config.columns %}
    {{ config.alias }}.{{ col }} AS {% if config.alias != 'b' %}{{ config.table | replace('silver_', '') }}_{% endif %}{{ col }}{%- if not loop.last or not outer_loop_last %},{% endif %}
    {%- endfor %}
{%- endfor %}

-- 3. Dynamically Generate the FROM and LEFT JOIN Clauses
FROM {{ ref(pipeline_config[0].table) }} AS {{ pipeline_config[0].alias }}

{%- for config in pipeline_config[1:] %}
LEFT JOIN {{ ref(config.table) }} AS {{ config.alias }} 
    ON {{ config.join_condition }}
{%- endfor %}
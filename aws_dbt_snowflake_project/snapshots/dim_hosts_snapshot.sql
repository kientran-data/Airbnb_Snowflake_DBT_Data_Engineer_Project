{% snapshot dim_hosts_snapshot %}

{{
    config(
      target_database='AIRBNB',
      target_schema='gold',
      unique_key='host_id',
      strategy='timestamp',
      updated_at='updated_at',
    )
}}

SELECT * FROM {{ ref('dim_hosts_prep') }}

{% endsnapshot %}
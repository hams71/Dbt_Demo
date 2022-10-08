{{
    config
    (materialized='table')
}}

with store_data as (
    SELECT * FROM {{ source ('snowflake_sample_data','store_sales') }}

)

SELECT * FROM store_data LIMIT 100



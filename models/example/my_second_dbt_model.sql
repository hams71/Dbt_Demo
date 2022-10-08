
-- Use the `ref` function to select from other models
-- merge_update_columns provide a list of columns and only they will be updated

-- SCD Type 1
{{config

    (materialized='incremental',
     incremental_strategy='merge',
     unique_key='id') 
}}


select *
from {{ ref('my_first_dbt_model') }}


-- Use the `ref` function to select from other models
-- merge_update_cols provide a list of columns and only they will be updated

-- SCD Type 1
{{config

    (materialized='incremental',
     incremental_strategy='merge',
     unique_key='id',
     --merge_update_cols=[]) 
}}


select *
from {{ ref('my_first_dbt_model') }}

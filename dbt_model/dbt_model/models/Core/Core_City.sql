{{config

    (materialized='incremental',
     incremental_strategy='merge',
     unique_key='City_ID') 
}}


select 
    {{ dbt_utils.surrogate_key(['City_ID'])}} as Sur_Id,
    Country_ID,
    City_ID,
    Name
from {{ ref('STG_City') }}

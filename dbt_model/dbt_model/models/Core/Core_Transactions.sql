{{
    config

    (   
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='TransactionID'
    )

}}


select
    {{ dbt_utils.surrogate_key(['TransactionID'])}} as Sur_Id,
    TransactionID,
    Account_ID,
    Transaction_Type,
    Amount,
    DateTime
from {{ ref('STG_Transactions') }}

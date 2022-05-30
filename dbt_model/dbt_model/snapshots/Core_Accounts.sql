


{% snapshot Core_Accounts %}

    {{
        config(
          target_schema='Stage_Schema',
          strategy='check',
          unique_key='Sur_Id',
          check_cols=['accountCategoryCode','customerTypeCode','industryCode','primaryContactId','accountNumber','name','revenue','stateCode'],
          invalidate_hard_deletes=True
        )
    }}


with final as (
    SELECT 
        {{ dbt_utils.surrogate_key(['Account_ID','accountCategoryCode','customerTypeCode','industryCode','primaryContactId','accountNumber']) }} as Sur_Id,
        CAST(Account_ID as INTEGER) as Account_ID,
        accountCategoryCode,
        customerTypeCode,
        industryCode,
        primaryContactId,
        accountNumber,
        name,
        revenue,
        stateCode,
        account_start_dt,
        Account_end_dt
        FROM 
        --{{ source('Stage_Schema','STG_Accounts') }}
        {{ ref ('STG_Accounts')}}

)

SELECT * FROM final

{% endsnapshot %}
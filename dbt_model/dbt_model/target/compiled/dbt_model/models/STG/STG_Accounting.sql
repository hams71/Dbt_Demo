



with final as (
    SELECT 
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
        --Staging.Stage_Schema.STG_Accounts
        STAGING.STAGE_SCHEMA.STG_Accounts
)

SELECT * FROM final
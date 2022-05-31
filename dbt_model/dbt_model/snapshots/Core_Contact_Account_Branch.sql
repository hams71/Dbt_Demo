-- If we provide unique_key='Branch_code' and that code is not unique then the snapshot will fail
-- so need to have a unique key

{% snapshot Core_Contact_Account_Branch %}

    {{
        config(
          target_schema='Stage_Schema',
          strategy='check',
          unique_key='Sur_Id', 
          check_cols='all',
          invalidate_hard_deletes=True
        )
    }}


with final as (
    SELECT 
        {{ dbt_utils.surrogate_key(['CC.ContactId','CA.Account_ID','CB.Branch_Code']) }} as Sur_Id,
        CC.ContactId as ContactId,
        CA.Account_ID as Account_ID,
        CB.Branch_Code as Branch_Code
        FROM {{ ref('Core_Contact') }} as CC
        INNER JOIN {{ ref('Core_Accounts') }} as CA
            ON CC.accountId = CA.Account_ID
        INNER JOIN {{ ref('Core_Branch') }} as CB 
            ON CC.BranchName = CB.BranchName
        GROUP BY 2,3,4

)

SELECT * FROM final

{% endsnapshot %}
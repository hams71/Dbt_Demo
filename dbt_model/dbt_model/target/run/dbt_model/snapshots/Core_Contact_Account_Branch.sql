
      

      create or replace transient table STAGING.Stage_Schema.Core_Contact_Account_Branch  as
      (

    select *,
        md5(coalesce(cast(Sur_Id as varchar ), '')
         || '|' || coalesce(cast(to_timestamp_ntz(convert_timezone('UTC', current_timestamp())) as varchar ), '')
        ) as dbt_scd_id,
        to_timestamp_ntz(convert_timezone('UTC', current_timestamp())) as dbt_updated_at,
        to_timestamp_ntz(convert_timezone('UTC', current_timestamp())) as dbt_valid_from,
        nullif(to_timestamp_ntz(convert_timezone('UTC', current_timestamp())), to_timestamp_ntz(convert_timezone('UTC', current_timestamp()))) as dbt_valid_to
    from (
        

    


with final as (
    SELECT 
        md5(cast(coalesce(cast(CC.ContactId as 
    varchar
), '') || '-' || coalesce(cast(CA.Account_ID as 
    varchar
), '') || '-' || coalesce(cast(CB.Branch_Code as 
    varchar
), '') as 
    varchar
)) as Sur_Id,
        CC.ContactId as ContactId,
        CA.Account_ID as Account_ID,
        CB.Branch_Code as Branch_Code
        FROM STAGING.Stage_Schema.Core_Contact as CC
        INNER JOIN STAGING.Stage_Schema.Core_Accounts as CA
            ON CC.accountId = CA.Account_ID
        INNER JOIN STAGING.Stage_Schema.Core_Branch as CB 
            ON CC.BranchName = CB.BranchName
        GROUP BY 2,3,4

)

SELECT * FROM final

    ) sbq



      );
    
  
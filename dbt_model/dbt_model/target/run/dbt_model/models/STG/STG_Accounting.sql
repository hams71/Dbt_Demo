begin;
    
        
            
                
                
            
                
                
            
                
                
            
                
                
            
        
    

    

    merge into STAGING.STAGE_SCHEMA.STG_Accounting as DBT_INTERNAL_DEST
        using STAGING.STAGE_SCHEMA.STG_Accounting__dbt_tmp as DBT_INTERNAL_SOURCE
        on 
                    DBT_INTERNAL_SOURCE.Account_ID = DBT_INTERNAL_DEST.Account_ID
                 and 
                    DBT_INTERNAL_SOURCE.industryCode = DBT_INTERNAL_DEST.industryCode
                 and 
                    DBT_INTERNAL_SOURCE.primaryContactId = DBT_INTERNAL_DEST.primaryContactId
                 and 
                    DBT_INTERNAL_SOURCE.accountNumber = DBT_INTERNAL_DEST.accountNumber
                

    
    when matched then update set
        "SUR_ID" = DBT_INTERNAL_SOURCE."SUR_ID","ACCOUNT_ID" = DBT_INTERNAL_SOURCE."ACCOUNT_ID","ACCOUNTCATEGORYCODE" = DBT_INTERNAL_SOURCE."ACCOUNTCATEGORYCODE","CUSTOMERTYPECODE" = DBT_INTERNAL_SOURCE."CUSTOMERTYPECODE","INDUSTRYCODE" = DBT_INTERNAL_SOURCE."INDUSTRYCODE","PRIMARYCONTACTID" = DBT_INTERNAL_SOURCE."PRIMARYCONTACTID","ACCOUNTNUMBER" = DBT_INTERNAL_SOURCE."ACCOUNTNUMBER","NAME" = DBT_INTERNAL_SOURCE."NAME","REVENUE" = DBT_INTERNAL_SOURCE."REVENUE","STATECODE" = DBT_INTERNAL_SOURCE."STATECODE","ACCOUNT_START_DT" = DBT_INTERNAL_SOURCE."ACCOUNT_START_DT","ACCOUNT_END_DT" = DBT_INTERNAL_SOURCE."ACCOUNT_END_DT"
    

    when not matched then insert
        ("SUR_ID", "ACCOUNT_ID", "ACCOUNTCATEGORYCODE", "CUSTOMERTYPECODE", "INDUSTRYCODE", "PRIMARYCONTACTID", "ACCOUNTNUMBER", "NAME", "REVENUE", "STATECODE", "ACCOUNT_START_DT", "ACCOUNT_END_DT")
    values
        ("SUR_ID", "ACCOUNT_ID", "ACCOUNTCATEGORYCODE", "CUSTOMERTYPECODE", "INDUSTRYCODE", "PRIMARYCONTACTID", "ACCOUNTNUMBER", "NAME", "REVENUE", "STATECODE", "ACCOUNT_START_DT", "ACCOUNT_END_DT")

;
    commit;
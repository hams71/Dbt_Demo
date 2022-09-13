begin;
    
        
            
            
        
    

    

    merge into STAGING.STAGE_SCHEMA.my_second_dbt_model as DBT_INTERNAL_DEST
        using STAGING.STAGE_SCHEMA.my_second_dbt_model__dbt_tmp as DBT_INTERNAL_SOURCE
        on 
                DBT_INTERNAL_SOURCE.id = DBT_INTERNAL_DEST.id
            

    
    when matched then update set
        "ID" = DBT_INTERNAL_SOURCE."ID","NAME" = DBT_INTERNAL_SOURCE."NAME"
    

    when not matched then insert
        ("ID", "NAME")
    values
        ("ID", "NAME")

;
    commit;
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    Account_Id as unique_field,
    count(*) as n_records

from STAGING.STAGE_SCHEMA.STG_Accounts
where Account_Id is not null
group by Account_Id
having count(*) > 1



      
    ) dbt_internal_test
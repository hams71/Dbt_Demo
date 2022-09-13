
      

      create or replace transient table STAGING.Stage_Schema.Core_Address  as
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
        md5(cast(coalesce(cast(Address_Id as 
    varchar
), '') as 
    varchar
)),
        Address_Id,
        City_ID,
        street
    FROM
    STAGING.STAGE_SCHEMA.STG_Address
)

SELECT * FROM final

    ) sbq



      );
    
  
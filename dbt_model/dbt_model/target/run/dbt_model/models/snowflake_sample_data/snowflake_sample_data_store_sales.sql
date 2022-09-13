

      create or replace transient table STAGING.STAGE_SCHEMA.snowflake_sample_data_store_sales  as
      (

with store_data as (
    SELECT * FROM snowflake_sample_data.TPCDS_SF10TCL.store_sales

)

SELECT * FROM store_data LIMIT 100
      );
    
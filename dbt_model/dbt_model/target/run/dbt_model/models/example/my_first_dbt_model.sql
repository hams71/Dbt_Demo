

      create or replace transient table STAGING.STAGE_SCHEMA.my_first_dbt_model  as
      (/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/



with source_data as (

    select 1 as id, 'Raza' as name
    union all
    select 2 as id, 'Ali' as name
    union all
    select 5 as id, 'Hamza' as name
  

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
      );
    
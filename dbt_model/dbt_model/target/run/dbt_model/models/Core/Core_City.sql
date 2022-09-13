

      create or replace transient table STAGING.STAGE_SCHEMA.Core_City  as
      (


select 
    md5(cast(coalesce(cast(City_ID as 
    varchar
), '') as 
    varchar
)) as Sur_Id,
    Country_ID,
    City_ID,
    Name
from STAGING.STAGE_SCHEMA.STG_City
      );
    
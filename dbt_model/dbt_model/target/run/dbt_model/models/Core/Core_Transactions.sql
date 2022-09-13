

      create or replace transient table STAGING.STAGE_SCHEMA.Core_Transactions  as
      (


select
    md5(cast(coalesce(cast(TransactionID as 
    varchar
), '') as 
    varchar
)) as Sur_Id,
    TransactionID,
    Account_ID,
    Transaction_Type,
    Amount,
    DateTime
from STAGING.STAGE_SCHEMA.STG_Transactions
      );
    
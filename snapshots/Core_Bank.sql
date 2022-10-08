-- If we provide unique_key='Branch_code' and that code is not unique then the snapshot will fail
-- so need to have a unique key

{% snapshot Core_Bank %}

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
        {{ dbt_utils.surrogate_key(['BankCode','bank_id','BankName']) }} as Sur_Id,
        *
        FROM
        {{ ref ('STG_Bank')}}

)

SELECT * FROM final

{% endsnapshot %}
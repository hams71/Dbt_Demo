


{% snapshot Core_Contact %}

    {{
        config(
          target_schema='Stage_Schema',
          strategy='check',
          unique_key='ContactId',
          check_cols='all',
          invalidate_hard_deletes=True
        )
    }}


with final as (
    SELECT 
        {{ dbt_utils.surrogate_key(['ContactId','customerTypeCode','preferredContactMethod','BranchName']) }} as Sur_Id,
        *
        FROM
        {{ ref ('STG_Contact')}}

)

SELECT * FROM final

{% endsnapshot %}



{% snapshot Core_Address %}

    {{
        config(
          target_schema='Stage_Schema',
          strategy='check',
          unique_key='Sur_Id',
          check_cols=['City_ID','street'],
          invalidate_hard_deletes=True
        )
    }}


with final as (
    SELECT 
        {{ dbt_utils.surrogate_key(['Address_Id'])}} as Sur_Id,
        Address_Id,
        City_ID,
        street
    FROM
    {{ ref('STG_Address')}}
)

SELECT * FROM final

{% endsnapshot %}
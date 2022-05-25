-- Handling SCD type 2 and the colums are added by dbt itself
-- Also if a record is deleted and its key again appears it is repurposed
-- need to add this invalidate_hard_delete so that can mark as delete else wont do anything



{% snapshot name_history %}

    {{
        config(
          target_schema='Stage_Schema',
          strategy='check',
          unique_key='id',
          check_cols='all',
          invalidate_hard_deletes=True
        )
    }}

    select * from {{ ref('my_first_dbt_model') }}

{% endsnapshot %}
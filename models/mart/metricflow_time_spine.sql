{{ config(materialized='table') }}

with days as (
    {{ dbt_date.get_date_dimension('2015-01-01', '2030-12-31') }}
)

select date_day as date_day from days
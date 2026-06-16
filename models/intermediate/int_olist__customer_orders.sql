-- int_olist__customer_orders.sql
with customers as (
    select
        customer_id,
        customer_unique_id,
        customer_zip_code_prefix,
        customer_city,
        customer_state
    from {{ ref('stg_customers') }}
),
orders as (
    select *
    from {{ ref('int_olist__order_enriched') }}
),

customer_orders_agg as (
    select
        c.customer_id,
        -- purchase counts & revenue
        count(distinct o.order_id) as total_orders,
        sum(coalesce(o.payment_value, 0)) as total_revenue,
        avg(nullif(o.payment_value,0)) as avg_order_value, 
        count(distinct o.product_id) as distinct_products_purchased,

        -- order dates
        min(o.order_date) as first_order_date,
        max(o.order_date) as last_order_date,

        -- simple repeat purchase indicator
        case when count(distinct o.order_id) > 1 then true else false end as is_repeat_customer

    from customers c
    left join orders o
        on c.customer_id = o.customer_id
    group by
        c.customer_id
),

-- Add derived temporal metrics (recency, tenure, frequency)
customer_orders_final as (
    select
        coa.*,
        case
            when coa.first_order_date is not null and coa.last_order_date is not null
            then datediff(day, date(coa.first_order_date), date(coa.last_order_date))
            else null
        end as tenure_days,
        case
            when coa.last_order_date is not null
            then datediff(day, date(coa.last_order_date), current_date())
            else null
        end as days_since_last_order
        

    from customer_orders_agg coa
)

select * from customer_orders_final

with orders as (
    select *
    from {{ ref('stg_orders') }}
),

delivery_metrics as (
    select
        order_id,
        customer_id,
        order_status,
        order_date,
        approved_at,
        carrier_delivery_date,
        customer_delivery_date,
        estimated_delivery_date,
        
        -- Calculate delivery time metrics (in days)
        datediff(day, order_date, approved_at) as days_to_approval,
        datediff(day, approved_at, carrier_delivery_date) as days_to_carrier,
        datediff(day, carrier_delivery_date, customer_delivery_date) as days_in_transit,
        datediff(day, order_date, customer_delivery_date) as total_delivery_days,
        
        -- Calculate estimated vs actual
        datediff(day, order_date, estimated_delivery_date) as estimated_delivery_days,
        datediff(day, estimated_delivery_date, customer_delivery_date) as delivery_delay_days,
        
        -- Delivery status flags
        case 
            when customer_delivery_date is null then false
            when customer_delivery_date <= estimated_delivery_date then true
            else false
        end as is_on_time,
        
        case
            when customer_delivery_date is null then false
            when customer_delivery_date > estimated_delivery_date then true
            else false
        end as is_delayed,
        
        case
            when order_status = 'delivered' and customer_delivery_date is not null then true
            else false
        end as is_delivered,
        
        case
            when order_status = 'canceled' then true
            else false
        end as is_canceled,
        
        -- Delivery performance categories
        case
            when customer_delivery_date is null then 'Not Delivered'
            when customer_delivery_date <= estimated_delivery_date then 'On Time'
            when datediff(day, estimated_delivery_date, customer_delivery_date) between 1 and 3 then 'Slightly Delayed'
            when datediff(day, estimated_delivery_date, customer_delivery_date) between 4 and 7 then 'Moderately Delayed'
            when datediff(day, estimated_delivery_date, customer_delivery_date) > 7 then 'Severely Delayed'
            else 'Unknown'
        end as delivery_performance_category

    from orders
)

select * from delivery_metrics
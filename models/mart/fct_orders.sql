with order_enriched as (
    select *
    from {{ ref('int_olist__order_enriched') }}
),

delivery_metrics as (
    select *
    from {{ ref('int_olist__order_delivery_metrics') }}
),

final as (
    select
        order_enriched.unique_field,
        order_enriched.order_id,
        order_enriched.order_item_id,
        order_enriched.product_id,
        order_enriched.seller_id,
        order_enrichedcustomer_id,
        order_enriched.price,
        order_enriched.freight_value,
        order_enriched.order_date,
        order_enriched.order_status,
        order_enriched.payment_value
        
        delivery_metrics.approved_at,
        delivery_metrics.carrier_delivery_date,
        delivery_metrics.customer_delivery_date,
        delivery_metrics.estimated_delivery_date,        
        
        delivery_metrics.days_to_approval,
        delivery_metrics.days_to_carrier,
        delivery_metrics.days_in_transit,
        delivery_metrics.total_delivery_days,
        delivery_metrics.estimated_delivery_days,
        delivery_metrics.delivery_delay_days,
        
        delivery_metrics.is_on_time,
        delivery_metrics.is_delayed,
        delivery_metrics.delivery_performance_category,

    from order_enriched
    left join delivery_metrics
        on order_enriched.order_id = delivery_metrics.order_id
)

select * from final

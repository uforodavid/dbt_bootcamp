with order_data as (
    select *
    from {{ source('olist', 'olist_orders')}}
)


select 
        order_id,
        customer_id,
        order_status,
        order_purchase_timestamp as order_date,
        ORDER_APPROVED_AT as approved_at,
        ORDER_DELIVERED_CARRIER_DATE as carrier_delivery_date,
        ORDER_DELIVERED_CUSTOMER_DATE as customer_delivery_date,
        ORDER_ESTIMATED_DELIVERY_DATE as estimated_delivery_date
from order_data
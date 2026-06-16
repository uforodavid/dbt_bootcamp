with order_items as (
    select *
    from {{ ref('stg_order_items') }}


),

    orders as (
    select *
    from {{ ref('stg_orders') }}


),
    order_payments as (
    select 
        order_id, 
        sum(payment_value) as payment_value
    from {{ ref('stg_order_payments') }}
    group by 1

),

final as (
    select 
        {{ dbt_utils.generate_surrogate_key(['order_items.order_id', 'order_items.order_item_id']) }} as unique_field,
        order_items.order_id,
        order_items.order_item_id,
        order_items.product_id,
        order_items.seller_id,
        orders.customer_id,
        order_items.price,
        order_items.freight_value,
        orders.order_date,
        orders.order_status,
        --order_payments.payment_type,
        --order_payments.payment_installments,
        order_payments.payment_value

    from order_items
        left join orders 
            on order_items.order_id = orders.order_id
        left join order_payments
            on orders.order_id = order_payments.order_id

)
select * from final
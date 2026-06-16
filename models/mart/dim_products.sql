with products as (
    select *
    from {{ ref('stg_products') }}
),
    product_category as (
    select *
    from {{ ref('stg_product_category') }}
    
),
final as (
    select
        product_id,
        products.product_category_name,
        product_category.product_category_name_english
        product_name_lenght,
        product_description_lenght,
        product_photos_qty,
        product_weight_g,
        product_length_cm,
        product_height_cm,
        product_width_cm

    from products left join product_category 
        on products.product_category_name = product_category.product_category_name

)

select * from final

-- Refunds have a negative amount, so the total amount should always be >= 0.
-- Therefore return records where total_amount < 0 to make the test fail.
select
    order_id,
    sum(payment_value) as total_amount
from {{ ref('stg_order_payments') }}
group by 1
having total_amount < 0
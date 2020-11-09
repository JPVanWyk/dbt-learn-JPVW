Select
ID as payment_id,
ORDERID as payment_order_id,
PAYMENTMETHOD as payment_method,
STATUS as payment_status,
AMOUNT as payment_amount,
CREATED	as payment_created_date,
_BATCHED_AT as payment_batched_at
From raw.stripe.payment
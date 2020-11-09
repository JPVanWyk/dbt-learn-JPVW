with customers as (

    select * from {{ ref('stg_customers') }}

),

orders as (

    select * from {{ ref('stg_orders') }}

),
payments as (

    select * from {{ ref('stg_payments') }}

)
,

customer_orders as (

 select
        orders.customer_id,
        min(orders.order_date) as first_order_date,
        max(orders.order_date) as most_recent_order_date,
        count(orders.order_id) as number_of_orders,
        sum(coalesce(payments.payment_amount, 0)) as total_order_amount

    from orders
    left outer join payments on orders.order_id = payments.payment_order_id AND payments.payment_status = 'success'

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
         to_number(coalesce(customer_orders.total_order_amount, 0)) as lifetime_order_amount


    from customers

    left join customer_orders using (customer_id)

)

select * from final
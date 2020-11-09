Select 
o.order_id,
o.Customer_id,
Sum(p.payment_amount) as Total_Payment_amount,
SUM(CASE WHEN P.payment_status = 'fail' THEN 0 ELSE P.payment_amount END) AS TOTAL_SUCCESSFUL_AMOUNT,
SUM(CASE WHEN P.payment_status = 'fail' THEN P.payment_amount ELSE 0 END) AS TOTAL_FAILED_AMOUNT
From {{ref('stg_orders')}} as o
Left outer join {{ref('stg_payments')}} as p on o.order_id = p.payment_order_id

Group by o.order_id, o.Customer_id
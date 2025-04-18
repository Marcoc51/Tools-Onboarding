SELECT
    order_date, 
    O.order_id,
    sum(total_price) AS total_price  
FROM 
    {{ref('stg_orders')}} AS O 
LEFT JOIN 
    {{ref('stg_order_items')}} AS OI
ON 
    O.ORDER_ID = OI.ORDER_ID
GROUP BY 
    1,2
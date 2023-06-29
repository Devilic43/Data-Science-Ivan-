#1
select
   count(*) As orders_count
from orders;

#2
select
order_status,  
count(*) As orders
from orders group by order_status;

#3

SELECT 
    YEAR(order_purchase_timestamp) AS year_,
    MONTH(order_purchase_timestamp) AS month_,
    COUNT(customer_id)
FROM
    orders
GROUP BY year_ , month_
ORDER BY year_ , month_;

#4

Select
count(distinct product_id) as product_count
from products;

#5

select
product_category_name,
count(distinct product_id) as n_product
from products 
group by product_category_name
Order by count(product_id) desc;

#6

Select
	count(DISTINCT product_id) AS n_products
FROM
	order_items;

#7

SELECT 
    MIN(price) AS cheapest, 
    MAX(price) AS most_expensive
FROM 
	order_items;

#8

SELECT 
	MAX(payment_value) as highest;
    
 
 
SELECT product_category_name,
 AVG(TIMESTAMPDIFF(day, order_purchase_timestamp, order_delivered_customer_date)) AS average_delivery_time
FROM orders o 
JOIN order_items i ON o.order_id = i.order_id
JOIN products p  ON p.product_id = i.product_id
WHERE product_category_name IN ('audio', 'cine_foto', 'consoles_games', 'eletronicos', 'informatica_acessorios', 'pc_gamer', 'pcs', 'telefonia')
GROUP BY product_category_name;

# how many orders are delivered on time vs orders delivered with a delay

SELECT 
    CASE
        WHEN order_estimated_delivery_date <= order_delivered_customer_date THEN 'On Time'
        ELSE 'Delayed'
    END AS delivery_status,
    COUNT(*) AS order_count
FROM orders o
JOIN order_items i ON o.order_id = i.order_id
JOIN products p  ON p.product_id = i.product_id
WHERE product_category_name IN ('audio', 'cine_foto', 'consoles_games', 'eletronicos', 'informatica_acessorios', 'pc_gamer', 'pcs', 'telefonia')
GROUP BY delivery_status;

SELECT 
    CASE
        WHEN order_estimated_delivery_date <= order_delivered_customer_date THEN 'On Time'
        ELSE 'Delayed'
    END AS delivery_status,
    COUNT(*) AS order_count
FROM orders o
JOIN order_items i ON o.order_id = i.order_id
JOIN products p  ON p.product_id = i.product_id
WHERE product_category_name IN ('audio', 'cine_foto', 'consoles_games', 'eletronicos', 'informatica_acessorios', 'pc_gamer', 'pcs', 'telefonia')
GROUP BY delivery_status;
 
#Is there any pattern for delayed orders, e.g. big products being delayed more often?

SELECT
    od.payment_value,
    COUNT(*) AS total_orders,
    COUNT(CASE WHEN o.order_estimated_delivery_date > o.order_delivered_customer_date THEN 1 END) AS delayed_orders
FROM orders o
JOIN order_items i ON o.order_id = i.order_id
JOIN order_payments od  ON p.product_id = i.product_id
WHERE product_category_name IN ('audio', 'cine_foto', 'consoles_games', 'eletronicos', 'informatica_acessorios', 'pc_gamer', 'pcs', 'telefonia')


GROUP BY product_category_name,payment_value;

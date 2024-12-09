create database Olist_Store_Analysis;
use Olist_store_analysis;
Select * from olist_order_payments_dataset ;
select * from olist_order_reviews_dataset ;
select * from olist_orders_dataset;
Select * from olist_products_dataset;
select * from olist_order_items_dataset; 
select * from olist_sellers_dataset;
# Kpi 1 Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics
select 
case 
when dayofweek(date(Order_purchase_timestamp)) between 2 and 6 then "Weekday"
else "Weekend"
  end as Weekday_vs_Weekend,round(sum(payment_value),2) as payments,
round(sum(payment_value)/(select sum(payment_value) from olist_order_payments_dataset)*100,2) as payment_statistics 
from olist_orders_dataset
  inner join olist_order_payments_dataset
  using (Order_id)
group by Weekday_vs_Weekend ;


# Kpi 2 Number of Orders with review score 5 and payment type as credit card.

Select count(order_id) as No_of_orders_review_score5_and_payment_type_credit_card
from olist_order_payments_dataset
inner join olist_orders_reviews_dataset
using (order_id)
where review_score=5 and
payment_type='credit_card';


# Kpi 3 Average number of days taken for order_delivered_customer_date for pet_shop
SELECT 
    round(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp))) AS Avg_Days_To_Deliver_pet_shop
FROM olist_orders_dataset
inner join olist_order_items_dataset
using (order_id)
inner join  olist_products_dataset
using (product_id)  
where product_category_name='pet_shop' ;
    

# kpi-4 Average price and payment values from customers of sao paulo city
select
(select round(avg(price)) from Olist_order_payments_dataset
inner join olist_order_items_dataset
using (order_id)
inner join Olist_orders_dataset
using (order_id)
inner join olist_customers_dataset
using (customer_id)
where customer_city ='sao paulo') as Average_price ,
(select round(avg(payment_value)) from Olist_order_payments_dataset
inner join Olist_orders_dataset
using (order_id)
inner join olist_customers_dataset
using (customer_id)
where customer_city ='sao paulo') as average_payment_value;








Select * from olist_order_payments_dataset ;
select * from olist_orders_reviews_dataset ;
select * from olist_orders_dataset;
Select * from olist_products_dataset;
select * from olist_order_items_dataset; 
select * from olist_sellers_dataset;
select * from olist_customers_dataset;

# kpi-5  Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores.
select round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp))) as shipping_days ,
review_score
from olist_orders_dataset
inner join olist_orders_reviews_dataset 
using (order_id)
group by review_score order by shipping_days  ;



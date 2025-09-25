#1. Import the dataset and do usual exploratory analysis steps like checking the
#structure & characteristics of the dataset:
#1. Data type of all columns in the "customers" table.
#2. Get the time range between which the orders were placed.

select * 
from `TARGET_SQL.Customers`
limit 10;



#Get the time range between which the orders were placed.
SELECT
MIN(order_purchase_timestamp) as start_time,
MAX (order_purchase_timestamp) as end_TIME
FROM `TARGET_SQL.Orders`;

#Display the Cities & States of customers who ordered during the given period.
SELECT
c.customer_city, c.customer_state
FROM `TARGET_SQL.Orders` as o
JOIN `TARGET_SQL.Customers` as c
    ON o.customer_id = c.customer_id
WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
AND EXTRACT(MONTH FROM order_purchase_timestamp) BETWEEN 1 AND 3;


#Is there a growing trend in the no. of orders placed over the past years?
SELECT
EXTRACT(month from order_purchase_timestamp) as month,
count(order_id) as order_num
FROM `TARGET_SQL.Orders`
GROUP BY EXTRACT(month from order_purchase_timestamp) 
ORDER BY order_num desc;




#During what time of the day, do the Brazilian customers mostly place
#their orders? (Dawn, Morning, Afternoon or Night)
#■ 0-6 hrs : Dawn
#■ 7-12 hrs : Mornings
#■ 13-18 hrs : Afternoon
#■ 19-23 hrs : Night

SELECT
EXTRACT(hour from order_purchase_timestamp) as time,
count(order_id) as order_num
FROM `TARGET_SQL.Orders`
GROUP BY EXTRACT(hour from order_purchase_timestamp) 
ORDER BY order_num desc;



#Get month on month number of orders.
SELECT
EXTRACT(month from order_purchase_timestamp) as month,
EXTRACT(year from order_purchase_timestamp) as year,
COUNT  (*) as num_orders
FROM `TARGET_SQL.Orders`
GROUP BY year, month
ORDER BY year, month;



# Distribution of customers across the state of brazil

SELECT customer_state,
COUNT (DISTINCT customer_id) as customer_count
FROM `TARGET_SQL.Customers`
GROUP BY customer_city,customer_state
ORDER BY customer_count DESC;


#Get the % increase in the cost of orders from year 2017 to 2018
#(include months between Jan to Aug only).
#You can use the "payment_value" column in the payments table to get
#the cost of orders.


# STEP 1 : Calculate total payments per year

with yearly_totals as (
SELECT
EXTRACT (YEAR from o.order_purchase_timestamp ) as year,
SUM (p.payment_value) as total_payment
FROM `TARGET_SQL.Payments` as p
JOIN `TARGET_SQL.Orders` as o
ON p.order_id = o.order_id
WHERE EXTRACT (YEAR from o.order_purchase_timestamp ) IN (2017, 2018)
AND EXTRACT (MONTH from o.order_purchase_timestamp ) BETWEEN 1 AND 8

GROUP BY EXTRACT (YEAR from o.order_purchase_timestamp )
),


# STEP 2 : Use LEAD window function to compare each year's payments with the previous year

yearly_comparisons AS (
SELECT
year, 
total_payment,
LEAD(total_payment) over (order by year desc) as prev_year_payment
from yearly_totals
)

#STEP 3 :Calculate % increase
SELECT round  ((total_payment - prev_year_payment)/prev_year_payment)*100
FROM yearly_comparisons;


#mean & SUM of price and friegnt value by customer state

SELECT
c.customer_state,
AVG (price) as avg_price,
SUM(price) as sum_price,
AVG (freight_value) as avg_freight,
SUM (freight_value) as sum_freight
FROM `TARGET_SQL.Orders` as o
JOIN `TARGET_SQL.Order_items` as oi
    ON o.order_id = oi.order_id
JOIN `TARGET_SQL.Customers` as c
ON o.customer_id = c.customer_id
GROUP BY c.customer_state;



# Calculate days between purchasing, delevering and estimated delevery

SELECT order_id,
DATE_DIFF (DATE ( order_delivered_customer_date), DATE (order_purchase_timestamp), DAY) as days_to_delivery,
DATE_DIFF (DATE ( order_delivered_customer_date), DATE (order_estimated_delivery_date), DAY) as diff_estimated_delivery

FROM `TARGET_SQL.Orders`;


# find out the top 5 states with the highest & lowest average freight value.

SELECT c.customer_state,
AVG(freight_value) as avg_freight_value
FROM `TARGET_SQL.Orders` as o 
JOIN `TARGET_SQL.Order_items` as oi
    ON o.order_id = oi.order_id
JOIN `TARGET_SQL.Customers` as c
ON o.customer_id = c.customer_id
GROUP BY customer_state
ORDER BY avg_freight_value DESC
LIMIT 5;



# find out the top 5 states with the highest & lowest average delivery time.

SELECT 
c.customer_state,
AVG(EXTRACT (DATE from o.order_delivered_customer_date) - EXTRACT (DATE from o.order_purchase_timestamp)) as avg_time_to_delivery
FROM `TARGET_SQL.Orders` as o 
JOIN `TARGET_SQL.Order_items` as oi
    ON o.order_id = oi.order_id
JOIN `TARGET_SQL.Customers` as c
ON o.customer_id = c.customer_id
GROUP BY customer_state
ORDER BY avg_time_to_delivery ASC
LIMIT 5;


# Find the month on month no of orders placed using different payment types.

SELECT 
payment_type,
EXTRACT (YEAR FROM order_purchase_timestamp) as year,
EXTRACT (MONTH FROM order_purchase_timestamp) as month,
COUNT(DISTINCT o.order_id) as order_count
FROM `TARGET_SQL.Orders` as o
INNER JOIN `TARGET_SQL.Payments` as p
ON o.order_id = p.order_id
GROUP BY payment_type, year, month
ORDER BY payment_type, year, month;

# Count of orders based on the number of payment installments.

SELECT payment_installments,
COUNT (DISTINCT order_id) as num_orders
FROM `TARGET_SQL.Payments`
GROUP BY payment_installments











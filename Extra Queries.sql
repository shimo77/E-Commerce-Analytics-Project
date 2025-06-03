

-----------------------------------------------**Data Preparation andCleaning**-----------------------------------------------
--Categories table
select * from Categories
--there are nulls in parent_id because they are top parents

----------------------------------------------------------------------------

--products table
select * from products

--check null values
select 
    sum(case when name is null then 1 else 0 end) as missing_name,
    sum(case when price is null then 1 else 0 end) as missing_price,
    sum(case when category_id is null then 1 else 0 end) as missing_category,
    sum(case when supplier_id is null then 1 else 0 end) as missing_supplier,
    sum(case when sku is null then 1 else 0 end) as missing_sku,
    sum(case when stock_quantity is null then 1 else 0 end) as missing_stock
from products;


--check for dublicated SKUs
select sku, count(*) as count
from products
group by sku
having count(*) > 1;


--check for invalid prices and stock
select * from Products
where price < 0 OR stock_quantity < 0;
 
----------------------------------------------------------------------------

--Customers table
select * from customers

--check null values
select 
    sum(case when first_name is null then 1 else 0 end) as missing_first_name,
    sum(case when last_name is null then 1 else 0 end) as missing_last_name,
    sum(case when email is null then 1 else 0 end) as missing_email,
    sum(case when phone is null then 1 else 0 end) as missing_phone,
    sum(case when address is null then 1 else 0 end) as missing_address,
    sum(case when registration_date is null then 1 else 0 end) as missing_registration_date
from customers;


--check for duplicated emails
select email, count(*) as count
from customers
group by email
having count(*) > 1;


--check for dublicated phone
select phone, count(*) as count
from customers
group by phone
having count(*) > 1;


--remove extra spaces from emails
update customers
set email = ltrim(rtrim(email))
where email like ' %' or email like '% ';

----------------------------------------------------------------------------

--Orders table
select * from Orders

--check null values
select 
    sum(case when customer_id is null then 1 else 0 end) as missing_customer_id,
    sum(case when order_date is null then 1 else 0 end) as missing_order_date,
    sum(case when total_amount is null then 1 else 0 end) as missing_total_amount,
    sum(case when status is null then 1 else 0 end) as missing_status
from orders;

----------------------------------------------------------------------------

--OrderDetails table
select * from order_details

--check null values
select 
    sum(case when order_id is null then 1 else 0 end) as missing_order_id,
    sum(case when product_id is null then 1 else 0 end) as missing_product_id,
    sum(case when quantity is null then 1 else 0 end) as missing_quantity,
    sum(case when unit_price is null then 1 else 0 end) as missing_unit_price
from order_details;

--check order not contains more than 5 items
select order_id, count(*) as num_of_items
from order_details
group by order_id
having count(*) > 5


--check for invalid quantity or price
select * from order_details
where quantity <= 0 or unit_price < 0;

----------------------------------------------------------------------------

--Payments table
select * from payments

--check null values
select 
    sum(case when order_id is null then 1 else 0 end) as missing_order_id,
    sum(case when customer_id is null then 1 else 0 end) as missing_customer_id,
    sum(case when amount is null then 1 else 0 end) as missing_amount,
    sum(case when payment_date is null then 1 else 0 end) as missing_payment_date,
    sum(case when payment_method is null then 1 else 0 end) as missing_payment_method,
    sum(case when status is null then 1 else 0 end) as missing_status
from payments;

----------------------------------------------------------------------------

--Shipping table
 select * from shipping

 --check for null values
 select 
    sum(case when order_id is null then 1 else 0 end) as missing_order_id,
    sum(case when shipping_date is null then 1 else 0 end) as missing_shipping_date,
    sum(case when tracking_number is null then 1 else 0 end) as missing_tracking_number,
    sum(case when carrier is null then 1 else 0 end) as missing_carrier,
    sum(case when status is null then 1 else 0 end) as missing_status
from shipping;

----------------------------------------------------------------------------

--Returns table
select * from returns

--check null values
select 
    sum(case when order_id is null then 1 else 0 end) as missing_order_id,
    sum(case when return_date is null then 1 else 0 end) as missing_return_date,
    sum(case when reason is null then 1 else 0 end) as missing_reason,
    sum(case when status is null then 1 else 0 end) as missing_status
from returns;

----------------------------------------------------------------------------

--Reviews table
select * from reviews

--check null values
select 
    sum(case when product_id is null then 1 else 0 end) as missing_product_id,
    sum(case when customer_id is null then 1 else 0 end) as missing_customer_id,
    sum(case when rating is null then 1 else 0 end) as missing_rating,
    sum(case when review_date is null then 1 else 0 end) as missing_review_date
from reviews;

--check invalid rating values
select * from reviews
where rating < 1 or rating > 5;

----------------------------------------------------------------------------

--Suppliers table
select * from suppliers

--check null values
select 
    sum(case when name is null then 1 else 0 end) as missing_name,
    sum(case when contact_person is null then 1 else 0 end) as missing_contact_person,
    sum(case when email is null then 1 else 0 end) as missing_email,
    sum(case when phone is null then 1 else 0 end) as missing_phone,
    sum(case when address is null then 1 else 0 end) as missing_address
from suppliers;

--check for dublicated supplier names
select name, count(*) as count
from suppliers
group by name
having count(*) > 1;

--check for dublicated supplier emails
select email, count(*) as count
from suppliers
group by email
having count(*) > 1;

----------------------------------------------------------------------------

--Discounts table
select * from discounts

--there are nulls in product_id and category_id because this discount 
--expired but still active discounts
select *
from discounts
where is_active = 1 and end_date < getdate()
 
----------------------------------------------------------------------------

--Wishlists table
select * from wishlists

--check null values
select 
    sum(case when customer_id is null then 1 else 0 end) as missing_customer_id,
    sum(case when product_id is null then 1 else 0 end) as missing_product_id,
    sum(case when added_date is null then 1 else 0 end) as missing_added_date
from wishlists

--check for duplicated entries (same customer and product)
select 
    customer_id,
    product_id,
    count(*) as entry_count
from wishlists
group by customer_id, product_id
having count(*) > 1

----------------------------------------------------------------------------

--Inventory movements table
select * from inventory_movements


--check null values
select 
    sum(case when product_id is null then 1 else 0 end) as missing_product_id,
    sum(case when quantity is null then 1 else 0 end) as missing_quantity,
    sum(case when movement_type is null then 1 else 0 end) as missing_movement_type,
    sum(case when movement_date is null then 1 else 0 end) as missing_movement_date
from inventory_movements

--check invalid movement type
select distinct movement_type
from inventory_movements

----------------------------------------------------------------------------

--Customer sessions table
select * from customer_sessions

--check null values
select 
    sum(case when customer_id is null then 1 else 0 end) as missing_customer_id,
    sum(case when session_start is null then 1 else 0 end) as missing_session_start,
    sum(case when session_end is null then 1 else 0 end) as missing_session_end,
    sum(case when ip_address is null then 1 else 0 end) as missing_ip_address
from customer_sessions

--check sessions with invalid end time and start time
select *
from customer_sessions
where session_end < session_start


/****************************************** Extra KPI's AND QUESTIONS ********************************************/

--The total number of Returns 
SELECT
COUNT(DISTINCT order_id) AS TotalReturnCount
FROM Returns

 --The total number of products sold:
 SELECT
    SUM(quantity) AS TotalProductsSold
FROM
    order_details;

-- Retun Rate
WITH TotalOrders AS (
    SELECT
        COUNT(DISTINCT id) AS TotalOrderCount
    FROM Orders
),
ReturnOrders AS (
    SELECT
        COUNT(DISTINCT order_id) AS TotalReturnCount
    FROM Returns
)
SELECT
    CAST((CAST(TotalReturnCount AS FLOAT) / TotalOrderCount) * 100 AS DECIMAL(10, 2)) AS ReturnRatePercentage
FROM TotalOrders, ReturnOrders;

--AVG TIME PER ORDER
select avg(datediff(minute,order_date,payment_date)) as avg_time_per_order
from orders o 
join payments p
on o.id = p.order_id 
where p.status = 'completed'

--NUM OF COMPLETED ORDERS 
select count(*) as total_completed_orders
from payments 
WHERE status = 'completed'

--NUM OF CANCELLED ORDERS
select count(*) as total_cancelled_orders
from orders
where status = 'cancelled'

--AVG ORDER VALUE (AOV)
select sum(total_amount)/count(*) as avg_order_value 
from orders

--ACTIVE DISCOUNT
select count(*) as total_active_discounts
from discounts
where is_active = 1

--PAYMENT SUCCESS RATE
select count(case when p.status = 'completed' then 1 end) * 100.0 / count(*) as payment_success_rate
from orders o 
left join payments p
on o.id = p.order_id

--Avg customers Rating  (Customer Satisfaction Score (Avg Review Rating))
select AVG(rating) as"Avg customers Rating" 
from reviews


-- Calculate Conversion Rate 'CR' (Orders / Customer Sessions) 
WITH session_count AS (
    SELECT COUNT(DISTINCT id) AS total_sessions FROM customer_sessions
),
order_count AS (
    SELECT COUNT(DISTINCT id) AS total_orders FROM orders
)
SELECT 
    ROUND( s.total_sessions* 100.0 /  o.total_orders, 2) AS conversion_rate_percent
FROM 
    session_count s, order_count o;



--#Order Orders From Previous Month
SELECT
    sum(total_amount) AS OrdersFromPreviousMonth
FROM
    Orders
WHERE
    order_date >= DATEADD(MONTH, -1, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1))
    AND order_date < DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)
	and status <> 'canceled';



/*Total Revenue (Current Month)*/
SELECT
    sum(total_amount) AS OrdersFromCurrentMonth
FROM
    Orders
WHERE
    order_date >= DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1) 
    AND order_date < DATEADD(MONTH, +1, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1))  
and status <> 'canceled'

---------------------------------------------------------------
--Growth
WITH Sales AS (
    SELECT
        -- Previous month sales
        SUM(CASE 
                WHEN order_date >= DATEADD(MONTH, -1, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1))
                 AND order_date < DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)
                 AND status <> 'canceled'
                THEN total_amount
                ELSE 0
            END) AS OrdersFromPreviousMonth,

        -- Current month sales
        SUM(CASE
                WHEN order_date >= DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)
                 AND order_date < DATEADD(MONTH, 1, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1))
                 AND status <> 'canceled'
                THEN total_amount
                ELSE 0
            END) AS OrdersFromCurrentMonth
    FROM Orders
)

SELECT
    OrdersFromPreviousMonth,
    OrdersFromCurrentMonth,
    CASE
        WHEN OrdersFromPreviousMonth = 0 THEN NULL
        ELSE ROUND(((OrdersFromCurrentMonth - OrdersFromPreviousMonth) * 100.0) / OrdersFromPreviousMonth, 2)
    END AS GrowthPercent
FROM Sales;


-------------------------------------------------------------------------------------

	
-- Calculate Monthly Order Growth Rate
-WITH MonthlySales AS (
    SELECT
        DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS OrderMonth,
        SUM(total_amount) AS TotalSales
    FROM
        Orders
    GROUP BY
        DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1)
),
MonthlyGrowth AS (
    SELECT
        OrderMonth,
        TotalSales,
        LAG(TotalSales) OVER (ORDER BY OrderMonth) AS LastMonthSales,
        CASE
            WHEN LAG(TotalSales) OVER (ORDER BY OrderMonth) = 0 THEN NULL
            ELSE
                ROUND(
                    (TotalSales - LAG(TotalSales) OVER (ORDER BY OrderMonth)) * 100.0 /
                    NULLIF(LAG(TotalSales) OVER (ORDER BY OrderMonth), 0),
                    2
                )
        END AS GrowthRatePercent
    FROM
        MonthlySales
)

SELECT *
FROM MonthlyGrowth
ORDER BY OrderMonth;

-- Calculate Conversion Rate (Orders / Customer Sessions)
WITH OrderCounts AS (
    SELECT
        COUNT(DISTINCT id) AS TotalOrders
    FROM
        Orders
    WHERE
        order_date >= '2024-01-01' AND order_date < '2025-01-01'
),
SessionCounts AS (
    SELECT
        COUNT(DISTINCT customer_id) AS TotalSessions
    FROM
        customer_sessions
    WHERE
        session_start >= '2024-01-01' AND session_start < '2025-01-01'
)
SELECT
    CASE
        WHEN TotalSessions = 0 OR TotalOrders = 0 THEN NULL -- Or another appropriate value/message
        ELSE CAST(CAST(TotalOrders AS FLOAT) / CAST(TotalSessions AS FLOAT) AS DECIMAL(10, 2)) * 100
    END AS ConversionRate
FROM
    OrderCounts,
    SessionCounts;

-- Assuming 'order_date' and 'session_start' exist
SELECT CSELECT COUNT(DISTINCT id) FROM Orders WHERE order_date >= '2024-01-01' AND order_date < '2025-01-01';
OUNT(DISTINCT customer_id) FROM Customer_Sessions WHERE session_start >= '2024-01-01' AND session_start < '2025-01-01';


--Check for Duplicate order_ids in Returns:
SELECT order_id, COUNT(*) 
FROM Returns
GROUP BY order_id
HAVING COUNT(*) > 1;


--Check for order_ids in Returns that are not in Orders:
SELECT DISTINCT r.order_id
FROM Returns r
LEFT JOIN Orders o ON r.order_id = o.id
WHERE o.id IS NULL;

--------------------------------------------------------------------------

-- Calculate Top Selling Categories by Revenue
SELECT TOP 10
c.name AS CategoryName,
SUM(od.quantity * od.unit_price) AS TotalRevenue
FROM Categories c
JOIN Products p ON c.id = p.category_id
JOIN Order_Details od ON p.id = od.product_id
GROUP BY c.name
ORDER BY TotalRevenue DESC;


--The count of orders for each payment method: 
SELECT
    payment_method,
    COUNT(order_id) AS order_count
FROM
    Payments
GROUP BY
    payment_method
ORDER BY
    order_count DESC;


--The count of customers for each payment method: 
SELECT
    payment_method,
    COUNT(customer_id) AS order_count
FROM
    Payments
GROUP BY
    payment_method
ORDER BY
    order_count DESC;




--top 10 products by revenue
	SELECT TOP 10
    p.name AS ProductName,
    SUM(od.quantity * od.unit_price) AS TotalRevenue
FROM
    Products p
JOIN
    order_details od ON p.id = od.product_id
GROUP BY
    p.name
ORDER BY
    TotalRevenue DESC;

--top 10 products by #Orders
SELECT TOP 10
    p.name AS ProductName,
    COUNT(DISTINCT od.order_id) AS TotalOrders
FROM
    Products p
JOIN
    order_details od ON p.id = od.product_id
GROUP BY
    p.name
ORDER BY
    TotalOrders DESC;

--the sales by category
SELECT
    c.name AS CategoryName,
    SUM(od.quantity * od.unit_price) AS TotalRevenue
FROM
    Categories c
JOIN
    Products p ON c.id = p.category_id
JOIN
    order_details od ON p.id = od.product_id
GROUP BY
    c.name
ORDER BY
    TotalRevenue DESC;



--the revenue trend on a monthly
SELECT
    DATEFROMPARTS(YEAR(o.order_date), MONTH(o.order_date), 1) AS OrderMonth,
    SUM(od.quantity * od.unit_price) AS MonthlyRevenue
FROM
    Orders o
JOIN
    order_details od ON o.id = od.order_id
GROUP BY
    DATEFROMPARTS(YEAR(o.order_date), MONTH(o.order_date), 1)
ORDER BY
    OrderMonth;



--order volume showing monthly comparisons
SELECT
    DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS OrderMonth,
    COUNT(id) AS OrderCount
FROM
    Orders
GROUP BY
    DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1)
ORDER BY
    OrderMonth;
	select * from discounts


--Category and Related SubCategories
Select distinct pa.name as child , ch.name as parent
from categories ch join categories as pa
on ch.id = pa.parent_id
join categories ch2 
on ch2.parent_id = ch.id

select * from categories
select count(distinct parent_id) from categories 


---------------------------TOTAL AMOUNT (CATEGORY --> SUB-CATEGORY --> PRODUCTS)---------------------------
select
    parent_category.name as category_name,
    child_category.name as sub_category_name,
    products.name as product_name,
    SUM(order_details.quantity *order_details.unit_price) as total_sales
from
    order_details
join
    products on order_details.product_id = products.id
join
    categories as child_category on products.category_id = child_category.id
left join
    categories as parent_category on child_category.parent_id = parent_category.id
group by
    parent_category.name,
    child_category.name,
    products.name
order by
    parent_category.name,
    child_category.name,
    total_sales desc
---------------------------TOTAL AMOUNT OVER TIME---------------------------
select
    datename(month, order_date) as order_month,
    sum(total_amount) as total_sales
from
    orders
group by
    --datepart(year, order_date),
    --datepart(quarter, order_date),
    datename(month, order_date),
    datepart(month, order_date) 
order by
    --datepart(year, order_date),
    --datepart(quarter, order_date),
    datepart(month, order_date)


	
-- # of customer that repeat purchesing   (Repeat Purchase Rate KPI 2)
SELECT COUNT(*) AS repeat_customers
FROM (
  SELECT customer_id
  FROM orders
  GROUP BY customer_id
  HAVING COUNT(id) > 1
) AS repeat_clients

SELECT
    (COUNT(*) * 1.0 / (SELECT COUNT(DISTINCT customer_id) FROM orders)) * 100 AS repeat_purchase_rate
FROM (
    SELECT
        customer_id
    FROM
        orders
    GROUP BY
        customer_id
    HAVING
        COUNT(id) > 1
) AS repeat_clients;


 -- Top 10 customers in Purchase repeation   (EXTRA)  
select top 10 CONCAT(first_name ,' ', c.last_name) AS "Customer Name",c.id, count(o.customer_id) as "# of Purchase  repeation "
from customers c join orders o
on c.id = o.customer_id
group by CONCAT(first_name ,' ', c.last_name),c.id
having  count(o.customer_id) > 1
order by count(o.customer_id) desc

-- % of products in wishlist that already had purchused  (Wishlist Conversion Rate KPI 4)
SELECT COUNT(DISTINCT od.product_id) * 100.0 / (COUNT (DISTINCT w.product_id)) as " wishlist conversion rate"
FROM wishlists w
LEFT JOIN order_details od ON w.product_id = od.product_id 


-- Customer Segmentation Matrix (RFM Analysis - Recency, Frequency, Monetary) (Q1)
-- VISIT , ADD , PURCHASE

-- # of visiting the site per customer 
select cs.customer_id,count(cs.id) as "# of visits for customer"
from customer_sessions cs
group by cs.customer_id
order by "# of visits for customer" desc


-- # already purchased products per customer  
select o.customer_id,count(distinct od.product_id) as "# of purchased products " 
from orders o left join order_details od
on o.id = od.order_id 
group by  o.customer_id
order by "# of purchased products " desc


-- # orders per customer  
SELECT o.customer_id,COUNT(DISTINCT o.id) AS "# of orders"
FROM orders o 
GROUP BY o.customer_id
ORDER BY "# of orders" DESC



-- # of added PRODUCTS to wish list per customer
select w.customer_id ,count( w.product_id) as "# of products"
from wishlists w
where w.customer_id = 90
group by  w.customer_id 
order by "# of products" desc


-- # of products in wishlist and purchased in general 
select w.customer_id ,COUNT(DISTINCT w.product_id) AS "# of Purchased products from wishlist G"
FROM wishlists w
left join order_details od ON w.product_id = od.product_id left join orders o
on o.id = od.order_id 
where w.customer_id = o.customer_id
group by w.customer_id
order by "# of Purchased products from wishlist G" desc


-- # of products in wishlist and purchased after being added
select w.customer_id ,COUNT(DISTINCT w.product_id) AS "# of Purchased products from wishlist A"
FROM wishlists w
left join order_details od ON w.product_id = od.product_id left join orders o
on o.id = od.order_id
where w.customer_id = o.customer_id and o.order_date > w.added_date
group by w.customer_id
order by "# of Purchased products from wishlist A" desc



--Add Column Region 
ALTER TABLE customers
ADD Region VARCHAR(100);


--Extract Region From address column in customer table
UPDATE customers
SET Region = 
    REVERSE(
        SUBSTRING(
            REVERSE(address),
            CHARINDEX(' ', REVERSE(address)) + 1,
            CHARINDEX(' ', REVERSE(address), CHARINDEX(' ', REVERSE(address)) + 1) 
                - CHARINDEX(' ', REVERSE(address)) - 1
        )
    );

SELECT DISTINCT Region from customers



--#Regions
SELECT COUNT(DISTINCT Region) AS DistinctRegionCount
FROM customers
select DISTINCT Region from customers

--To convert Abbreviations to long fullname
ALTER TABLE customers
ALTER COLUMN region VARCHAR(100); 


--Convert Abbreviations to long fullname
UPDATE customers
SET Region = 
CASE Region
    WHEN 'AA' THEN 'Armed Forces Americas'
    WHEN 'AE' THEN 'Armed Forces Europe'
    WHEN 'AK' THEN 'Alaska'
    WHEN 'AL' THEN 'Alabama'
    WHEN 'AP' THEN 'Armed Forces Pacific'
    WHEN 'AR' THEN 'Arkansas'
    WHEN 'AS' THEN 'American Samoa'
    WHEN 'AZ' THEN 'Arizona'
    WHEN 'CA' THEN 'California'
    WHEN 'CO' THEN 'Colorado'
    WHEN 'CT' THEN 'Connecticut'
    WHEN 'DC' THEN 'District of Columbia'
    WHEN 'DE' THEN 'Delaware'
    WHEN 'FL' THEN 'Florida'
    WHEN 'FM' THEN 'Federated States of Micronesia'
    WHEN 'GA' THEN 'Georgia'
    WHEN 'GU' THEN 'Guam'
    WHEN 'HI' THEN 'Hawaii'
    WHEN 'IA' THEN 'Iowa'
    WHEN 'ID' THEN 'Idaho'
    WHEN 'IL' THEN 'Illinois'
    WHEN 'IN' THEN 'Indiana'
    WHEN 'KS' THEN 'Kansas'
    WHEN 'KY' THEN 'Kentucky'
    WHEN 'LA' THEN 'Louisiana'
    WHEN 'MA' THEN 'Massachusetts'
    WHEN 'MD' THEN 'Maryland'
    WHEN 'ME' THEN 'Maine'
    WHEN 'MH' THEN 'Marshall Islands'
    WHEN 'MI' THEN 'Michigan'
    WHEN 'MN' THEN 'Minnesota'
    WHEN 'MO' THEN 'Missouri'
    WHEN 'MP' THEN 'Northern Mariana Islands'
    WHEN 'MS' THEN 'Mississippi'
    WHEN 'MT' THEN 'Montana'
    WHEN 'NC' THEN 'North Carolina'
    WHEN 'ND' THEN 'North Dakota'
    WHEN 'NE' THEN 'Nebraska'
    WHEN 'NH' THEN 'New Hampshire'
    WHEN 'NJ' THEN 'New Jersey'
    WHEN 'NM' THEN 'New Mexico'
    WHEN 'NV' THEN 'Nevada'
    WHEN 'NY' THEN 'New York'
    WHEN 'OH' THEN 'Ohio'
    WHEN 'OK' THEN 'Oklahoma'
    WHEN 'OR' THEN 'Oregon'
    WHEN 'PA' THEN 'Pennsylvania'
    WHEN 'PR' THEN 'Puerto Rico'
    WHEN 'PW' THEN 'Palau'
    WHEN 'RI' THEN 'Rhode Island'
    WHEN 'SC' THEN 'South Carolina'
    WHEN 'SD' THEN 'South Dakota'
    WHEN 'TN' THEN 'Tennessee'
    WHEN 'TX' THEN 'Texas'
    WHEN 'UT' THEN 'Utah'
    WHEN 'VA' THEN 'Virginia'
    WHEN 'VI' THEN 'Virgin Islands'
    WHEN 'VT' THEN 'Vermont'
    WHEN 'WA' THEN 'Washington'
    WHEN 'WI' THEN 'Wisconsin'
    WHEN 'WV' THEN 'West Virginia'
    WHEN 'WY' THEN 'Wyoming'
    ELSE region  -- if unknown, keep the original value
END;

select DISTINCT Region from customers

--Identify Military Regions
SELECT distinct Region 
FROM customers
WHERE Region LIKE 'Armed%'

----------------------------------------------------------------


--Total Sales By Region
select top 8 Region , sum(total_amount) 
from orders o join customers c
on o.customer_id = c.id
group by Region
order by sum(total_amount)  desc
------------------------------------------------------------------------------

--NUM OF CUSTOMERS 
select count(id) as number_of_customers
from customers

--REGISTRATION OF CUSTOMERS OVER MONTHS 
select 
	month(registration_date) as month,
	count(id) as number_of_registrated_customers 
from customers
group by month(registration_date)

--CUSTOMER PER NUMBER OF ORDERS
select
	c.id as customer_id,
	c.first_name+' '+c.last_name as name,
	count(o.id) as num_of_orders
from customers c
join orders o
on c.id = o.customer_id
group by c.id, c.first_name+' '+c.last_name
order by count(o.id) desc

--CUSTOMERS PER TOTAL AMOUNT
select
	c.id as customer_id,
	c.first_name+' '+c.last_name as name,
	sum(o.total_amount) as total_amount_of_orders
from customers c
join orders o
on c.id = o.customer_id
group by c.id, c.first_name+' '+c.last_name
order by sum(o.total_amount) desc
----------------------------------------------------------------------------------
 -- new cuostomer per month
SELECT 
    FORMAT(registration_date, 'yyyy-MM') AS Month,
    COUNT(*) AS NewCustomers
FROM	
    Customers
GROUP BY 
    FORMAT(registration_date, 'yyyy-MM')
ORDER BY 
    Month;

--------------------------------------------------------------------------------------



--AVG CUSTOMERS RATE FOR EACH PRODUCT
select
	round(avg(r.rating*1.0),2) as Rating,
	p.name as product_name
from customers c
join reviews r
on c.id = r.customer_id
join products p 
on p.id =  r.product_id
group by p.name
order by round(avg(r.rating*1.0),2) desc


 -- Customer Acquisition Rate
WITH MonthlyData AS (
    SELECT 
        FORMAT(registration_date, 'yyyy-MM') AS Month,
        MIN(registration_date) AS StartOfMonth,
        COUNT(*) AS NewCustomers
    FROM 
        Customers
    GROUP BY 
        FORMAT(registration_date, 'yyyy-MM')
),
CumulativeCustomers AS (
    SELECT 
        m.Month,
        m.NewCustomers,
        (
            SELECT COUNT(*) 
            FROM Customers c 
            WHERE c.registration_date < m.StartOfMonth
        ) AS ExistingCustomers
    FROM MonthlyData m
)
SELECT 
    Month,
    NewCustomers,
    ExistingCustomers,
    CASE 
        WHEN ExistingCustomers = 0 THEN 100
        ELSE (CAST(NewCustomers AS FLOAT) / ExistingCustomers) * 100
    END AS AcquisitionRate
FROM 
    CumulativeCustomers
ORDER BY 
    Month;


-- Repeat ordars  Rate
WITH CustomerOrders AS (
    SELECT 
        customer_id,
        COUNT(*) AS OrderCount
    FROM 
        Orders
    GROUP BY 
        customer_id
),
RepeatStats AS (
    SELECT 
        COUNT(CASE WHEN OrderCount > 1 THEN 1 END) AS RepeatCustomers,
        COUNT(*) AS TotalCustomers
    FROM 
        CustomerOrders
)
SELECT 
    CAST(RepeatCustomers AS FLOAT) / TotalCustomers * 100 AS RepeatPurchaseRate
FROM 
    RepeatStats;


---Average Session Duration
SELECT 
    AVG(DATEDIFF(MINUTE, session_start , session_end)) AS AvgSessionDuration_Minutes
FROM 
    customer_sessions
WHERE 
    session_end IS NOT NULL;

	-- Wishlist Conversion Rate 
	SELECT COUNT(DISTINCT od.product_id) * 100.0 / (COUNT (DISTINCT w.product_id)) as " wishlist conversion rate"
FROM wishlists w
LEFT JOIN order_details od ON w.product_id = od.product_id 


-- Customer Satisfaction Score (Avg Review Rating) 
select AVG(rating) as"Avg customers Rating" 
from reviews


--Customer Lifetime Value ( CLV =  Average Order Value×Purchase Frequency per Year×Customer Lifetime (years))
select  (AVG (total_amount) * COUNT(DISTINCT id) / DATEDIFF(DAY, MIN(order_date), MAX(order_date)) * 365) as CLV from orders 
SELECT   (AVG(total_amount) * COUNT(id) / COUNT(DISTINCT customer_id)) * (DATEDIFF(DAY, MIN(order_date), MAX(order_date))) AS Customer_Lifetime_Value
FROM orders;
    


SELECT 
    customer_id, 
    avg(total_amount) AS AverageOrderValue
FROM 
    Orders
GROUP BY 
    customer_id;

	



--Customer Segmentation Matrix (RFM Analysis - Recency, Frequency, Monetary)
-----------Recency  (ãÊì ßÇä ÂÎÑ ÔÑÇÁ ÞÇã Èå ÇáÚãíá¿ ÇáÚãáÇÁ ÇáÐíä ÇÔÊÑæÇ ãÄÎÑðÇ íÚÊÈÑæä ÃßËÑ ÞíãÉ æ ÇáÚãáÇÁ ÇáÒì ãÑ Úáì ÇÎÑ Úãáíå ÔÑÇÁ ÝÊÑå .)


SELECT 
     customer_id ,
    DATEDIFF(DAY, MAX(order_date), GETDATE()) AS Recency
FROM 
    Orders 
GROUP BY 
    customer_id  having DATEDIFF(DAY, MAX(order_date), GETDATE()) < 30 order by Recency ;


-------------------------- ÇáÇÚãáÇÁ ÇáÒì áã íÔÊÑæ ÇßËÑ ãä 3 ÔåæÑ
	SELECT 
     customer_id ,
    DATEDIFF(DAY, MAX(order_date), GETDATE()) AS Recency
FROM 
    Orders 
GROUP BY 
    customer_id  having DATEDIFF(DAY, MAX(order_date), GETDATE()) > 90 order by Recency ;

	-------------Frequency ( ßã ãÑÉ ÇÔÊÑì ÇáÚãíá Ýí ÝÊÑÉ ãÚíäÉ¿ ÇáÚãáÇÁ ÇáÐíä íÔÊÑæä ÈÔßá ãÊßÑÑ íõÚÊÈÑæä ÃßËÑ æáÇ)
	---- ÇáÇßËÑ ÔÑÇÁ 
	SELECT 
    customer_id,
    COUNT(id) AS Frequency
FROM 
    Orders
GROUP BY 
    customer_id
HAVING COUNT(id) > 50
order by Frequency desc;
 --------------- ÇáÇÞá ÚÏÏ ÔÑÇÁ 
 SELECT 
    customer_id,
    COUNT(id) AS Frequency
FROM 
    Orders
GROUP BY 
    customer_id
HAVING COUNT(id) < 30
order by Frequency desc;



	--------------------Monetary (ßã ÃäÝÞ ÇáÚãíá¿ ÇáÚãáÇÁ ÇáÐíä íäÝÞæä ãÈÇáÛ ßÈíÑÉ íõÚÊÈÑæä ÃßËÑ ÑÈÍíÇ)
	WITH RFM AS (
    SELECT 
        customer_id,
        DATEDIFF(DAY, MAX(order_date), GETDATE()) AS Recency,
        COUNT(id) AS Frequency,
        SUM(total_amount) AS Monetary
    FROM 
        Orders
    GROUP BY 
        customer_id
)
SELECT 
    customer_id,
    Recency,
    Frequency,
    Monetary
FROM 
    RFM
ORDER BY 
    Recency;


	--------------------------- Review Sentiment Analysis 
	select   AVG(rating) as avregeRating from reviews

		
------------------------- Session Duration Distribution 
SELECT 
    id ,
    DATEDIFF(MINUTE, session_start, session_end) AS SessionDuration
FROM customer_sessions order by SessionDuration desc;



SELECT
  CASE  WHEN DATEDIFF(MINUTE, session_start, session_end) < 1 THEN '< 1 min'
    WHEN DATEDIFF(MINUTE, session_start, session_end) BETWEEN 1 AND 20 THEN '1-20 mins'
    WHEN DATEDIFF(MINUTE, session_start, session_end) BETWEEN 21 AND 40 THEN '20-40 mins'
    WHEN DATEDIFF(MINUTE, session_start, session_end) BETWEEN 41 AND 60 THEN '40-60 mins'
	WHEN DATEDIFF(MINUTE, session_start, session_end) BETWEEN 61 AND 80 THEN '60-80 mins'
	WHEN DATEDIFF(MINUTE, session_start, session_end) BETWEEN 81 AND 100 THEN '80-100 mins'
	WHEN DATEDIFF(MINUTE, session_start, session_end) BETWEEN 101 AND 120 THEN '100-120 mins'
    ELSE '> 120 mins'
   
  END AS DurationGroup,
  COUNT(*) AS SessionCount
FROM customer_sessions
GROUP BY
  CASE 
    WHEN DATEDIFF(MINUTE, session_start, session_end) < 1 THEN '< 1 min'
    WHEN DATEDIFF(MINUTE, session_start, session_end) BETWEEN 1 AND 20 THEN '1-20 mins'
    WHEN DATEDIFF(MINUTE, session_start, session_end) BETWEEN 21 AND 40 THEN '20-40 mins'
    WHEN DATEDIFF(MINUTE, session_start, session_end) BETWEEN 41 AND 60 THEN '40-60 mins'
	WHEN DATEDIFF(MINUTE, session_start, session_end) BETWEEN 61 AND 80 THEN '60-80 mins'
	WHEN DATEDIFF(MINUTE, session_start, session_end) BETWEEN 81 AND 100 THEN '80-100 mins'
	WHEN DATEDIFF(MINUTE, session_start, session_end) BETWEEN 101 AND 120 THEN '100-120 mins'
    ELSE '> 120 mins'
  END
ORDER BY DurationGroup   desc;



create view customers_segmentations
as
	with RFM as
	(
		select
			c.id as customer_id,
			c.first_name+' '+last_name as customer_name,
			datediff(day, max(o.order_date), getdate()) as recency_days,
			count(o.id) as frequency,
			sum(o.total_amount) as monetary
		from
			customers c
		left join
			orders o on c.id = o.customer_id
		group by
			c.id,
			c.first_name+' '+last_name
	),
	scores as
	(
		select
		customer_id,
		customer_name,
		-- Recency Score
		case 
			when recency_days <= 10 then 5
			when recency_days <= 20 then 4
			when recency_days <= 30 then 3
			when recency_days <= 40 then 2
			else 1
		end as r_score,

		-- Frequency Score
		case 
			when frequency >= 55 then 5
			when frequency >= 45 then 4
			when frequency >= 35 then 3
			when frequency >= 20 then 2
			else 1
		end as f_score,

		-- Monetary Score
		case 
			when monetary >= 280000 then 5
			when monetary >= 250000 then 4
			when monetary >= 220000 then 3
			when monetary >= 200000 then 2
			else 1
		end as m_score
		from RFM
	)
	select
		customer_id,
		customer_name,
		case 
		when r_score >= 4 and f_score >= 4 and m_score >= 4 then 'Gold'
		when r_score >= 3 and f_score >= 3 and m_score >= 2 then 'Silver'
		when r_score >= 2 and f_score >= 2 and m_score >= 1 then 'Bronze'
		else 'Normal'
	end as RFM_segment
	from scores


select * from customers_segmentations

ALTER TABLE customers ADD RFM VARCHAR(20);

--Add Segment column
UPDATE c
SET c.RFM = cs.RFM_segment
FROM customers c
JOIN cu stomers_segmentations cs ON c.id = cs.customer_id;

--------------------------------------------------------------------------------------------


--CUSTOMERS REASON FOR RETURNING FOR EACH PRODUCT
with reasons_of_product_returning as
(
	select 
		r.order_id,
		od.product_id,
		p.name,
		r.reason
	from returns r
	join orders o
	on r.order_id = o.id
	join order_details od
	on o.id = od.order_id
	join products p 
	on od.product_id = p.id
),
products_reason_for_returning as
(
	select 
		product_id,
		name,
		reason,
		count(reason) as Number_of_product_returns_for_that_reason
	from reasons_of_product_returning
	group by product_id, name, reason 
	
)
select *
from products_reason_for_returning
order by Number_of_product_returns_for_that_reason desc

--NUMBER OF CUSTOMERS PER PAYMENT METHODS
select 
	payment_method,
	count(id)
from payments
group by payment_method
order by count(id) desc

--AVG TIME PER SESSION
select avg(datediff(minute,session_start,session_end)) as avg_time_per_session_minutes
from customer_sessions

--Conversion Rate
/*select 
    cast(count(distinct o.id) * 100.0 / nullif(count(distinct cs.id), 0) as decimal(5,2)) as conversion_rate_percentage
from orders o
join customer_sessions cs
on o.customer_id = cs.customer_id

select count(distinct (id)) as IDs from orders
select count(distinct(id)) as IDs from customer_sessions
*/
with orders_in_session as (
	select
		cs.id as session_id,
		COUNT(o.id) as orders_in_session
	from 
		customer_sessions cs
	left join customers c
	on c.id = cs.customer_id
	left join orders o 
	on cs.customer_id = o.customer_id and o.order_date between cs.session_start and cs.session_end
	group by 
		cs.id
)
select 
	round(AVG(orders_in_session * 1.0)*100,2) as avg_orders_per_session
from orders_in_session;

--Favorite Products
select 
	p.id as product_id,
	p.name as product_name,
	count(wl.product_id) as num_of_desired_products
from wishlists wl
join products p
on wl.product_id = p.id
group by p.id, p.name
order by count(wl.product_id) desc


-------------------------------------------------------------------------------------------------
--Prepare Data For Machine Learning
SELECT
    o.id AS order_id,
    o.order_date,
    o.customer_id,

    -- ❗ هندلة بيانات مفقودة للميزات الفئوية (ISNULL في SQL Server)
    c.Region AS address,
    ISNULL(sh.carrier, 'Unknown Carrier') AS carrier,
    ISNULL(pay.payment_method, 'Unknown Payment') AS payment_method,

    -- ✅ Feature: هل تم إرجاع الطلب (return_flag)
    CASE
        WHEN r.return_date IS NULL THEN 0
        ELSE 1
    END AS return_flag,

    -- ✅ خصائص أساسية من تفاصيل الطلب
    COUNT(DISTINCT od.product_id) AS num_products,
    SUM(od.quantity) AS total_quantity,
    AVG(od.unit_price) AS avg_unit_price,

    -- ✅ متوسط تقييم المنتجات (مع معالجة NULL)
    ISNULL(re.avg_rating, 0) AS avg_rating,

    -- ✅ متغير الهدف (sales_target)، مع معالجة NULL إن وجدت
    ISNULL(o.total_amount, 0) AS sales_target,

    -- ✅ خصائص التاريخ (خاصة بـ SQL Server)
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    DATEPART(WEEKDAY, o.order_date) AS order_day_of_week, -- 1 = الأحد, ..., 7 = السبت
    DAY(o.order_date) AS order_day,
    DATEPART(DAYOFYEAR, o.order_date) AS order_day_of_year,

    -- ✅ خصائص سجل العميل (تم ضمها من الاستعلامات الفرعية)
    ISNULL(cust_sessions.avg_session_duration, 0) AS avg_session_duration,
    ISNULL(cust_sessions.num_sessions, 0) AS num_sessions,
    ISNULL(cust_sessions.days_since_last_session, 0) AS days_since_last_session,
    ISNULL(cust_sessions.total_session_duration, 0) AS total_session_duration,

    -- ✅ خصائص المنتج والفئة (الآن مجمعة على مستوى الطلب)
    ISNULL(order_product_category_info.min_category_id_in_order, 0) AS min_category_id_in_order,
    ISNULL(order_product_category_info.min_supplier_id_in_order, 0) AS min_supplier_id_in_order,
    ISNULL(order_product_category_info.min_category_parent_id_in_order, 0) AS min_category_parent_id_in_order,
    ISNULL(order_product_category_info.num_unique_categories_in_order, 0) AS num_unique_categories_in_order,
    ISNULL(order_product_category_info.num_unique_suppliers_in_order, 0) AS num_unique_suppliers_in_order,

    -- ✅ خصائص الخصومات (من الاستعلام الفرعي المُصحح)
    ISNULL(discount_info.has_active_discount, 0) AS has_active_discount,
    ISNULL(discount_info.avg_discount_percentage, 0) AS avg_discount_percentage,

    -- ✅ تجميعات على مستوى الطلب (من الاستعلام الفرعي)
    ISNULL(order_aggregations.avg_product_price_in_order, 0) AS avg_product_price_in_order,
    ISNULL(order_aggregations.total_products_in_order, 0) AS total_products_in_order

FROM orders o

JOIN order_details od ON o.id = od.order_id
LEFT JOIN customers c ON o.customer_id = c.id
LEFT JOIN shipping sh ON o.id = sh.order_id
LEFT JOIN payments pay ON o.id = pay.order_id
LEFT JOIN returns r ON o.id = r.order_id
-- تم حذف JOINs المباشرة لـ products و categories من هنا، ستتم إدارتها في الاستعلام الفرعي الجديد
-- LEFT JOIN products p ON od.product_id = p.id
-- LEFT JOIN categories cat ON p.category_id = cat.id

-- ✅ استعلام فرعي لمتوسط تقييم المنتجات في الطلب
LEFT JOIN (
    SELECT
        od_re.order_id,
        AVG(r_re.rating) AS avg_rating
    FROM order_details od_re
    JOIN reviews r_re ON od_re.product_id = r_re.product_id
    GROUP BY od_re.order_id
) re ON o.id = re.order_id

-- ✅ استعلام فرعي لخصائص سجل العميل (للتجميع على مستوى العميل قبل الضم بالطلب)
LEFT JOIN (
    SELECT
        cs_sub.customer_id,
        AVG(DATEDIFF(SECOND, cs_sub.session_start, cs_sub.session_end)) AS avg_session_duration,
        COUNT(DISTINCT cs_sub.id) AS num_sessions,
        MAX(DATEDIFF(DAY, cs_sub.session_end, GETDATE())) AS days_since_last_session,
        SUM(DATEDIFF(SECOND, cs_sub.session_start, cs_sub.session_end)) AS total_session_duration
    FROM customer_sessions cs_sub
    GROUP BY cs_sub.customer_id
) cust_sessions ON o.customer_id = cust_sessions.customer_id

-- ✅ استعلام فرعي لخصائص الخصومات
LEFT JOIN (
    SELECT
        od_disc.order_id,
        MAX(CASE
            -- شرط الخصم النشط: وجود الخصم، is_active = 1، وتاريخ الطلب يقع ضمن فترة صلاحية الخصم
            WHEN d_disc.id IS NOT NULL AND d_disc.is_active = 1 AND o_disc.order_date BETWEEN d_disc.start_date AND d_disc.end_date
            THEN 1
            ELSE 0
        END) AS has_active_discount,
        -- متوسط نسبة الخصم لجميع الخصومات المرتبطة بمنتجات في الطلب
        AVG(d_disc.percentage) AS avg_discount_percentage
    FROM
        order_details od_disc
    JOIN
        orders o_disc ON od_disc.order_id = o_disc.id
    LEFT JOIN
        products p_disc ON od_disc.product_id = p_disc.id
    LEFT JOIN
        discounts d_disc ON p_disc.id = d_disc.product_id
    GROUP BY
        od_disc.order_id
) discount_info ON o.id = discount_info.order_id

-- ✅ استعلام فرعي جديد لخصائص المنتج والفئة على مستوى الطلب
LEFT JOIN (
    SELECT
        od_prod.order_id,
        MIN(p_prod.category_id) AS min_category_id_in_order,
        MIN(p_prod.supplier_id) AS min_supplier_id_in_order,
        MIN(cat_prod.parent_id) AS min_category_parent_id_in_order,
        COUNT(DISTINCT p_prod.category_id) AS num_unique_categories_in_order,
        COUNT(DISTINCT p_prod.supplier_id) AS num_unique_suppliers_in_order
    FROM
        order_details od_prod
    JOIN
        products p_prod ON od_prod.product_id = p_prod.id
    LEFT JOIN
        categories cat_prod ON p_prod.category_id = cat_prod.id
    GROUP BY
        od_prod.order_id
) order_product_category_info ON o.id = order_product_category_info.order_id

-- ✅ استعلام فرعي للتجميعات على مستوى تفاصيل الطلب
LEFT JOIN (
    SELECT
        od_agg.order_id,
        AVG(od_agg.unit_price) AS avg_product_price_in_order,
        SUM(od_agg.quantity) AS total_products_in_order
    FROM order_details od_agg
    GROUP BY od_agg.order_id
) order_aggregations ON o.id = order_aggregations.order_id

GROUP BY
    o.id, o.order_date, o.customer_id,
    c.Region,
    ISNULL(sh.carrier, 'Unknown Carrier'),
    ISNULL(pay.payment_method, 'Unknown Payment'),
    r.return_date,
    ISNULL(re.avg_rating, 0),
    ISNULL(o.total_amount, 0),
    YEAR(o.order_date), MONTH(o.order_date), DATEPART(WEEKDAY, o.order_date), DAY(o.order_date), DATEPART(DAYOFYEAR, o.order_date),
    ISNULL(cust_sessions.avg_session_duration, 0), ISNULL(cust_sessions.num_sessions, 0), ISNULL(cust_sessions.days_since_last_session, 0), ISNULL(cust_sessions.total_session_duration, 0),
    -- الأعمدة المجمعة من الاستعلام الفرعي الجديد
    ISNULL(order_product_category_info.min_category_id_in_order, 0),
    ISNULL(order_product_category_info.min_supplier_id_in_order, 0),
    ISNULL(order_product_category_info.min_category_parent_id_in_order, 0),
    ISNULL(order_product_category_info.num_unique_categories_in_order, 0),
    ISNULL(order_product_category_info.num_unique_suppliers_in_order, 0),
    ISNULL(discount_info.has_active_discount, 0),
    ISNULL(discount_info.avg_discount_percentage, 0),
    ISNULL(order_aggregations.avg_product_price_in_order, 0),
    ISNULL(order_aggregations.total_products_in_order, 0);
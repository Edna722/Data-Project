-- find top generating products
select region, product_id, sum(sales_price) as sales
from orders_table
group by region, product_id
order by region, sales desc
LIMIT 10

-- TOP 5 HIGHEST SELLING PRODUCTS 
with cte as (
select region, product_id, sum(sales_price) as sales
from orders_table
group by region, product_id)

select * from (
	select *
	, row_number() over(partition by region order by region, sales desc) as rn
from cte ) A 
where rn <=5
 

--Month over Month growth 
with cte as (
	select  DATE_PART('year',order_date) as order_year, DATE_PART('month',order_date) as order_month, sum(sales_price) as sales 
from orders_table
group by DATE_PART('year',order_date), DATE_PART('month',order_date)
ORDER by DATE_PART('year',order_date), DATE_PART('month',order_date)

)

select order_month
	, sum(case when order_year = 2022 then sales else 0 end) as sales_2022
	, sum(case when order_year = 2023 then sales else 0 end) as sales_2023
from cte
group by order_month 
order by order_month


-- Month with highest Sales 
with cte as (
select category,to_char(order_date,'yyyymm') as order_year_month, 
sum(sales_price) as sales 
from   orders_table 
group by category, to_char(order_date, 'yyyymm')
)
	
select * from(
	select *,
row_number() over(partition by category order by sales desc) as rn
from cte
	) a 
where rn = 1 


--subcategory that had the highest profit in 2023 
with cte as (
select  sub_category,DATE_PART('year',order_date) as order_year, 
sum(sales_price) as sales 
from orders_table
group by sub_category,DATE_PART('year',order_date)
--ORDER by DATE_PART('year',order_date), DATE_PART('month',order_date)

), 
cte2 as (
	select sub_category
	, sum(case when order_year = 2022 then sales else 0 end) as sales_2022
	, sum(case when order_year = 2023 then sales else 0 end) as sales_2023
from cte
group by sub_category
)
select * 
,(sales_2023 - sales_2022)
from cte2
order by (sales_2023 - sales_2022) * 100/sales_2022 desc
LIMIT 1
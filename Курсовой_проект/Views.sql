use online_shop_test;

-- текущий складской остаток по городам с общей стоимостью товара 

create or replace view all_product_count as 
select 
	cl.name as city, -- имя города
	p.name as product, -- имя продукта
	p.price as price, -- цена продукта
	ca.amount as pr_count, -- остаток товара
	price * ca.amount as amount, -- общая стоимость товара
	wh.id as warehouse_id -- id склада
from products as p
join warehouses as wh on wh.city_id = p.city_id
join city_list as cl on cl.id = p.city_id
join current_amount as ca on ca.product_id = p.id
order by city

-- текущий остаток матричных товаров по городам

create or replace view matrix_products as 
select 
	cl.name as city,
	p.name as product,
	wh.id as warehouse,
	ca.amount as product_count
from products as p
join warehouses as wh on wh.city_id = p.city_id
join current_amount as ca on ca.product_id = p.id
join city_list as cl on cl.id = wh.city_id
where p.id in (14,22,54,67,21,89,112,43,34)
order by cl.name

-- Список сотрудников складов со статусами

create or replace view staff_status as 
select 
	wh.id as warehouse_id,
	cl.name as city,
	sl.id as staff_id,
	concat(sl.lastname, ' ', sl.first_name) as full_name,
	sl.status as status	
from staff_list as sl 
join warehouses as wh on wh.id = sl.warehouses_id
join city_list as cl on cl.id = wh.city_id
order by city, status

-- список 10 самых активных покупателей

create or replace view top_users as 
select 
	u.id as user_id,
	u.name as name,
	count(o.id) as orders_count,
	u.email as email,
	u.phone_number as phone_number
from users as u
join orders as o on o.user_id = u.id
group by user_id
order by orders_count desc
limit 10








use online_shop_test;

-- количество пользователей по городам
select 
	cl.name as city,
	count(u.id) as user_count	
from users as u
join city_list as cl 
	on cl.id = u.city_id
where u.user_type = 'user'
group by cl.name
order by user_count desc;

-- все складские запасы по городу
select 
	ca.product_id,
	p.name,
	ca.amount	
from current_amount as ca
join warehouses as wh 
	on wh.id = ca.warehouses_id
join city_list as cl 
	on cl.id = wh.city_id
join products as p 
	on p.id = ca.product_id 
where wh.city_id = 68  -- id города
order by ca.product_id;

-- количество товаров в каждой категории
select 
	pc.name as category,
	count(p.name) as product
from products as p
join product_category as pc 
	on pc.id = p.product_category_id
group by category;


-- список заказов по городу
select 	
	o.id as order_number
from orders o
join city_list cl 
	on o.city_id = cl.id
where o.city_id = 2;

-- список пользователей заказавших минимум N раз
select *
from(select
		o.user_id as uid,
		count(o.id) as order_count 
	from orders as o 
	join users as u 
		on u.id = o.id
	join city_list as cl 
		on cl.id = u.city_id
	group by uid
	order by order_count) as a
where order_count > 1; -- минимальное количество заказов

-- список пользователей заказавших минимум N раз в определеном городе

select *
from(select
		o.user_id as uid,
		count(o.id) as order_count,
		u.city_id as city
	from orders as o 
	join users as u 
		on u.id = o.id
	join city_list as cl 
		on cl.id = u.city_id
	group by uid
	order by order_count) as a
where order_count > 1 -- минимальное количество заказов
	and city = 2;-- id города

-- Средняя цена товаров в онлайн магазине 
select 
	avg(price)
from products as p;

-- Товары дешевле средней цены в онлайн магазине
select 
	*
from products as p
where price < (select avg(price) from products as p);

-- Средняя цена в категории 
select 
	avg(price) 
from products as p
join product_category as pc 
	on pc.id = p.product_category_id
where product_category_id = 100; -- поиск по id категории
-- where pc.name = 'dolore' -- поиск по имени категории

-- Cписок поставщиков отдельного города по id 
select
	vl.id,
	vl.name,
	vl.phone_number,
	vl.address
from vendor_list as vl
join city_list as cl 
	on cl.id = vl.city_id
where vl.city_id = 7; -- id искомого города 

-- Cписок поставщиков отдельного города по имени города
select
	vl.id,
	vl.name,
	vl.phone_number,
	vl.address
from vendor_list as vl
join city_list as cl 
	on cl.id = vl.city_id
where cl.name = 'incidunt'; -- имя искомого города



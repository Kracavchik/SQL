drop database if exists online_shop;
create database online_shop;
use online_shop;

-- таблица с именами городов.
drop table if exists city_list; 
create table city_list(
	id SERIAL PRIMARY key,
	name VARCHAR(100)
);

-- таблица категорий товаров.
drop table if exists product_category; 
create table product_category(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100)	
);

-- таблица склада.
drop table if exists warehouses;
create table warehouses(
	id serial primary key,
	city_id bigint unsigned not null,
	phone_number varchar(100) not null,
	
foreign key(city_id) references city_list(id)
);

-- таблица поставщиков товаров. 
drop table if exists vendor_list;
create table vendor_list(
	id SERIAL primary key,
	name varchar(100),
	phone_number varchar(100),
	`email` varchar(100),
	`address` varchar(100) not null,
	city_id bigint unsigned not null,
	
	foreign key(city_id) references city_list(id)
);

-- таблица товара.  
drop table if exists products;
create table products(
	id SERIAL primary key,
	name varchar(100),
	image_url varchar(200),
	price int,
	articulus int,
	product_category_id bigint unsigned not null,
	product_type enum('product','service'),
	product_count int,
	city_id bigint unsigned not null,
	vendor_id bigint unsigned not null,

index product_name(name),
index product_type(product_category_id),

foreign key (product_category_id) references product_category(id),
foreign key (city_id) references city_list(id),
foreign key (vendor_id) references vendor_list(id)
);


-- таблица текущего остатка на складе.
drop table if exists current_amount; 
create table current_amount(	
	product_id bigint unsigned not null,
	warehouses_id bigint unsigned not null,
	amount int,
	
primary key(product_id, warehouses_id),
foreign key(product_id) references products(id),
foreign key(warehouses_id) references warehouses(id)
);

-- таблица пользователя.
drop table if exists users; 
create table users(
	id SERIAL primary key,
	name varchar(100),
	phone_number varchar(100),
	`email` varchar(100),
	`address` varchar(100),
	city_id bigint unsigned not null,
	user_type enum ('user','admin') default 'user',
	
foreign key (city_id) references city_list(id)
);


-- таблица типов операций с товарами.
drop table if exists operation_types; 
create table operation_types(
	id serial primary key,
	name varchar(100)
);


-- таблица операций с товарами.
drop table if exists operation_list;
create table operation_list(
	id serial primary key,
	product_id bigint unsigned not null,
        product_count int not null,
	operation_type bigint unsigned not null,
	created_at datetime default now(),
	
foreign key(product_id) references products(id),
foreign key(operation_type) references operation_types(id)
);

-- таблица должностей сотрудников онлайн магазина
drop table if exists position_list; 
create table position_list(
	id serial primary key,
	position_name varchar(100)
);

-- таблица работников онлайн магазина

drop table if exists staff_list; 
create table staff_list(
	id serial primary key,
	first_name varchar(100),
	lastname varchar(100),
	`position` bigint unsigned not null,
	status enum('working', 'fired', 'vacation', 'sick') default 'working',
	warehouses_id bigint unsigned not null,
	
index position_idx(`position`),
index full_name_idx(first_name,lastname),

foreign key(`position`) references position_list(id),
foreign key(warehouses_id) references warehouses(id)
);

-- таблица вариантов доставок
drop table if exists delivery_types; 
create table delivery_types(
	id serial primary key,
	delivery_name varchar(100),
	delivery_terms varchar(300),
	company_name varchar(100),
	`price` int
);

-- таблица заказа 
drop table if exists orders; 
create table orders(
	id serial primary key,
	user_id bigint unsigned not null,
	city_id bigint unsigned not null,
	delivery_type bigint unsigned not null,

index(user_id,city_id),

foreign key(user_id) references users(id),
foreign key(city_id) references city_list(id),
foreign key(delivery_type) references delivery_types(id)
);

-- спецификация заказа
drop table if exists specifications; 
create table specifications(
	id serial primary key,
	product_id bigint unsigned not null,
	order_id bigint unsigned not null,
	`count` int,
	`price` int,
	`amount` int,
	
index(order_id),

foreign key(product_id) references products(id),
foreign key(order_id) references orders(id)
);

use online_shop_test;

-- Вставка фото-заглушки при отсутствие фото при Insert/Update/Delete
delimiter // 
create trigger no_image_ins before insert on products
for each row
begin
	declare no_image varchar(200);
	select 'http://lorempixel.com/no_image.jpg' into no_image;
	set new.image_url = coalesce(new.image_url, no_image);
end//
delimiter ;

delimiter // 
create trigger no_image_upd before update on products
for each row
begin
	declare no_image varchar(200);
	select 'http://lorempixel.com/no_image.jpg' into no_image;
	set new.image_url = coalesce(new.image_url, no_image);
end//
delimiter ;

delimiter // 
create trigger no_image_del before delete on products
for each row
begin
	declare no_image varchar(200);
	select 'http://lorempixel.com/no_image.jpg' into no_image;
	set new.image_url = coalesce(new.image_url, no_image);
end//
delimiter ;








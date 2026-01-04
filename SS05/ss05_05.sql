use ss05;
alter table products
add sold_quantity int default 0;

select * from Products;
update products
set sold_quantity = 20
where product_id in (1, 3, 5);
update products
set sold_quantity = 30
where product_id in (2, 4, 6);
update products
set sold_quantity = 10
where product_id in (7, 10);

-- lay 10 sp ban chay nhat
select product_name, sold_quantity from products
order by sold_quantity desc
limit 10;
-- lay 5 sp tiep
select product_name, sold_quantity from products
order by sold_quantity desc
limit 5 offset 10;
-- hien thi danh sach sp gia<2000000, sx so luong ban giam dan
select product_name,price, sold_quantity from products
where price< 200000
order by sold_quantity desc;
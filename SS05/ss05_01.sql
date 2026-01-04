create database ss05;
use ss05;
drop table Products;
create table Products(
	product_id int auto_increment primary key,
    product_name varchar(255) not null,
    price decimal(10,2),
    stock int,
    status enum('ACTIVE','INACTIVE')
);
INSERT INTO products (product_name, price, stock, status) VALUES
('Laptop', 1500000, 10, 'ACTIVE'),
('Mouse', 20000, 100, 'ACTIVE'),
('Keyboard',500000, 50, 'ACTIVE'),
('Monitor', 300000, 20, 'ACTIVE'),
('Printer',200000, 0, 'INACTIVE'),
('USB Cable',10000, 200, 'ACTIVE'),
('Webcam',80000, 15, 'ACTIVE'),
('Headphone',1200000, 0, 'INACTIVE'),
('Tablet',600000, 8, 'ACTIVE'),
('Speaker',150000, 12, 'ACTIVE');
-- lay toan bo sp
select product_name from Products;
-- lay danh sach sp dang ban
select product_name, status from Products
where status='active';
-- lay cac sp gia lon hon 1000000
select product_name, price from Products
where price > 1000000;
-- hien thi danh sach sp dang ban voi gia tang dan
select product_name, price, status from Products
where status='active' order by price;
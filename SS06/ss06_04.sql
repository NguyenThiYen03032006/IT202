create table products(
	product_id int primary key,
    product_name varchar(255),
    price decimal(10,2)
);

create table order_items(
	order_id int ,
    product_id int,
    quantity int,
    foreign key (product_id) references products(product_id),
    foreign key (order_id) references orders(order_id)
);

insert into products values
(1, 'Laptop Dell', 15000000),
(2, 'Chuột Logitech', 500000),
(3, 'Bàn phím cơ', 1200000),
(4, 'Màn hình Samsung', 7000000),
(5, 'Tai nghe Sony', 2500000);

insert into order_items values
(101, 1, 2),
(102, 2, 5),
(103, 3, 4),
(104, 4, 1),
(105, 5, 3),
(106, 1, 1),
(107, 3, 2);

-- hien thi moi sp da ban dc bao nhieu sp
select p.product_name, sum(oi.quantity) 'so_sp_dc_ban'
from products p
join order_items oi on oi.product_id = p.product_id
group by p.product_id;

-- tinh doanh thu cua tung sp
select p.product_name, sum(oi.quantity*p.price) 'doanh_thu'
from products p
join order_items oi on oi.product_id = p.product_id
group by p.product_id;

-- chi hien thi sp cp donh thu > 5000000
select p.product_name, sum(oi.quantity*p.price) 'doanh_thu'
from products p
join order_items oi on oi.product_id = p.product_id
group by p.product_id
having sum(oi.quantity*p.price)> 5000000;

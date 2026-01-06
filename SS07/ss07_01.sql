create database ss07;
use ss07;

create table customers(
	id int primary key,
    name varchar(255),
    email varchar(255)
);

create table orders(
	id int primary key,
    customer_id int,
    order_date date,
    total_amount decimal(10,2),
    foreign key (customer_id) references customers(id)
);

insert into customers values
(1,'nguyen van a','nva@gmail.com'),
(2,'nguyen van b','nvb@gmail.com'),
(3,'nguyen van c','nvc@gmail.com'),
(4,'nguyen van d','nvd@gmail.com'),
(5,'nguyen van e','nve@gmail.com'),
(6,'nguyen van f','nvf@gmail.com'),
(7,'nguyen van g','nvg@gmail.com');

insert into orders values
(1,1,'2025-03-12',2000000),
(2,4,'2025-02-18',3000000),
(3,2,'2025-11-25',700000),
(4,6,'2025-10-09',1400000),
(5,3,'2025-04-29',900000),
(6,1,'2025-08-17',2100000),
(7,6,'2025-12-12',1700000);

-- lay danh sach khach da tung dat don hang
select *
from customers
where id in ( select customer_id from orders);



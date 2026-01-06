
create table products(
	id int primary key,
    name varchar(255),
    price decimal(10,2)
);

create table order_items(
	order_id int,
    product_id int,
    quantiti int,
    foreign key (order_id) references orders(id),
    foreign key(product_id) references products(id)
);

insert into products values
(1,'sp 1',1000000),
(2,'sp 2',25000000),
(3,'sp 3',3500000),
(4,'sp 4',1200000),
(5,'sp 5',4000000),
(6,'sp 6',5500000),
(7,'sp 7',9000000);

insert into order_items values
(1,1,5),
(3,5,1),
(2,4,7),
(1,5,12),
(6,2,1),
(7,7,2),
(5,2,4);

-- lay danh sach sp da tung duoc ban
select * from products
where id in 
(select product_id from order_items);











create database ss06;
use ss06;
drop table orders;
drop table customers;
create table customers(
	customer_id int primary key,
    full_name varchar(255),
    city varchar(255)
);

create table orders(
	order_id int primary key,
    customer_id int,
    order_date date,
    status enum('pending','completed','cancelled'),
    
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers VALUES
(1, 'Nguyen Van An', 'Ha Noi'),
(2, 'Tran Thi Binh','Da Nang'),
(3, 'Le Van Cuong','Ho Chi Minh'),
(4, 'Pham Thi Dao','Ha Noi'),
(5, 'Hoang Van Em','Can Tho');

INSERT INTO orders VALUES
(101, 1, '2025-01-05', 'Completed'),
(102, 2, '2025-01-06','Completed'),
(103, 3, '2025-01-07','Completed'),
(104, 1, '2025-01-08','Completed'),
(105, 4, '2025-01-09','Completed'),
(106, 5, '2025-01-10','Completed'),
(107, 2, '2025-01-11','Completed'),
(108, 3, '2025-01-12','Completed');

-- hien thi danh sach don hang kem ten khach hang
select order_id, full_name as 'Ten khach hang'
from orders o
left join customers c on o.customer_id = c.customer_id;

-- hien thi moi khach hang da dat bao nhieu don hang
select c.full_name,count(o.order_id) 'so don'
from customers c
left join orders o on o.customer_id= c.customer_id
group by c.customer_id;

-- chi hien thi khach hang co it nhat 1 don
select c.full_name,count(o.order_id) 'so don'
from customers c
left join orders o on o.customer_id= c.customer_id
group by c.customer_id
having count(o.order_id)>0;
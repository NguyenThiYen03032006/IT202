create table Orders(
	order_id int auto_increment primary key,
    customer_id int,
    toltal_amount decimal(10,2),
    order_date date,
    status enum('pending', 'completed','cancelled')
);

insert into Orders(toltal_amount,order_date,status) values
(4000000,'2025-11-23','pending'),
(8000000,'2026-01-02','completed'),
(3000000,'2025-12-07','cancelled'),
(500000,'2025-10-03','pending'),
(18000000,'2025-09-02','completed'),
(3500000,'2025-02-13','cancelled'),
(14000000,'2026-01-04','pending'),
(800000,'2025-04-28','completed'),
(1400000,'2025-07-17','cancelled');

-- lay don hang da hoan thanh
select order_id, status from Orders
where status='completed';
-- lay don hang tong tien > 5000000
select order_id, toltal_amount from Orders
where toltal_amount > 5000000;
-- hien thij 5 don hang moi nhat
select order_id,order_date from Orders
order by order_date desc limit 5;
-- hien thi don hang da hoan thanh, sx theo tong tien giam dan
select order_id, toltal_amount, status from Orders
where status='completed'
order by toltal_amount desc;
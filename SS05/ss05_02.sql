create table Customers(
	customer_id int auto_increment primary key,
    full_name varchar(255),
    email varchar(255) unique,
    city varchar(255),
    status enum('ACTIVE','INACTIVE')
);
-- drop table Customers;
insert into Customers(full_name,email,city,status) values
('Nguyen Van A','nva@gmail.com','TP.HCM','ACTIVE'),
('Nguyen Van E','nvb@gmail.com','TP.HN','ACTIVE'),
('Nguyen Van D','nvd@gmail.com','TP.Da Nang','INACTIVE'),
('Nguyen Van B','nve@gmail.com','TP.HCM','ACTIVE');

-- lay danh sach tat ca khach hang
select full_name from Customers;
-- lay khach hang o tp.hcm
select full_name, city from Customers
where city='TP.HCM';
-- lay hanh khach dang hoat dong va o HN
select full_name,city,status from Customers
where city='TP.HN' and status='active';
-- sx danh sach khach hang theo ten a-z
select full_name from Customers
order by full_name;
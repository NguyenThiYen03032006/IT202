create database hackathon;
use hackathon;
-- drop table ClaimPayments;
-- drop table Policies;
-- drop table Customers;
-- drop table InsuranceAgents;

-- 1
create table Customers(
	customer_id varchar(10) primary key,
    full_name varchar(100) not null,
    phone varchar(15) not null unique,
    address varchar(200) not null
);

create table InsuranceAgents(
	agent_id varchar(10) primary key,
    full_name varchar(100) not null,
    region varchar(50) not null,
    years_of_experience int ,
    commission_rate decimal(5,2),
    check(years_of_experience>=0),
    check(commission_rate>=0)
);

create table Policies(
	policy_id int primary key auto_increment,
    customer_id varchar(10),
    agent_id varchar(10),
    start_date timestamp not null,
    end_date timestamp not null,
    status enum('Active','Expired','Cancelled'),
    
    foreign key (customer_id) references Customers(customer_id),
    foreign key(agent_id) references InsuranceAgents(agent_id)
);

create table ClaimPayments(
	payment_id int primary key auto_increment,
    policy_id int,
    payment_method varchar(50) not null,
    payment_date timestamp default current_timestamp,
    amount decimal(15,2),
    
    foreign key(policy_id) references Policies(policy_id),
    check(amount >=0)
);

-- 2 
insert into Customers values
('C001','Nguyen Van An','0912345678','Hanoi,Vietnam'),
('C002','Tran Thi Binh','0923456789','Ho Chi Minh,Vietnam'),
('C003','Le Minh Chau','0934567890','Da Nang,Vietnam'),
('C004','Pham Hoang Duc','0945678901','Can Tho, Vietnam'),
('C005','Vu Thi Hoa','0956789012','Hai Phong,Vietnam');

insert into InsuranceAgents values
('A001','Nguyen Van Minh','Mien Bac',10,5.50),
('A002','Tran Thi Lan','Mien Nam',15,7.00),
('A003','Le Hoang Nam','Mien Trung',8,4.50),
('A004','Pham Quang Huy','Mien Tay',20,8.00),
('A005','Vu Thi Mai','Mien Bac',5,3.50);

insert into Policies (customer_id,agent_id,start_date,end_date,status) values
('C001','A001','2024-01-01 08:00:00','2025-01-01 08:00:00','Active'),
('C002','A002','2024-02-01 09:30:00','2025-02-01 09:30:00','Expired'),
('C003','A003','2023-03-02 10:00:00','2024-03-02 10:00:00','Cancelled'),
('C004','A004','2024-05-02 14:00:00','2025-05-02 14:00:00','Active'),
('C005','A005','2024-06-03 15:30:00','2025-06-03 15:30:00','Active');

insert into ClaimPayments  values
(1,1,'Bank Transfer','2024-05-01 08:45:00',5000000.00),
(2,2,'Bank Transfer','2024-06-01 10:00:00',7500000.00),
(3,4,'Cash','2024-08-02 15:00:00',2000000.00),
(4,1,'Bank Transfer','2024-09-04 11:00:00',3000000.00),
(5,3,'Credit Card','2023-10-05 14:00:00',1500000.00);

-- 3
update Customers
set address= 'District 1, Ho Chi Minh City' 
where customer_id='C002';

-- 4 
update InsuranceAgents
set 
years_of_experience = years_of_experience + 2 ,
commission_rate= commission_rate + 1.15
where agent_id='A001';

-- 5 
delete  from Policies
where 
status='Cancelled' and
start_date > '2024-06-15 00:00:00';

-- truy van co ban
-- 6
select agent_id,full_name,region from InsuranceAgents
where years_of_experience >8;

-- 7
select customer_id,full_name,phone from Customers
where full_name like ('%Nguyen%');

-- 8
select policy_id,start_date,status from Policies
order by start_date desc;

-- 9
select * from ClaimPayments
where payment_method='Bank Transfer'
limit 3;
-- 10
select agent_id,full_name from InsuranceAgents
limit 3 offset 2;

-- truy van du lieu nang cao
-- 11
select p.policy_id,c.full_name as customer_name,i.full_name as agent_name
from Policies p
join Customers c on c.customer_id= p.customer_id
join InsuranceAgents i on i.agent_id= p.agent_id
where p.status ='Active';

-- 12
select i.agent_id,i.full_name,p.policy_id
from InsuranceAgents i
left join Policies p on p.agent_id=i.agent_id;

-- 13
select payment_method, sum(amount) as Total_Payout
from ClaimPayments
group by payment_method;

-- 14
select i.agent_id,i.full_name,sum(c.amount) as Total_Policies
from Policies p
join InsuranceAgents i on i.agent_id=p.agent_id
join ClaimPayments c on c.policy_id=p.policy_id
group by p.agent_id;

-- 15
select agent_id,full_name,commission_rate
from InsuranceAgents
where commission_rate >
(
	select avg(commission_rate)
	from InsuranceAgents
);

-- 16
select cu.customer_id, cu.full_name
from Policies p
join Customers cu on cu.customer_id=p.customer_id
join ClaimPayments cl on cl.policy_id= p.policy_id
group by p.policy_id
having sum(cl.amount) > 5000000;

-- 17
select p.policy_id,
cu.full_name as customer_name,
i.full_name as agent_name,
cl.payment_method, 
cl.amount
from ClaimPayments cl
join Policies p on p.policy_id=cl.policy_id
join Customers cu on cu.customer_id=p.customer_id
join InsuranceAgents i on i.agent_id = p.agent_id;










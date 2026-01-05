-- sua lai thong tin du lieu trong bang
alter table orders
add total_amount decimal(10,2);
update orders set total_amount = 1500000 where order_id = 101;
update orders set total_amount = 2200000 where order_id = 102;
update orders set total_amount = 1800000 where order_id = 103;
update orders set total_amount = 3000000 where order_id = 104;
update orders set total_amount = 1200000 where order_id = 105;
update orders set total_amount = 2500000 where order_id = 106;
update orders set total_amount = 1700000 where order_id = 107;
update orders set total_amount = 4000000 where order_id = 108;

-- hien thi tong tien moi khach hang
select c.full_name, sum(o.total_amount) 'tong_tien'
from customers c
join orders o on o.customer_id= c.customer_id
group by c.customer_id;

-- hien thi gtri don hang cao nhat cua tung khach
select c.full_name, max(o.total_amount) 'giatri_cao_nhat'
from customers c
join orders o on o.customer_id= c.customer_id
group by c.customer_id;

-- sx danh sach khach hang theo tong tien giam dan
select c.full_name, sum(o.total_amount) 'tong_tien'
from customers c
join orders o on o.customer_id= c.customer_id
group by c.customer_id 
order by  sum(o.total_amount) desc;
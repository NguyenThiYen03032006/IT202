select * from orders;
-- tinh tong doanh thu theo tung ngay
select order_date, sum(total_amount) as 'tong_doanh_thu'
from orders
group by order_date;

-- tinh so luong don hang theo tung ngay
select order_date, count(order_id) as 'so_don_hang'
from orders
group by order_date;

-- hien thi don hang co doanh thu > 10000000
select order_date, sum(total_amount) as 'tong_doanh_thu', count(order_id) as 'so_don_hang'
from orders
group by order_date
having sum(total_amount) > 10000000;

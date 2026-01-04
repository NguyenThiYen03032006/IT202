
-- trang 1
select * from Orders
where status != 'cancelled'
order by order_date desc
limit 5 offset 0;
-- trang 2
select * from orders
where status != 'cancelled'
order by order_date desc
limit 5 offset 5;
-- trang 3
select *
from orders
where status != 'cancelled'
order by order_date desc
limit 5 offset 5;
-- lay danh sach don hang co gtri lon hon gia trung binh cac don hang

select *
from orders
where total_amount > 
(select avg(total_amount) as gia_tb
from orders);
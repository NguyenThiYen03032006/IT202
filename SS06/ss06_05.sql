select 
    c.full_name,
    count(o.order_id) as 'tong_so_don',
    sum(o.total_amount) as 'tong_tien',
    avg(o.total_amount) as 'don_hang_trung_binh'
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id
having count(o.order_id) >= 3
   and sum(o.total_amount) > 10000000
order by tong_tien desc;

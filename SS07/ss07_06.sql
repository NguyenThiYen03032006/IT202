select 
    customer_id,
    sum(total_amount) as tong_tien
from orders
group by customer_id
having sum(total_amount) > (
    select avg(tong)
    from (
        select sum(total_amount) as tong
        from orders
        group by customer_id
    ) t
);

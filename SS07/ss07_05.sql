select id,name,
    (
        select sum(total_amount)
        from orders
        where orders.customer_id = customers.id
    ) as tong_tien
from customers
where (
    select sum(total_amount)
    from orders
    where orders.customer_id = customers.id
) = (
    select max(tong)
    from (
        select sum(total_amount) as tong
        from orders
        group by customer_id
    ) t
);

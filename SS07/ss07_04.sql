-- hien thi ten khach hang
-- hien thi so luong don hang cua tung khach

select name,(
select count(*) from orders o where o.customer_id=c.id
) as quantity_order
from customers c;
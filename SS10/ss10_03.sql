use social_network_pro;

-- truy vấn cơ bản
select *
from users
where hometown = 'Hà Nội';

-- kiểm tra kế hoạch thực thi (trước khi có index)
explain analyze
select *
from users
where hometown = 'Hà Nội';

-- câu 3:
create index idx_hometown 
on users (hometown);

-- câu 4:
explain analyze
select *
from users
where hometown = 'Hà Nội';

-- câu 6:
drop index idx_hometown 
on users;

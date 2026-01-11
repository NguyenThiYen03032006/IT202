use social_network_pro;

-- 2. tạo chỉ mục trên cột hometown
create index idx_hometown 
on users (hometown);

-- 3. truy vấn yêu cầu
select 
    u.user_id,
    u.username,
    u.full_name,
    u.hometown,
    p.post_id,
    p.content,
    p.created_at
from users u
left join posts p on u.user_id = p.user_id
where u.hometown = 'Hà Nội'
order by u.username desc
limit 10;

-- 4. kiểm tra kế hoạch thực thi trước khi có index
explain analyze
select 
    u.user_id,
    u.username,
    u.full_name,
    u.hometown,
    p.post_id,
    p.content,
    p.created_at
from users u
left join posts p on u.user_id = p.user_id
where u.hometown = 'Hà Nội'
order by u.username desc
limit 10;

create index idx_hometown 
on users (hometown);

explain analyze
select 
    u.user_id,
    u.username,
    u.full_name,
    u.hometown,
    p.post_id,
    p.content,
    p.created_at
from users u
left join posts p on u.user_id = p.user_id
where u.hometown = 'Hà Nội'
order by u.username desc
limit 10;

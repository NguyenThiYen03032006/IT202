use social_network_pro;

-- phần 2: chỉ mục phức hợp trên bảng posts
select 
    post_id,
    content,
    created_at
from posts
where user_id = 1
  and created_at >= '2026-01-01 00:00:00'
  and created_at < '2027-01-01 00:00:00'
order by created_at;

explain analyze
select 
    post_id,
    content,
    created_at
from posts
where user_id = 1
  and created_at >= '2026-01-01 00:00:00'
  and created_at < '2027-01-01 00:00:00'
order by created_at;

create index idx_created_at_user_id 
on posts (created_at desc, user_id);

explain analyze
select 
    post_id,
    content,
    created_at
from posts
where user_id = 1
  and created_at >= '2026-01-01 00:00:00'
  and created_at < '2027-01-01 00:00:00'
order by created_at;

-- phần 3: chỉ mục duy nhất trên bảng users (email)
select 
    user_id,
    username,
    email
from users
where email = 'an@gmail.com';

explain analyze
select 
    user_id,
    username,
    email
from users
where email = 'an@gmail.com';

create unique index idx_email 
on users (email);

explain analyze
select 
    user_id,
    username,
    email
from users
where email = 'an@gmail.com';

-- phần 4: xóa các chỉ mục đã tạo
drop index idx_created_at_user_id 
on posts;

drop index idx_email 
on users;

-- câu 2:
create view view_user_post as
select 
    u.user_id,
    count(p.post_id) as total_user_post
from users u
left join posts p on u.user_id = p.user_id
group by u.user_id;

-- câu 3:
select 
    user_id,
    total_user_post
from view_user_post
order by total_user_post desc, user_id;

-- câu 4:
select 
    u.full_name,
    v.total_user_post
from users u
inner join view_user_post v on u.user_id = v.user_id
order by v.total_user_post desc, u.full_name;

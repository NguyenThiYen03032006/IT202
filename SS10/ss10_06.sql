use social_network_pro;

create view view_users_summary as
select 
    u.user_id,
    u.username,
    count(p.post_id) as total_posts
from users u
left join posts p on u.user_id = p.user_id
group by u.user_id, u.username;

-- câu 3:
select 
    user_id,
    username,
    total_posts
from view_users_summary
where total_posts > 5
order by total_posts desc, username;

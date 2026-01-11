use social_network_pro;
-- cau 2
create index idx_user_gender
on users (gender);

-- cau 3
create view view_user_activity as
select
    u.user_id,
    count(distinct p.post_id) as total_posts,
    count(distinct c.comment_id) as total_comments
from users u
left join posts p on u.user_id = p.user_id
left join comments c on u.user_id = c.user_id
group by u.user_id;

-- cau 4
select *
from view_user_activity;

-- cau 5
select
    u.user_id,
    u.username,
    u.full_name,
    v.total_posts,
    v.total_comments
from users u
inner join view_user_activity v
    on u.user_id = v.user_id
where v.total_posts > 5
  and v.total_comments > 20
order by v.total_comments desc
limit 5;

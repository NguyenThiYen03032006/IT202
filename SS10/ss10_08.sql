use social_network_pro;

-- 2. tạo chỉ mục trên cột gender của bảng users
create index idx_user_gender 
on users (gender);

-- 3. tạo view view_popular_posts (không dùng coalesce)
create view view_popular_posts as
select 
    p.post_id,
    u.username,
    left(p.content, 150) as content_preview,
    ifnull(like_count.total_likes, 0) as total_likes,
    ifnull(comment_count.total_comments, 0) as total_comments,
    ifnull(like_count.total_likes, 0) + 
    ifnull(comment_count.total_comments, 0) as total_interactions
from posts p
inner join users u on p.user_id = u.user_id
left join (
    select 
        post_id, 
        count(*) as total_likes
    from likes
    group by post_id
) like_count on p.post_id = like_count.post_id
left join (
    select 
        post_id, 
        count(*) as total_comments
    from comments
    group by post_id
) comment_count on p.post_id = comment_count.post_id;

-- 4. truy vấn toàn bộ thông tin từ view (có thể giới hạn số dòng)
select 
    post_id,
    username,
    content_preview,
    total_likes,
    total_comments,
    total_interactions
from view_popular_posts
order by total_interactions desc
limit 20;

-- 5. liệt kê các bài viết có tổng tương tác (like + comment) > 10
select 
    post_id,
    username,
    content_preview as content,
    total_likes,
    total_comments,
    total_interactions
from view_popular_posts
where total_interactions > 10
order by total_interactions desc;

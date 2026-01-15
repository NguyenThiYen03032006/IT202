create database ss14_Ex5;
use ss14_Ex5;

-- 1. tạo các bảng cần thiết
create table users (
    user_id int primary key auto_increment,
    username varchar(50) not null,
    posts_count int default 0
);

create table posts (
    post_id int primary key auto_increment,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id)
);

create table comments (
    comment_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    content text,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

create table likes (
    like_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

-- tạo bảng log xóa bài viết 
create table delete_log (
    log_id int primary key auto_increment,
    post_id int,
    deleted_by int,
    deleted_at datetime default current_timestamp
);

-- 2. thêm dữ liệu mẫu
insert into users (username, posts_count) values ('nguyen_van_a', 1), ('tran_thi_b', 0);
insert into posts (user_id, content) values (1, 'bài viết cần xóa');
insert into comments (post_id, user_id, content) values (1, 2, 'bình luận dạo');
insert into likes (post_id, user_id) values (1, 2);

-- 3. viết stored procedure
delimiter ;;
create procedure sp_delete_post(
    in p_post_id int,
    in p_user_id int
)
begin
    -- biến để kiểm tra chủ sở hữu bài viết
    declare v_post_exists int;
    -- xử lý lỗi hệ thống
    declare exit handler for sqlexception
    begin
        rollback;
    end;
    start transaction;
    -- kiểm tra bài viết có tồn tại và đúng chủ không
    select count(*) into v_post_exists 
    from posts 
    where post_id = p_post_id and user_id = p_user_id 
    for update;
    if v_post_exists > 0 then
        -- bước 1: xóa like liên quan
        delete from likes where post_id = p_post_id;
        -- bước 2: xóa comment liên quan
        delete from comments where post_id = p_post_id;
        -- bước 3: xóa bài viết gốc
        delete from posts where post_id = p_post_id;
        -- bước 4: giảm số lượng bài viết của user
        update users 
        set posts_count = posts_count - 1 
        where user_id = p_user_id;
        -- bước 5: ghi log
        insert into delete_log (post_id, deleted_by) 
        values (p_post_id, p_user_id);
        -- xác nhận thành công
        commit;
        select 'thành công: đã xóa bài viết và dữ liệu liên quan' as 'kết quả';
    else
        -- không tìm thấy bài hoặc không phải chủ bài viết
        rollback;
    end if;
end ;;
delimiter ;

-- 4. chạy thử trường hợp lỗi
call sp_delete_post(1, 2);

-- 5. chạy thử trường hợp đúng
call sp_delete_post(1, 1);

-- 6. xem kết quả
-- kiểm tra bảng posts 
select post_id, content from posts;
-- kiểm tra bảng users 
select user_id, username, posts_count from users;
-- kiểm tra bảng comments và likes 
select comment_id, content from comments;
select like_id, post_id from likes;
-- kiểm tra log xóa
select log_id, post_id, deleted_by, deleted_at from delete_log;
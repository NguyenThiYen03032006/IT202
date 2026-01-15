create database ss14_04;
use ss14_04;

-- 1. tạo bảng
create table users (
    user_id int primary key auto_increment,
    username varchar(50) not null
);

create table posts (
    post_id int primary key auto_increment,
    user_id int not null,
    content text not null,
    comments_count int default 0,
    foreign key (user_id) references users(user_id)
);

create table comments (
    comment_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    content text not null,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

-- 2. dữ liệu mẫu
insert into users (username) values ('a'), ('b');
insert into posts (user_id, content) values (1, 'post 1');

-- 3. procedure với savepoint
delimiter ;;
create procedure sp_post_comment(
    in p_post_id int,
    in p_user_id int,
    in p_content text,
    in p_error boolean
)
begin
    -- lỗi update giữ comment
    declare exit handler for sqlexception
    begin
        rollback to savepoint point_after_insert;
    end;
    start transaction;
    -- thêm comment
    insert into comments (post_id, user_id, content) 
    values (p_post_id, p_user_id, p_content);
    -- tạo điểm lưu 
    savepoint point_after_insert;
    -- update số lượng 
    if p_error = true then
        signal sqlstate '45000';
    else
        update posts 
        set comments_count = comments_count + 1 
        where post_id = p_post_id;
    end if;
    commit;
    select 'thành công toàn bộ' as 'kết quả';
end ;;
delimiter ;

-- 4. test
-- case ngon: comment vào, count tăng
call sp_post_comment(1, 2, 'bình luận ok', false);

-- case lỗi update: savepoint, count không tăng
call sp_post_comment(1, 2, 'bình luận giữ lại dù lỗi', true);

-- 5. check 
select comment_id, content, post_id, user_id from comments;
select post_id, content, comments_count from posts;
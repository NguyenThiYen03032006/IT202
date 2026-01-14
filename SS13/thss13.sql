create database SocialNetworkDB;
use SocialNetworkDB;

create table users (
    user_id int auto_increment primary key,
    username varchar(50) not null,
    total_posts int default 0
);

create table posts (
    post_id int auto_increment primary key,
    user_id int,
    content text,
    created_at datetime default current_timestamp,
    constraint fk_posts_users foreign key (user_id) references users(user_id)
);

create table post_audits (
    audit_id int auto_increment primary key,
    post_id int,
    old_content text,
    new_content text,
    changed_at datetime default current_timestamp
);

insert into users (username, total_posts) values
('alice', 2),
('bob', 1),
('charlie', 3),
('david', 0),
('emma', 4);

insert into posts (user_id, content, created_at) values
(1, 'Bai viet dau tien cua Alice', '2025-01-01 08:00:00'),
(1, 'Alice chia se cuoc song', '2025-01-02 09:00:00'),
(2, 'Bob dang bai dau tien', '2025-01-03 10:00:00'),
(3, 'Charlie viet ve lap trinh', '2025-01-04 11:00:00'),
(3, 'Charlie chia se kinh nghiem', '2025-01-05 12:00:00');

insert into post_audits (post_id, old_content, new_content, changed_at) values
(1, 'Bai viet dau tien cua Alice', 'Alice cap nhat bai viet dau tien', '2025-01-06 08:00:00'),
(2, 'Alice chia se cuoc song', 'Alice chia se cuoc song hang ngay', '2025-01-06 09:00:00'),
(3, 'Bob dang bai dau tien', 'Bob dang bai ve cong viec', '2025-01-06 10:00:00'),
(4, 'Charlie viet ve lap trinh', 'Charlie viet ve SQL', '2025-01-06 11:00:00'),
(5, 'Charlie chia se kinh nghiem', 'Charlie chia se kinh nghiem hoc tap', '2025-01-06 12:00:00');

-- task 1 :  Kiểm tra nội dung bài viết (content). Nếu nội dung trống hoặc chỉ toàn khoảng trắng,
-- hãy ngăn chặn hành động chèn và thông báo lỗi: "Nội dung bài viết không được để trống!".

delimiter //
create trigger tg_CheckPostContent 
before insert on posts
for each row
begin
	if trim(new.content) ='' then
		signal sqlstate '45000' set message_text ='Nội dung bài viết không được để trống!';
	end if ;
end //
delimiter ;

-- task 2 Mỗi khi một bài viết được thêm mới thành công, hãy tự động tăng giá trị cột total_posts 
-- của người dùng đó trong bảng users lên 1 đơn vị.
delimiter //
create trigger tg_UpdatePostCountAfterInsert  
after insert on posts
for each row
begin
	update users
		set total_posts= total_posts +1
	where user_id= new.user_id;
end //
delimiter ;

-- task 3 Khi nội dung (content) của một bài viết bị thay đổi,
-- hãy tự động chèn một dòng vào bảng post_audits để lưu lại nội dung cũ, nội dung mới và thời điểm chỉnh sửa.
delimiter //
create trigger tg_LogPostChanges   
before update on posts
for each row
begin
	insert into post_audits (post_id, old_content, new_content, changed_at) 
    value
    (old.post_id,old.content,new.content,new.created_at);
end //
delimiter ;

-- task 4  Khi một bài viết bị xóa, hãy tự động giảm giá trị cột total_posts của
--  người dùng đó trong bảng users xuống 1 đơn vị.

delimiter //
create trigger tg_UpdatePostCountAfterDelete    
after delete on posts
for each row
begin
	update users
		set total_posts= total_posts -1
	where user_id= old.user_id;
end //
delimiter ;

drop trigger tg_CheckPostContent;
drop trigger tg_UpdatePostCountAfterInsert;
drop trigger tg_LogPostChanges;
drop trigger tg_UpdatePostCountAfterDelete;




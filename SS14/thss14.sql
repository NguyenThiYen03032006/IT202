create database social_netword_ss14;
use social_netword_ss14;

-- 1. Tạo bảng Users (Người dùng)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    total_posts INT DEFAULT 0
);

-- 2. Tạo bảng Posts (Bài viết)
CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 3. Tạo dữ liệu mẫu
INSERT INTO users (username, total_posts) VALUES ('nguyen_van_a', 0);
INSERT INTO users (username, total_posts) VALUES ('le_thi_b', 0);

drop procedure sp_create_post;

delimiter //
create procedure sp_create_post (in p_user_id int, in p_content text)
begin
	declare exit handler for sqlexception
    begin
		rollback;
		signal sqlstate '45000' set message_text='Da co loi say ra';
	end;


	if length(trim(p_content)) = 0 or p_content is null then
		signal sqlstate '45000' set message_text='Noi dung khong duoc de trong';
    end if;    
    
    start transaction;
    insert into posts (user_id,content,created_at)
    value (p_user_id, p_content,now());
	
    update users 
    set total_posts=total_posts +1
    where user_id=p_user_id;

	commit;
end //
delimiter ;

call sp_create_post(1,'Test so 1');
call sp_create_post(2,'test 2');













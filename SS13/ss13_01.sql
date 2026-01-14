create database social_netword_ss13;
use social_netword_ss13;

drop table users;
drop table posts;
create table users (
    user_id int auto_increment primary key,
    username varchar(50) not null unique,
    email varchar(100) not null unique,
    created_at datetime default current_timestamp,
    follower_count int default 0,
    post_count int default 0
);

create table posts (
    post_id int auto_increment primary key,
    user_id int,
    content text,
    created_at datetime,
    like_count int default 0,
    constraint fk_posts_users
        foreign key (user_id)
        references users(user_id)
        on delete cascade
);

insert into users (username, email, created_at) values
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');

insert into posts (user_id, content, created_at) values
(1, 'hello, this is alice first post', '2025-01-05 08:30:00'),
(1, 'alice is learning mysql', '2025-01-06 09:15:00'),
(2, 'bob joined the social network', '2025-01-05 10:00:00'),
(2, 'bob second post today', '2025-01-06 11:20:00'),
(3, 'charlie says hi everyone', '2025-01-07 14:45:00');

delimiter //
create trigger trigger_after_insert_posts
after insert on posts
for each row
begin
    update users
    set post_count = post_count + 1
    where user_id = new.user_id;
end //

delimiter ;
delimiter //
create trigger trigger_after_delete_posts
after delete on posts
for each row
begin
    update users
    set post_count = post_count - 1
    where user_id = old.user_id;
end //
delimiter ;
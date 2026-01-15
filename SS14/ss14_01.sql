create database if not exists social_network;
use social_network;

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
    constraint fk_posts_users
        foreign key (user_id)
        references users(user_id)
);

insert into users (username) values ('alice'), ('bob');

start transaction;

insert into posts (user_id, content)
values (1, 'bai viet dau tien cua alice');

update users
set posts_count = posts_count + 1
where user_id = 1;

commit;

select * from posts;
select * from users;


start transaction;

insert into posts (user_id, content)
values (999, 'bai viet loi');

update users
set posts_count = posts_count + 1
where user_id = 999;

rollback;












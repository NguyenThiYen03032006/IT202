use social_network;

create table likes (
    like_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    created_at datetime default current_timestamp,
    constraint fk_likes_posts
        foreign key (post_id) references posts(post_id),
    constraint fk_likes_users
        foreign key (user_id) references users(user_id),
    constraint unique_like unique (post_id, user_id)
);

alter table posts
add column likes_count int default 0;

start transaction;

insert into likes (post_id, user_id)
values (1, 1);

update posts
set likes_count = likes_count + 1
where post_id = 1;

commit;

select * from likes;
select post_id, likes_count from posts;

start transaction;

insert into likes (post_id, user_id)
values (1, 1);

update posts
set likes_count = likes_count + 1
where post_id = 1;

rollback;

use social_network;

create table if not exists followers (
    follower_id int not null,
    followed_id int not null,
    created_at datetime default current_timestamp,
    primary key (follower_id, followed_id),
    foreign key (follower_id) references users(user_id),
    foreign key (followed_id) references users(user_id)
);

alter table users
add column following_count int default 0,
add column followers_count int default 0;

create table if not exists follow_log (
    log_id int primary key auto_increment,
    follower_id int,
    followed_id int,
    error_message varchar(255),
    created_at datetime default current_timestamp
);

delimiter //

create procedure sp_follow_user (
    in p_follower_id int,
    in p_followed_id int
)
begin
    declare v_count int default 0;

    start transaction;

    -- kiểm tra user follower có tồn tại không
    select count(*) into v_count
    from users
    where user_id = p_follower_id;

    if v_count = 0 then
        insert into follow_log (follower_id, followed_id, error_message)
        values (p_follower_id, p_followed_id, 'follower khong ton tai');
        rollback;
        leave proc_end;
    end if;

    -- kiểm tra user followed có tồn tại không
    select count(*) into v_count
    from users
    where user_id = p_followed_id;

    if v_count = 0 then
        insert into follow_log (follower_id, followed_id, error_message)
        values (p_follower_id, p_followed_id, 'followed khong ton tai');
        rollback;
        leave proc_end;
    end if;

    -- kiểm tra tu follow chinh minh
    if p_follower_id = p_followed_id then
        insert into follow_log (follower_id, followed_id, error_message)
        values (p_follower_id, p_followed_id, 'khong the tu follow chinh minh');
        rollback;
        leave proc_end;
    end if;

    -- kiểm tra da follow truoc do chua
    select count(*) into v_count
    from followers
    where follower_id = p_follower_id
      and followed_id = p_followed_id;

    if v_count > 0 then
        insert into follow_log (follower_id, followed_id, error_message)
        values (p_follower_id, p_followed_id, 'da follow truoc do');
        rollback;
        leave proc_end;
    end if;

    -- neu moi thu ok
    insert into followers (follower_id, followed_id)
    values (p_follower_id, p_followed_id);

    update users
    set following_count = following_count + 1
    where user_id = p_follower_id;

    update users
    set followers_count = followers_count + 1
    where user_id = p_followed_id;

    commit;

    proc_end: end;
//

delimiter ;

call sp_follow_user(1, 2);


select * from followers;
select user_id, following_count, followers_count from users;

create table friendships (
    follower_id int,
    followee_id int,
    status enum('pending', 'accepted') default 'accepted',

    primary key (follower_id, followee_id),

    constraint fk_friendships_follower
        foreign key (follower_id)
        references users(user_id)
        on delete cascade,

    constraint fk_friendships_followee
        foreign key (followee_id)
        references users(user_id)
        on delete cascade
);

delimiter //

create trigger trigger_after_insert_friendships
after insert on friendships
for each row
begin
    if new.status = 'accepted' then
        update users
        set follower_count = follower_count + 1
        where user_id = new.followee_id;
    end if;
end //

delimiter ;

delimiter //

create trigger trigger_after_delete_friendships
after delete on friendships
for each row
begin
    if old.status = 'accepted' then
        update users
        set follower_count = follower_count - 1
        where user_id = old.followee_id;
    end if;
end //

delimiter ;

delimiter //

create procedure follow_user(
    in p_follower_id int,
    in p_followee_id int,
    in p_status enum('pending', 'accepted')
)
begin
    -- chặn tự follow
    if p_follower_id = p_followee_id then
        signal sqlstate '45000'
        set message_text = 'khong duoc follow chinh minh';
    end if;

    -- chặn follow trùng
    if exists (
        select 1
        from friendships
        where follower_id = p_follower_id
          and followee_id = p_followee_id
    ) then
        signal sqlstate '45000'
        set message_text = 'da ton tai quan he follow';
    end if;

    -- insert follow
    insert into friendships (follower_id, followee_id, status)
    values (p_follower_id, p_followee_id, p_status);
end //

delimiter ;

create view user_profile as
select
    u.user_id,
    u.username,
    u.email,
    u.follower_count,
    count(f.follower_id) as following_count
from users u
left join friendships f
    on u.user_id = f.follower_id
    and f.status = 'accepted'
group by u.user_id, u.username, u.email, u.follower_count;



use social_network_pro;
delimiter //

create procedure notifyfriendsonnewpost (
    in p_user_id int,
    in p_content text
)
begin
    declare done int default 0;
    declare v_friend_id int;
    declare v_full_name varchar(100);
    declare v_post_id int;

    declare friend_cursor cursor for
        select 
            case 
                when user_id = p_user_id then friend_id
                else user_id
            end as friend_id
        from friends
        where status = 'accepted'
          and (user_id = p_user_id or friend_id = p_user_id);

    declare continue handler for not found set done = 1;

    select full_name
    into v_full_name
    from users
    where user_id = p_user_id;

    insert into posts (user_id, content, created_at)
    values (p_user_id, p_content, now());

    set v_post_id = last_insert_id();

    open friend_cursor;

    read_loop: loop
        fetch friend_cursor into v_friend_id;

        if done = 1 then
            leave read_loop;
        end if;

        if v_friend_id <> p_user_id then
            insert into notifications (user_id, type, content, created_at)
            values (
                v_friend_id,
                'new_post',
                concat(v_full_name, ' đã đăng một bài viết mới'),
                now()
            );
        end if;

    end loop;

    close friend_cursor;

    select v_post_id as new_post_id;
end //

delimiter ;

call notifyfriendsonnewpost(1, 'hôm nay mình vừa học xong stored procedure trong mysql');

select *
from notifications
order by notification_id desc;

select *
from notifications
where type = 'new_post'
order by created_at desc;

drop procedure if exists notifyfriendsonnewpost;

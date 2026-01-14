delimiter //

create trigger trigger_before_insert_likes
before insert on likes
for each row
begin
    declare post_owner_id int;

    select user_id
    into post_owner_id
    from posts
    where post_id = new.post_id;

    if new.user_id = post_owner_id then
        signal sqlstate '45000'
        set message_text = 'khong duoc like bai viet cua chinh minh';
    end if;
end //

delimiter ;

delimiter //

create trigger trigger_after_insert_likes
after insert on likes
for each row
begin
    update posts
    set like_count = like_count + 1
    where post_id = new.post_id;
end //

delimiter ;

delimiter //

create trigger trigger_after_delete_likes
after delete on likes
for each row
begin
    update posts
    set like_count = like_count - 1
    where post_id = old.post_id;
end //

delimiter ;

delimiter //

create trigger trigger_after_update_likes
after update on likes
for each row
begin
    if old.post_id <> new.post_id then
        update posts
        set like_count = like_count - 1
        where post_id = old.post_id;

        update posts
        set like_count = like_count + 1
        where post_id = new.post_id;
    end if;
end //

delimiter ;

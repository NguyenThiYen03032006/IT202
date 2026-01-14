delimiter //

create procedure add_user(
    in p_username varchar(50),
    in p_email varchar(100),
    in p_created_at datetime
)
begin
    insert into users (username, email, created_at)
    values (p_username, p_email, p_created_at);
end //

delimiter ;

delimiter //

create trigger trigger_before_insert_users
before insert on users
for each row
begin
    -- kiểm tra email
    if new.email not like '%@%.%' then
        signal sqlstate '45000'
        set message_text = 'email khong hop le';
    end if;

    -- kiểm tra username (chỉ chữ, số, underscore)
    if new.username not regexp '^[a-zA-Z0-9_]+$' then
        signal sqlstate '45000'
        set message_text = 'username chi duoc chua chu, so va underscore';
    end if;
end //

delimiter ;

select * from users;


-- cau 2
delimiter //
create procedure CalculateBonusPoints (in p_user_id int, inout p_bonus_point int)

begin
declare count_post int;

select count(*) into count_post
from posts
where posts.user_id= p_user_id;

if count_post >=20 then set p_bonus_point= p_bonus_point + 100;
elseif count_post >=10 then set p_bonus_point = p_bonus_point +50;
end if;

end //
delimiter ;

-- cau 3
set @point_bonus=0;
call CalculateBonusPoints(1,@point_bonus);

-- cau 4
select @point_bonus;

-- cau 5
drop procedure CalculateBonusPoints;


-- cau 2
delimiter //
create procedure getTotalLike(in p_post_id int, out total_likes int)
begin
select count(l.post_id) 
from posts p
join likes l on p.post_id=l.post_id
where p.post_id=p_post_id;
end //
delimiter ;

-- cau 3
call getTotalLike(101,@total);

-- cau 4
drop procedure getTotalLike;
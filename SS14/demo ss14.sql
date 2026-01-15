use banking;
-- bắt đầu transaction
start transaction;
select * from account;
delete from account where id=2;
update account set full_name ='Be' where id=1;
update account set banlance = 1000 where id=4;
rollback;  -- huy thay doi
commit; -- xac nhan thay doi

-- bt : tạo thủ tục chuyển tiền giữa 2 tk
-- gồm các thao tác:
-- trừ tiền tk ng gửi
-- lưu thông báo trừ tiền
-- cộng tiền tk ng nhận
-- luu thông báo nhận tiền
-- nếu có lỗi logic hoặc lỗi sql thì rollback, nết tất cả thì commit
drop table transaction_log;
create table transaction_log (
    id int auto_increment primary key,
    account_id int,
    amount decimal(10,2),
    type varchar(20),
    created_at datetime
);

drop procedure trans_money;
delimiter //
create procedure trans_money (in p_sender int, in p_receiver int,  in sender_money decimal(10,2))
begin
-- tao bien luu tien
	declare money decimal(10,2);
    
    start transaction;
	-- luu tong so tien nguoi gui
    select balance into money from account where id= p_sender;
-- ktra so du tk du khong
	if  money< sender_money then 
		rollback;
		signal sqlstate '45000' set message_text='So du khong du';
	end if;
    -- tru tien nguoi gui
    update account set balance= balance - sender_money where id= p_sender;
    -- luu lai giao dich
    insert into transaction_log(account_id, amount, type, created_at)
    values (p_sender, sender_money, 'debit', now());
    -- cong tien ngươi nhan
    update account set balance= balance + sender_money where id = p_receiver;
    -- luu lai giao dich
     insert into transaction_log(account_id, amount, type, created_at)
    values (p_receiver, sender_money, 'credit', now());
    commit;
    
end //

delimiter ;

call trans_money(2,1,1000);

create database th005;
use th005;


-- Phan 1
-- Thiet ke bang
create table Students(
	student_id int primary key,
    full_name varchar(200),
    email varchar(200) unique,
    phone varchar(15) unique,
    balance decimal(10,2) default 0 check(balance >=0)
);

create table Student_Profiles(
	profile_id int primary key,
    student_id int,
    address varchar(200),
    education_level varchar(50),
    bio varchar(255),
    foreign key (student_id) references Students(student_id)
);

create table Courses(
	course_id int primary key,
    course_name varchar(100),
    description varchar(255),
    price decimal(10,2) check(price>=0),
    duration int,
    status enum('Active','Inactive')
);

create table Enrollments(
	enrollment_id int primary key,
    student_id int,
    course_id int,
    enrollment_date datetime default current_timestamp,
    status enum('Active','Pending','Cancelled'),
    foreign key (student_id) references Students(student_id),
    foreign key (course_id) references Courses(course_id)
);

create table Payments(
	payment_id int primary key,
    enrollment_id int,
    amount decimal(10,2) check(amount>=0) ,
    payment_date datetime default current_timestamp,
    payment_method varchar(50)
);

-- insert 5 ban ghi mau
insert into Students
(student_id,full_name,email,phone,balance)
values
(1,'Nguyen Van A','anv@gmail.com','901111111',5000000),
(2,'Tran Thi B','btt@yahoo.com','902222222',0),
(3,'Le Van C','cle@gmail.com','903333333',1200000),
(4,'Pham Minh D','dpham@hotmail.com','904444444',200000),
(5,'Hoang Anh E','ehoang@gmail.com','905555555',10000000);

insert into Student_Profiles
(profile_id,student_id,address,education_level,bio)
values 
(101,1,'Ha Noi','University','Yeu thich lap trinh'),
(102,2,'Da Nang','High School','Muon hoc thiet ke'),
(103,3,'HCM','Master','Chuyen gia du lieu'),
(104,4,'Can Tho','College','Nguoi moi bat dau'),
(105,5,'Hai Phong','PhD','Nghien cuu sinh');

insert into Courses
(course_id,course_name,price,duration,status)
values
(1,'Fullstack Java',2000000,40,'Active'),
(2,'Python for Data Science',1500000,30,'Active'),
(3,'ReactJS Advanced',1200000,20,'Inactive'),
(4,'Graphic Design Basic',800000,15,'Active'),
(5,'MySQL Database Master',500000,10,'Active');

insert into Enrollments
(enrollment_id,student_id,course_id,enrollment_date,status)
values
(1001,1,1,'2023-10-15','Active'),
(1002,2,4,'2023-11-20','Active'),
(1003,1,2,'2014-01-05','Pending'),
(1004,3,5,'2023-12-12','Cancelled'),
(1005,4,1,'2024-01-18','Active');

insert into Payments
(payment_id,enrollment_id,amount,payment_date,payment_method)
values
(501,1001,2000000,'2023-10-15','Banking' ),
(502,1002,800000,'2023-11-20','Credit Card' ),
(503,1005,2000000,'2024-01-18','Wallet' ),
(504,1004,500000,'2023-12-12','Banking' ),
(505,1001,0,'2023-10-16','Voucher' );

-- Viết câu lệnh UPDATE để giảm giá 10% cho tất cả các khóa học
update Courses
set price=price-(price*0.1);

-- Viết câu lệnh DELETE để xóa các bản ghi trong bảng Đăng ký (Enrollments) có trạng thái là 'Cancelled' và được tạo trước ngày 01/01/2024 
delete from Enrollments
where status='Cancelled' and
year(enrollment_date)>2024 and
month(enrollment_date)> 1 and 
day(enrollment_date) >1;

-- PHẦN 2: TRUY VẤN DỮ LIỆU CƠ BẢN 
-- Câu 1 (5đ): Lấy danh sách các khóa học (course_name, price, duration) có giá lớn hơn 1.000.000 VNĐ và thời lượng trên 30 giờ.
select course_name, price,duration
from Courses 
where price > 1000000 and duration> 30;

--  Câu 2 (5đ): Tìm thông tin học viên (full_name, email) có email thuộc tên miền '@gmail.com' và số dư tài khoản (balance) lớn hơn 500.000 VNĐ.
select full_name, email
from Students 
where email like '%@gmail.com' and
balance > 500000;

-- Câu 3 (5đ): Hiển thị Top 3 khóa học có giá cao nhất, sắp xếp giảm dần. Sử dụng LIMIT và OFFSET để bỏ qua khóa học đắt nhất (lấy từ khóa thứ 2 đến thứ 4).
select course_name, price
from Courses
order by price desc
limit 3 offset 1;

-- PHẦN 3: TRUY VẤN DỮ LIỆU NÂNG CAO 
-- Câu 1 (6đ): Viết câu lệnh truy vấn để hiển thị các thông tin gồm: Tên học viên, Tên khóa học, Ngày đăng ký và Trạng thái đăng ký. Chỉ lấy các bản ghi có trạng thái là 'Active'.
select 
s.full_name as ten_hoc_vien,
c.course_name as ten_khoa_hoc,
e.enrollment_date as ngay_dang_ky,
e.status as trang_thai_dang_ky
from Enrollments e
join Students s on e.student_id= s.student_id
join Courses c on e.course_id = c.course_id;

-- Câu 2 (7đ): Tính tổng doanh thu (amount) của từng phương thức thanh toán (payment_method). Chỉ hiển thị phương thức nào có tổng doanh thu trên 2.000.000 VNĐ.
select
sum(amount) as tong_doanh_thu,
payment_method
from Payments
group by payment_method;

-- Câu 3 Tìm ra thông tin khóa học (course_name) chưa từng có học viên nào đăng ký (không tồn tại course_id trong bảng Enrollments).
select
course_name as ten_khoa_hoc
from Courses c
left join Enrollments e on c.course_id= e.course_id
where e.enrollment_id is null;

-- PHẦN 4: INDEX VÀ VIEW (10 ĐIỂM)
-- Câu 1 (5đ): Tạo một Index tên là idx_student_email trên cột email của bảng Students để tối ưu hóa việc tìm kiếm học viên theo địa chỉ thư điện tử.

-- Câu 2 (5đ): Tạo một View tên là vw_student_enrollments hiển thị: Mã học viên, Tên học viên, Tổng số khóa học đã đăng ký (chỉ tính trạng thái 'Active') và Tổng số tiền đã thanh toán.
create view vw_student_enrollments as
select
e.student_id as ma_hoc_vien,
s.full_name as ten_hoc_vien,
count(e.student_id) as tong_so_khoa_hoc
from Enrollments e
join Students s on e.student_id = s.student_id;

-- PHẦN 5: TRIGGER (10 ĐIỂM)
-- Câu 1 (5đ): Viết Trigger trg_after_payment_insert. Khi một bản ghi mới được thêm vào bảng Payments, hãy tự động cập nhật trạng thái (status) của bản ghi tương ứng trong bảng Enrollments thành 'Active'.
delimiter //
create trigger trg_after_payment_insert
after insert on Payments
for each row
begin
	update Enrollments
    set status='Active'
    where enrollment_id= new.enrollment_id;
end //
delimiter ;

-- drop trigger trg_after_payment_insert;
-- check
insert into Payments
(payment_id,enrollment_id,amount,payment_date,payment_method)
values
(507,1003,2000000,'2023-10-14','Banking' )

-- Câu 2 (5đ): Viết Trigger trg_prevent_duplicate_enrollment. Trước khi INSERT vào bảng Enrollments, kiểm tra xem học viên đó đã đăng ký khóa học này chưa (kể cả trạng thái 'Pending' hay 'Active'). Nếu đã có, hãy hủy thao tác và báo lỗi: "Học viên đã đăng ký khóa học này rồi!".
delimiter //
create trigger trg_prevent_duplicate_enrollment
before insert on Enrollments
for each row
begin
	declare count_id int;
    
    select count(student_id) into count_id
    from Enrollments
    where student_id = new.student_id and
			course_id = new.course_id;
    
    if count_id >=1 then
		signal sqlstate '45000' set message_text='Hoc vien da dang ky khoa hoc nay roi';
      end if;  
end //
delimiter ;
-- drop trigger trg_prevent_duplicate_enrollment;

-- PHẦN 6: STORED PROCEDURE (20 ĐIỂM)
-- Câu 1 (10đ): Viết Procedure sp_get_course_revenue nhận vào Mã khóa học (p_course_id). Procedure trả về tham số OUT p_total_revenue là tổng số tiền thu được từ khóa học đó (dựa trên bảng Payments và Enrollments). Nếu khóa học không tồn tại, trả về 0.
delimiter //

create procedure sp_get_course_revenue (
    in p_course_id int,
    out p_total_revenue decimal(10,2)
)
begin
    declare course_count int;

    select count(*) into course_count
    from Courses
    where course_id = p_course_id;

    if course_count = 0 then
        set p_total_revenue = 0;
    else
        select ifnull(sum(p.amount), 0)
        into p_total_revenue
        from Enrollments e
        join Payments p on e.enrollment_id = p.enrollment_id
        where e.course_id = p_course_id;
    end if;
end //

delimiter ;








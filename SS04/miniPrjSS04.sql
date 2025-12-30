-- tạo cơ sở dữ liệu
create database online_learning;
use online_learning;

-- bảng student
create table student (
    student_id int primary key,
    full_name varchar(100) not null,
    date_of_birth date,
    email varchar(100) unique not null
);

-- bảng teacher
create table teacher (
    teacher_id int primary key,
    full_name varchar(100) not null,
    email varchar(100) unique not null
);

-- bảng course
create table course (
    course_id int primary key,
    course_name varchar(100) not null,
    description text,
    sessions int check (sessions > 0),
    teacher_id int,
    foreign key (teacher_id) references teacher(teacher_id)
);

-- bảng enrollment (đăng ký học)
create table enrollment (
    student_id int,
    course_id int,
    enroll_date date,
    primary key (student_id, course_id),
    foreign key (student_id) references student(student_id),
    foreign key (course_id) references course(course_id)
);

-- bảng result (kết quả học tập)
create table result (
    student_id int,
    course_id int,
    mid_score decimal(4,2) check (mid_score between 0 and 10),
    final_score decimal(4,2) check (final_score between 0 and 10),
    primary key (student_id, course_id),
    foreign key (student_id) references student(student_id),
    foreign key (course_id) references course(course_id)
);


-- Phần 2

-- thêm sinh viên (5 sinh viên)
insert into student values
(1,'nguyen van a','2005-01-12','a@gmail.com'),
(2,'tran thi b','2004-05-20','b@gmail.com'),
(3,'le van c','2003-11-02','c@gmail.com'),
(4,'pham thi d','2005-09-18','d@gmail.com'),
(5,'do van e','2004-03-30','e@gmail.com');

-- thêm giảng viên (5 người)
insert into teacher values
(101,'thay truong','truong@school.com'),
(102,'co linh','linh@school.com'),
(103,'thay hoang','hoang@school.com'),
(104,'co thao','thao@school.com'),
(105,'thay loc','loc@school.com');

-- thêm khóa học (5 khóa)
insert into course values
(201,'sql co ban','hoc sql tu co ban den nang cao',12,101),
(202,'lap trinh java','java co ban va oop',15,102),
(203,'html css','lap trinh web co ban',10,103),
(204,'python nang cao','phan tich du lieu voi python',18,104),
(205,'co so du lieu','cau truc csdl va toi uu',20,105);

-- thêm đăng ký học
insert into enrollment values
(1,201,'2025-01-10'),
(1,202,'2025-01-11'),
(2,201,'2025-01-12'),
(3,203,'2025-01-13'),
(5,205,'2025-01-14');

-- thêm kết quả học tập
insert into result values
(1,201,7.5,8.0),
(1,202,6.0,7.0),
(2,201,8.5,9.0),
(3,203,5.0,6.5),
(5,205,9.0,9.5);

-- Phần 3

-- -- cập nhật email sinh viên
update student
set email = 'new_a@gmail.com'
where student_id = 1;

-- cập nhật mô tả khóa học
update course
set description = 'khoa hoc java nang cao hon'
where course_id = 202;

-- cập nhật điểm cuối kỳ
update result
set final_score = 8.8
where student_id = 1 and course_id = 202;


-- phần 4
-- xóa lượt đăng ký sai
delete from enrollment
where student_id = 3 and course_id = 203;

-- xóa kết quả học tương ứng
delete from result
where student_id = 3 and course_id = 203;


-- phần 5
-- danh sách sinh viên
select * from student;

-- danh sách giảng viên
select * from teacher;

-- danh sách khóa học
select * from course;

-- thông tin đăng ký
select * from enrollment;

-- thông tin kết quả học tập
select * from result;

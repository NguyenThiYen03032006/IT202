create database ss04;
use ss04;
drop table Enrollment;
drop table Student;
drop table Course;
create table Student(
	student_id varchar(10) primary key,
    full_name varchar(30) not null,
    email varchar(30) unique,
    phone_number char(10) unique
);


create table Course(
	course_id varchar(10) primary key,
    course_name varchar(30) not null unique,
	credit int,
    
    constraint ck_des check(credit >0)
);

create table Enrollment(
	student_id varchar(10),
    course_id varchar(10),
	gradle decimal(4,2) default 0,
    
    constraint pk primary key (student_id,course_id),
    constraint fk_e_st foreign key (student_id) references Student(student_id),
    constraint fk_e_c foreign key (course_id) references Course(course_id),
    constraint ck_gradle check (gradle between 0 and 10)
);

-- them du lieu
insert into Student values
("ST001","Nguyen Van A","nva@gmail.com","0987654321"),
("ST002","Nguyen Van B","nvb@gmail.com","0912345678"),
("ST003","Nguyen Van C","nvc@gmail.com","0123456789"),
("ST004","Nguyen Van D","nvd@gmail.com","0198765432"),
("ST005","Nguyen Van E","nve@gmail.com","0192837465");

insert into Course values
("C001","Mon hoc A",4),
("C002","Mon hoc B",6),
("C003","Mon hoc C",3),
("C004","Mon hoc D",5),
("C005","Mon hoc E",2);

insert into Enrollment values
("ST001","C002",8.5),
("ST002","C003", 8.0),
("ST003","C005",9.5),
("ST004","C001",6.5),
("ST005","C004",7.0);

-- cap nhat
update Enrollment set gradle=9.0 where student_id="ST002" and course_id="C003";

-- truy van student name,email,phone
select student_id, full_name, phone_number from Student;

select * from Student;
select * from Enrollment;
select * from Course;

-- xoa khoa hoc
delete from Course where course_id="C001";
-- không thể xóa vì khóa học có id C001 được Enrollment tham chiếu đến bằng khóa ngoại, khóa học đó đang đc sử dụng bởi sinh viên ST004
-- my SQL không cho phép xóa dữ liệu của bản ghi cha khi có bản ghi con tham chiếu đến
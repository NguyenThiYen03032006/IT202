create database ss03_02;
use ss03_02;

create table Student(
	student_id int,
    full_name varchar(30) not null,
    date_of_birth date,
    email varchar(30) unique,
    
    constraint pk primary key (student_id)
);

insert into Student()
values
(1,"Nguyen Van A","2001-11-13","nva@gmail.com"),
(2,"Nguyen Van B","1999-04-25","nvb@gmail.com"),
(3,"Nguyen Van C","2000-02-28","nvc@gmail.com"),
(5,"Nguyen Van D","1998-07-29","nvd@gmail.com");

update Student set email="nvc-update@gmail.com" where student_id=3;
update Student set date_of_birth="2003-07-19" where student_id=2;
delete from Student where student_id=5;
select * from Student;

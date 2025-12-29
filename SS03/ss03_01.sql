create database ss03_01;
use ss03_01;

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
(3,"Nguyen Van C","2000-02-28","nvc@gmail.com");

select * from Student;
select student_id,full_name from Student;

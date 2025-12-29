create database ss03_04;
use ss03_04;

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
create table Subject(
	subject_id int,
    subject_name varchar(20) not null,
    credit int,
		
	constraint pk primary key (subject_id),
    constraint ck_credit check(credit >0)
);
insert into Subject values 
(1,"Mon hoc A",6),
(2,"Mon hoc B",4);
create table Enrollment(
	student_id int,
    subject_id int,
    enroll_date date,
    
    constraint pk primary key (student_id,subject_id),
    constraint fk_student foreign key (student_id) references Student(student_id),
    constraint fk_subject foreign key (subject_id) references Subject(subject_id)
    
);

insert into Enrollment values
(1,1,"2025-12-29"),
(2,1,"2025-12-30");

select * from Enrollment;
select * from Enrollment where student_id=1;
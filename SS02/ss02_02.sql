create database ss02_02;
use ss02_02;
drop table student;
drop table subject;
create table student(
	id char(10),
    full_name varchar(20),
    
    -- rang buoc
    constraint pk_student primary key (id)
);

create table subject(
	id char(10),
    name_subject varchar(20),
    credits int,
    -- rang buoc
    constraint pk_sub primary key (id),
    constraint check_credits check(credits >0)
);
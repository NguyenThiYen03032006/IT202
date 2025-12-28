create database ss02_05;
use ss02_05;
drop table score;
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
create table score(
	id_student char(10),
    id_subject char(10),
    process_score decimal(4,2) default 0,
    final_score decimal (4,2) default 0,
    
    constraint ck_process_score check (process_score between 0 and 10),
    constraint ck_final_score check (final_score between 0 and 10),
    constraint fk_student foreign key (id_student) references student(id),
    constraint fk_sub foreign key (id_subject) references subject(id)
);
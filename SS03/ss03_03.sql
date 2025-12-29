create database ss03_03;
use ss03_03;

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

update Subject set redit=8 where subject_id=2;
update Subject set subject_name="Ten update" where subject_id=1;
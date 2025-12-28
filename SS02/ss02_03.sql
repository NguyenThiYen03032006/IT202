create database ss02_03;
use ss02_03;

drop table enrollment;
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

-- bang trung gian
create table enrollment(
	id_student char(10),
    id_sub char(10),
    register_date date not null,
    -- rang buoc
    constraint pk primary key (id_student, id_sub), -- khoa chinh duoc gop tu 2 id
    constraint fk_student foreign key (id_student) references student(id),
    constraint fk_sub foreign key (id_sub) references subject(id)
);
create database ss02_06;
use ss02_06;

create table student(
	id char(10),
    full_name varchar(20),
    
    -- rang buoc
    constraint pk_student primary key (id)
);
create table classes(
	id char(10) not null ,
    name_class varchar(10) not null unique,
    years varchar(10),
    
    -- rang buoc
    constraint pk_class primary key (id)
);
create table teacher(
	id char(10),
    full_name varchar(20),
    email varchar(20),
    
    constraint pk_teacher primary key (id)
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
create table enrollment(
	id_student char(10),
    id_sub char(10),
    register_date date not null,
    -- rang buoc
    constraint pk primary key (id_student, id_sub), -- khoa chinh duoc gop tu 2 id
    constraint fk_enrollment_student foreign key (id_student) references student(id),
    constraint fk_enrollment_sub foreign key (id_sub) references subject(id)
);
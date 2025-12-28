create database ss02_01;
use ss02_01;
drop table student;
drop table classes;
create table classes(
	id char(10) not null ,
    name_class varchar(10) not null unique,
    years varchar(10),
    
    -- rang buoc
    constraint pk_class primary key (id)
);

create table student(
	id char(10),
    full_name varchar(20) not null,
    dob date,
    id_class char(10) not null,
    
    -- rang buoc
    constraint pk_student primary key (id),
    constraint fk_class foreign key (id_class) references classes(id)
);


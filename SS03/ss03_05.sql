-- drop table score;
create table score (
    student_id int,
    subject_id int,
    mid_score decimal(4,2) check(mid_score between 0 and 10),
    final_score decimal(4,2) check(final_score between 0 and 10),

    constraint pk primary key (student_id, subject_id),

    constraint fk_s_student foreign key (student_id) references student(student_id),
     constraint fk_s_subject foreign key (subject_id) references subject(subject_id)
);

insert into score (student_id, subject_id, mid_score, final_score)
values
    (1, 1, 7.5, 8.0),
    (1, 2, 6.0, 7.0),
    (2, 1, 8.0, 9.0),
    (3, 2, 5.5, 6.5);

update score
set final_score = 8.5
where student_id = 1 and subject_id = 102;

select * from score;

select student_id, subject_id, final_score
from score
where final_score >= 8;
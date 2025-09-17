-- q11
select dept_name
from department d
where (select sum(s.fee_paid) from student s where s.dept_id = d.dept_id) > 1000000;

-- q12
select dept_name
from department d
where (
  select count(*) from faculty f
  where f.dept_id = d.dept_id and f.salary > 100000
) > 5;

-- q13
delete from student
where gpa < (select avg(gpa) from student);

-- q14
delete from course
where course_id not in (select distinct course_id from enrollment);

-- q15
create table highfee_students as
select *
from student s
where s.fee_paid > (select avg(fee_paid) from student);

-- q16
create table retired_faculty as
select *
from faculty f
where f.joining_date < (select min(joining_date) from faculty);

-- q17
select dept_name
from department d
where (
    select sum(s.fee_paid)
    from student s
    where s.dept_id = d.dept_id
  ) =
  (
    select max(total_fees)
    from (
      select sum(s2.fee_paid) as total_fees
      from student s2 group by s2.dept_id
    )
  );

-- q18
select t.course_name
from (
  select c.course_name,
    (select count(*) from enrollment e where e.course_id = c.course_id) as cnt
  from course c
  order by cnt desc
) t
where rownum <= 3;

-- q19
select s.student_name
from student s
where 
  (select count(*) from enrollment e where e.student_id = s.student_id) > 3
  and s.gpa > (select avg(gpa) from student);

-- q20
create table unassigned_faculty as
select *
from faculty f
where f.faculty_id not in (select faculty_id from faculty_course);
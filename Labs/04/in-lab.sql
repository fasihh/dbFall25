-- q01
select
  d.dept_name as "Department",
  (select count(*) from student s where s.dept_id = d.dept_id) as "Student Count"
from department d;

-- q02
select dept_name
from department d
where (select avg(s.gpa) from student s where s.dept_id = d.dept_id) > 3.0;

-- q03
select
  c.course_name,
  round((select avg(s.fee_paid)
  from enrollment e, student s
  where e.student_id = s.student_id
    and e.course_id = c.course_id), 2) AS avg_fee
from course c;

-- q04
select dept_name,
  (select count(*) from faculty f where f.dept_id = d.dept_id) as faculty_count
from department d;

-- q05
select faculty_name, salary
from faculty f
where f.salary > (select avg(salary) from faculty);

-- q06
select student_name, gpa
from student s
where gpa > (select min(gpa) from student where dept_id = 1);

-- q07
select *
from (select student_name, gpa from student order by gpa desc)
where rownum <= 3;

-- q08
select *
from student s
where s.student_id in(
  select unique e1.student_id 
  from enrollment e1 
  where 
    e1.course_id in((
      select e2.course_id 
      from enrollment e2 
      where e2.student_id = (
        select s.student_id 
        from student s 
        where s.student_name like 'Ali'
      )
    ))
    and e1.student_id != (
      select s.student_id 
      from student s 
      where s.student_name like 'Ali'
    )
);

-- q09
select dept_name,
  (select sum(s.fee_paid) from Student s where s.dept_id = d.dept_id) as total_fees
from Department d;

-- q10
select distinct c.course_name
from course c
where c.course_id in (
  select e.course_id
  from enrollment e
  where e.student_id in (
    select s.student_id from student s where s.gpa > 3.5
  )
);
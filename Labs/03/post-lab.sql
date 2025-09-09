-- q11
alter table employees
add constraint bonus_constraint
unique ( bonus );

insert into employees
values ( 3, 'alice', 6000, 2, 1001, 'New York', 20, 'alice@mail.com' );

-- this will fail as bonus of 1001 already exists
insert into employees
values ( 4, 'bob', 6000, 2, 1001, 'New York', 21, 'bob@mail.com' );

-- q12
alter table employees
add dob date;

alter table employees
add constraint dob_constraint
check ( dob <= add_months(current_date, -12*18) );

-- q13

-- q14
alter table employees
drop constraint dept_fk;

select * from employees;

insert into employees
values ( 1, 'test', 1, 1, 1, 'karachi', 19, 'test@mail.com', '6-JULY-2005' );

alter table employees
add constraint dept_fk foreign key ( dept_id )
references departments ( dept_id );

-- q15
alter table employees
drop column age;

alter table employees
drop column city;

-- q16
select d.dept_name, e.full_name
from departments d
join employees e
on e.dept_id = d.dept_id;

-- q17
alter table employees
rename column salary to month_salary;

-- q18
select *
from departments d
where (select count(*) from employees e where e.dept_id = d.dept_id) = 0;

-- q19
truncate table students;

-- q20
select *
from departments
where department_id = (
  select department_id
  from employees
  where department_id is not null
  group by department_id
  order by count(*) desc
  fetch first 1 row only
);

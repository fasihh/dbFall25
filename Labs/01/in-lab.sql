-- q01
select * from employees where department_id <> 100;

-- q02
select * from employees where salary in(10000, 12000, 15000);

-- q03
select first_name, salary from employees where salary <= 25000;

-- q04
select * from employees where department_id <> 60;

-- q05
select * from employees where department_id between 60 and 80;

-- q06
select * from departments;

-- q07
select * from employees where first_name = 'Steven';

-- q08
select * from employees where department_id = 80 and salary between 15000 and 25000;

-- q09
select * from employees where salary < any(select salary from employees where department_id = 100);

-- q10
select *
from employees e1
where not exists(
  select * from employees e2 where e2.employee_id <> e1.employee_id and e2.department_id = e1.department_id
);

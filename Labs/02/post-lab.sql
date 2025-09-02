-- q11
select lpad(first_name, 15, '*') as "Padded first names" from employees;

-- q12
select ltrim(' Oracle') from dual;

-- q13
select initcap(first_name) as first_name from employees e;

-- q14
select next_day(to_date('20-AUG-2022'), 'Monday') as "Next Monday" from dual; 

-- q15
select to_char(to_date('25-DEC-2023'), 'MM-YYYY') as "Date" from dual;

-- q16
select distinct salary from employees order by salary;

-- q17
select round(salary, -2) from employees;

-- q18
select *
from departments
where department_id = (
  select department_id
  from employees
  where department_id is not null
  group by department_id
  order by count(*) desc
  fetch first 1 rows only
);

-- q19
select department_id, sum(salary) as "Total Salary"
from employees
where department_id is not null
group by department_id
order by "Total Salary" desc
fetch first 3 rows only;

-- q20 (same as q18)
select *
from departments
where department_id = (
  select department_id
  from employees
  where department_id is not null
  group by department_id
  order by count(*) desc
  fetch first 1 rows only
);
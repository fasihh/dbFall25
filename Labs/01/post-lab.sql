-- q11
select * from employees where hire_date between DATE '2005-01-01' and DATE '2006-12-31';

-- q12
select * from employees where manager_id is NULL;

-- q13
select * from employees where salary < all(select salary from employees where salary > 8000);

-- q14
select * from employees where salary > any(select salary from employees where department_id = 90);

-- q15
select * from departments d where exists(select * from employees e where e.department_id = d.department_id);

-- q16
select * from departments d where not exists(select * from employees e where e.department_id = d.department_id);

-- q17
select * from employees where salary not between 5000 and 15000;

-- q18
select * from employees where department_id in(10, 20, 30);

-- q19
select * from employees where salary < all(select salary from employees where department_id = 50);

-- q20
select * from employees where salary > all(select salary from employees where department_id = 90);

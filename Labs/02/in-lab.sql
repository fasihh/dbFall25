-- q01
select '$' || sum(salary) as "Total Salary" from employees;

-- q02
select '$' || round(avg(salary), 2) as "Average Salary" from employees;

-- q03
select count(*) as "Employees Reporting to Managers" from employees where manager_id is not null;

-- q04
select * from employees where salary = (select min(salary) from employees);

-- q05
select to_char(sysdate, 'DD-MM-YY') as "System Date" from dual;

-- q06
select to_char(sysdate, 'DAYMONTH  YYYY') as "System Date" from dual;

-- q07
select * from employees where to_char(hire_date, 'day') like 'wednesday';

-- q08
select to_date('01-JAN-2025') - to_date('01-OCT-2024') as "Date Difference" from dual;

-- q09
select first_name || ' ' || last_name as "Name", e.salary, e.job_id, floor(months_between(current_date, hire_date)) as "Months since hire" from employees e;

-- q10
select substr(last_name, 0, 5) from employees;

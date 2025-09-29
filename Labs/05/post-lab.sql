-- q11

create table student (
  std_id int primary key,
  std_name varchar(50),
  city varchar(50)
);

create table teacher (
  tch_id int primary key,
  tch_name varchar(50),
  city varchar(50)
);

insert into student values (1, 'Alice', 'Karachi');
insert into student values (2, 'Bob', 'Lahore');
insert into teacher values (1, 'Charlie', 'Karachi');
insert into teacher values (2, 'David', 'Islamabad');

select s.std_name, t.tch_name
from student s
join teacher t on s.city = t.city;

-- q12

create table department (
  dpt_id int primary key,
  dpt_name varchar(30)
);

create table employee (
  emp_id int primary key,
  emp_name varchar(30),
  mgr_id int,
  dpt_id int,

  foreign key (dpt_id) references department (dpt_id),
  foreign key (mgr_id) references employee (emp_id)
);

insert into department values (1, 'HR');
insert into department values (2, 'IT');

insert into employee values (1, 'Alice', null, 1);
insert into employee values (2, 'Bob', 1, 2);
insert into employee values (3, 'Charlie', 1, null);

select e.emp_name as "Employee Name", m.emp_name as "Manager Name"
from employee e
left join employee m on m.emp_id = e.mgr_id;

-- q13

select e.emp_name as "Employee Name" from employee e where e.dpt_id is null;

-- q14

alter table employee add (salary int);
update employee set salary = 50000 where dpt_id = 1;
update employee set salary = 60000 where dpt_id = 2;
update employee set salary = 40000 where dpt_id is null;

select d.dpt_name as "Department Name", avg(e.salary) as "Average Salary"
from department d
join employee e on d.dpt_id = e.dpt_id
group by d.dpt_id, d.dpt_name
having avg(e.salary) > 50000;

-- q15

insert into employee values (4, 'David', 2, 2, 70000);

select e.emp_name as "Employee Name"
from employee e
where e.salary > (select avg(salary) from employee where dpt_id = e.dpt_id);

-- q16

select d.dpt_name as "Department Name"
from department d
join employee e on d.dpt_id = e.dpt_id
group by d.dpt_id, d.dpt_name
having min(e.salary) > 30000;

-- q17

create table course (
  crs_id int primary key,
  crs_name varchar(20)
);

create table enrollment (
  std_id int,
  crs_id int,

  primary key (std_id, crs_id),
  foreign key (std_id) references student (std_id),
  foreign key (crs_id) references course (crs_id)
);

insert into course values (1, 'DBS');
insert into course values (2, 'PF');
insert into course values (3, 'AI');

insert into enrollment values (1, 1);
insert into enrollment values (1, 2);
insert into enrollment values (2, 1);
insert into enrollment values (2, 2);

select s.std_name, c.crs_name
from student s
join enrollment e on s.std_id = e.std_id
join course c on e.crs_id = c.crs_id
where s.city like 'Lahore';

-- q18

alter table employee add (hire_date date);

update employee set hire_date = '15-01-2020' where emp_id = 1;
update employee set hire_date = '20-03-2020' where emp_id = 2;
update employee set hire_date = '03-12-2021' where emp_id = 3;

select
  e.emp_name as "Employee Name",
  m.emp_name as "Manager Name",
  d.dpt_name as "Department Name"
from employee e
left join employee m on e.mgr_id = m.emp_id
left join department d on e.dpt_id = d.dpt_id
where e.hire_date BETWEEN '01-01-2020' AND '01-01-2023';

-- q19

update teacher set tch_name = 'Sir Ali' where tch_id = 1;

alter table enrollment add (tch_id int, foreign key (tch_id) references teacher (tch_id));

update enrollment set tch_id = 1 where crs_id = 1;
update enrollment set tch_id = 2 where crs_id = 2;

select s.std_name
from student s
join enrollment e on s.std_id = e.std_id
join teacher t on e.tch_id = t.tch_id
where t.tch_name like 'Sir Ali';

-- q20

select e.emp_name as "Employee Name"
from employee e
join employee m on e.mgr_id = m.emp_id
where m.dpt_id = e.dpt_id;

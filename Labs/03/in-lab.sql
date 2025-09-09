-- q01
create table employees (
  emp_id   int primary key,
  emp_name varchar(20),
  salary   int,
  dept_id  int
);

alter table employees
add constraint salary_constraint
check ( salary > 20000 );

-- q02
alter table employees
rename column emp_name to full_name;

alter table employees
modify full_name varchar(50);

-- q03
alter table employees drop constraint salary_constraint;

insert into employees values ( 2, 'fasih', 5000, 2 );

-- q04
create table departments (
  dept_id int primary key,
  dept_name varchar(20)
);

alter table departments
add constraint unique_dept_name
unique ( dept_name );

insert into departments values ( 1, 'HR' );
insert into departments values ( 2, 'IT' );
insert into departments values ( 3, 'Marketing' );

-- q05
alter table employees
add constraint dept_fk foreign key ( dept_id )
references departments ( dept_id );

-- 06
alter table employees
add bonus number(6, 2) default 1000;

-- q07
alter table employees
add city varchar(30) default 'Karachi';

alter table employees
add age int default 19;

alter table employees
add constraint age_constraint
check(age > 18);

-- q08
delete from departments where dept_id = 1 or dept_id = 3;

-- q09
alter table employees
modify full_name varchar(20);

alter table employees
modify city varchar(20);

-- q10
alter table employees
add email varchar(30);

alter table employees
add constraint email_constraint
unique ( email );

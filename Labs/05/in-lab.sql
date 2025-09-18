create table employee (
    emp_id int primary key,
    emp_name varchar(30),
    dpt_id int
);

create table department (
    dpt_id int primary key,
    dpt_name varchar(20)
);

alter table employee add constraint dpt_fk foreign key (dpt_id) references department (dpt_id);

insert into department values (1, 'HR');
insert into department values (2, 'IT');
insert into department values (3, 'Sales');


insert into employee values (1, 'Alice', 1);
insert into employee values (2, 'Bob', 2);
insert into employee values (3, 'Charlie', 2);
insert into employee values (4, 'David', 2);
insert into employee values (5, 'Eve', 1);
insert into employee values (6, 'Frank', 3);
insert into employee values (7, 'George', 3);

-- q01
select * from employee e cross join department d;

-- q02
select * from department d left join employee e on d.dpt_id = e.dpt_id;

-- q03
alter table employee add (mngr_id int, foreign key (mngr_id) references employee (emp_id));

update employee set mngr_id = 2 where emp_id in (3, 4);
update employee set mngr_id = 1 where emp_id = 5;
update employee set mngr_id = 6 where emp_id = 7;

select e1.emp_name as "Employee Name", e2.emp_name as "Manager Name"
from employee e1
join employee e2
on e1.mngr_id = e2.emp_id;

-- q04
create table emp_project (
    proj_id int primary key,
    proj_name varchar(20)
);

alter table employee add (proj_id int, foreign key (proj_id) references emp_project (proj_id));

insert into emp_project values (1, 'Orange');
insert into emp_project values (2, 'Mango');
insert into emp_project values (3, 'Apple');

update employee set proj_id = 1 where emp_id in (1, 3, 6);
update employee set proj_id = 2 where emp_id in (2, 4, 5);

select * from employee where proj_id is null;

-- q05
create table course (
    crs_id int primary key,
    crs_name varchar(20)
);

alter table student add (crs_id int, foreign key (crs_id) references course (crs_id));

insert into course values (1, 'PF');
insert into course values (2, 'Stats');

update student set crs_id = 2 where std_id in (1, 3);
update student set crs_id = 1 where std_id = 2;

select s.std_name, c.crs_name from student s join course c on s.crs_id = c.crs_id;

-- q06
create table customer (
    cst_id int primary key,
    cst_name varchar(20)
);

create table cust_order (
    ord_id int primary key
);

alter table cust_order add (cst_id int, foreign key (cst_id) references customer (cst_id));

insert into customer values (1, 'Ali');
insert into customer values (2, 'Abser');
insert into customer values (3, 'Owais');
insert into customer values (4, 'Fasih');

insert into cust_order values (1, 1);
insert into cust_order values (2, 1);
insert into cust_order values (3, 2);

select * from customer c left join cust_order co on c.cst_id = co.cst_id;

-- q07
insert into department values (4, 'Logistics');

select d.dpt_name, e.emp_name from department d left join employee e on d.dpt_id = e.dpt_id;

-- q08
select * from faculty;

alter table faculty add (crs_id int, foreign key (crs_id) references course (crs_id));

update faculty set crs_id = 1 where ft_id in(1, 2);
update faculty set crs_id = 2 where ft_id = 3;

select f.ft_name, c.crs_name from faculty f cross join course c;

-- q09
select d.dpt_name as "Department", count(e.emp_id) as "Total Employees"
from department d
join employee e on d.dpt_id = e.dpt_id
group by d.dpt_name;

-- q10
select s.std_name, f.ft_name, c.crs_name
from student s
join course c on s.crs_id = c.crs_id
join faculty f on s.ft_id = f.ft_id;


-- q01
create table bank_accounts (
  account_no int primary key,
  holder_name varchar2(50),
  balance int
);

insert into bank_accounts values (1, 'a', 20000);
insert into bank_accounts values (2, 'b', 15000);
insert into bank_accounts values (3, 'c', 5000);

update bank_accounts set balance = balance - 5000 where account_no = 1;

update bank_accounts set balance = balance + 5000 where account_no = 2;

update bank_accounts set balance = balance + 999 where account_no = 3;

rollback;

select * from bank_accounts;

-- q02
create table inventory (
  item_id int primary key,
  item_name varchar2(50),
  quantity int
);

insert into inventory values (1, 'i1', 100);
insert into inventory values (2, 'i2', 200);
insert into inventory values (3, 'i3', 300);
insert into inventory values (4, 'i4', 400);

update inventory set quantity = quantity - 10 where item_id = 1;

savepoint sp1;

update inventory set quantity = quantity - 20 where item_id = 2;

savepoint sp2;

update inventory set quantity = quantity - 5 where item_id = 3;

rollback to sp1;

commit;

-- q03
create table fees (
  student_id int primary key,
  name varchar2(50),
  amount_paid int,
  total_fee int
);

insert into fees values (1, 's1', 2000, 5000);
insert into fees values (2, 's2', 3000, 5000);
insert into fees values (3, 's3', 1000, 5000);

update fees set amount_paid = 2500 where student_id = 1;

savepoint halfway;

update fees set amount_paid = 3500 where student_id = 2;

rollback to halfway;

commit;

-- q04
create table products (
  product_id int primary key,
  product_name varchar2(50),
  stock int
);

create table orders (
  order_id int primary key,
  product_id int,
  quantity int
);

create sequence seq_orders start with 1 increment by 1 nocache;

insert into products values (1, 'p1', 50);
insert into products values (2, 'p2', 80);

update products set stock = stock - 5 where product_id = 1;

insert into orders values (seq_orders.nextval, 1, 5);

delete from products where product_id = 2;

rollback;

update products set stock = stock - 5 where product_id = 1;
insert into orders values (seq_orders.nextval, 1, 5);

commit;

-- q05
drop table employees;

create table employees (
  emp_id int primary key,
  emp_name varchar2(50),
  salary int
);

insert into employees values (1, 'e1', 1000);
insert into employees values (2, 'e2', 2000);
insert into employees values (3, 'e3', 3000);
insert into employees values (4, 'e4', 4000);
insert into employees values (5, 'e5', 5000);

update employees set salary = salary + 100 where emp_id = 1;

savepoint a;

update employees set salary = salary + 200 where emp_id = 2;

savepoint b;

update employees set salary = salary + 300 where emp_id = 3;
rollback to a;
commit;

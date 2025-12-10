-- q01
create table students (
  id int primary key,
  name varchar2(100)
);

create or replace trigger students_upper_name_trg
before insert on students
for each row
begin
  :new.name := upper(:new.name);
end;
/

insert into students values (1, 'john doe');

-- q02
create table employees (
  id int primary key,
  name varchar2(100),
  salary int
);

create or replace trigger emp_no_delete_weekend_trg
before delete on employees
begin
  if to_char(sysdate, 'dy', 'nls_date_language=english') in ('sat','sun') then
    raise_application_error(-20001, 'cannot delete employees on weekends');
  end if;
end;
/

insert into employees values (1, 'emp a', 1000);

-- q03
drop table employees;

create table employees (
  id int primary key,
  name varchar2(100),
  salary int
);

create sequence log_salary_audit_seq
increment by 1
start with 1
nocache;

create table log_salary_audit (
  audit_id int primary key,
  emp_id int,
  old_salary int,
  new_salary int,
  changed_at date
);

create or replace trigger emp_salary_update_audit_trg
after update of salary on employees
for each row
begin
  insert into log_salary_audit values (:log_salary_audit_seq.nextval, :old.id, :old.salary, :new.salary, sysdate);
end;
/

insert into employees values (1, 'emp b', 2000);
update employees set salary = 2500 where id = 1;

-- q04
create table products (
  id int primary key,
  name varchar2(100),
  price int
);

create or replace trigger products_no_negative_price_trg
before update on products
for each row
begin
  if :new.price < 0 then
    raise_application_error(-20002, 'price cannot be negative');
  end if;
end;
/

insert into products values (1, 'p1', 100);
update products set price = 150 where id = 1;

-- q05
create table courses (
  id int primary key,
  name varchar2(100),
  created_by varchar2(50),
  created_at date
);

create or replace trigger courses_insert_meta_trg
before insert on courses
for each row
begin
  :new.created_by := user;
  :new.created_at := sysdate;
end;
/

insert into courses (id, name) values (1, 'math');

-- q06
create table emp (
  id int primary key,
  name varchar2(100),
  department_id int
);

create or replace trigger emp_default_dept_trg
before insert on emp
for each row
begin
  if :new.department_id is null then
    :new.department_id := 10;
  end if;
end;
/

insert into emp (id, name) values (1, 'e1');

-- q07
create table sales (
  id int,
  amount int
);

create or replace trigger sales_compound_trg
for insert on sales
compound trigger
  v_before int;
  v_after int;
before statement is
begin
  select nvl(sum(amount),0) into v_before from sales;
end before statement;

after statement is
begin
  select nvl(sum(amount),0) into v_after from sales;
  dbms_output.put_line('total before insert: ' || v_before);
  dbms_output.put_line('total after insert: ' || v_after);
end after statement;

end sales_compound_trg;
/

insert into sales values (1, 100);

-- q08
create sequence schema_ddl_log_seq
increment by 1
start with 1
nocache;

create table schema_ddl_log (
  id int primary key,
  username varchar2(50),
  ddl_type varchar2(20),
  object_name varchar2(100),
  log_time date
);

create or replace trigger schema_ddl_log_trg
after ddl on schema
begin
  insert into schema_ddl_log values (schema_ddl_log_seq.nextval, sys_context('userenv','session_user'), ora_sysevent, ora_dict_obj_name, sysdate);
end;
/

create table ddl_test (x int);
drop table ddl_test;

-- q09
create table orders (
  id int primary key,
  order_status varchar2(20)
);

create or replace trigger orders_no_update_shipped_trg
before update on orders
for each row
begin
  if :old.order_status = 'SHIPPED' then
    raise_application_error(-20003, 'cannot update shipped orders');
  end if;
end;
/

insert into orders values (1, 'SHIPPED');
update orders set order_status = 'PENDING' where id = 1;

-- q10
create sequence login_audit_seq
increment by 1
start with 1
nocache;

create table login_audit (
  id int primary key,
  username varchar2(50),
  login_time date
);

create or replace trigger logon_audit_trg
after logon on schema
begin
  insert into login_audit values (login_audit_seq.nextval, sys_context('userenv','session_user'), sysdate);
end;
/

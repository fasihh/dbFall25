set serveroutput on;

declare
x int := 10;
begin
    dbms_output.put_line('global x ' || x);
    
    declare
    y int := 20;
    begin
        dbms_output.put_line('local y ' || y);
    end;
end;
/

declare
e_name varchar(255);
begin
    select first_name into e_name from employees where employee_id = 101;
    dbms_output.put_line('Employee name: ' || e_name);
exception
when NO_DATA_FOUND then
    dbms_output.put_line('No employee found');
end;
/

declare
begin
    update employees set salary = salary * 1.10
    where department_id = (select department_id from departments where department_name = 'Administration');
    dbms_output.put_line('Salary updated');
end;
/

declare
e_id employees.employee_id%type;
e_name employees.first_name%type;
d_name departments.department_name%type;
begin
    select e.employee_id, e.first_name || ' ' || e.last_name as employee_name, d.department_name into e_id, e_name, d_name
    from employees e
    join departments d on e.department_id = d.department_id
    where e.employee_id = 100;
    
    dbms_output.put_line('Employee ID: ' || e_id);
    dbms_output.put_line('Employee Name: ' || e_name);
    dbms_output.put_line('Department Name: ' || d_name);
end;
/

declare
e_id employees.employee_id%type := 100;
e_sal employees.salary%type;
e_did employees.department_id%type;
begin
    select salary, department_id into e_sal, e_did from employees where employee_id = e_id;
    case e_did
    when 90 then
        e_sal := e_sal + 100;
    when 50 then
        e_sal := e_sal + 200;
    when 40 then
        e_sal := e_sal + 300;
    else
        dbms_output.put_line('No such record');
        end;
    end case;
    update employees set salary = e_sal where employee_id = e_id;
end;
/


create table patient (
  patient_id int primary key,
  name varchar(50) not null,
  gender varchar(10) check (gender in ('M', 'F')) not null,
  dob date,
  email varchar(50) unique,
  phone varchar(15),
  address varchar(100),
  username varchar(20) not null unique,
  password varchar(20) not null
);

create table doctor (
  doctor_id int primary key,
  name varchar(50) not null,
  specialization varchar(50) not null,
  username varchar(20) not null unique,
  password varchar(20) not null
);

create table appointment (
  appointment_id int primary key,
  appointment_date date not null,
  appointment_time timestamp not null,
  status varchar(20) default 'scheduled' check (status in ('scheduled', 'completed', 'cancelled')) not null,
  clinic_number int not null,
  patient_id int references patient(patient_id),
  doctor_id int references doctor(doctor_id)
);

create table prescription (
  prescription_id int primary key,
  prescription_date date not null,
  doctor_advice varchar(255),
  patient_id int references patient(patient_id),
  doctor_id int references doctor(doctor_id),
  followup_required int default 0 check (followup_required in (0, 1)) not null
);

create table invoice (
  invoice_id int primary key,
  invoice_date date not null,
  amount float(2) not null,
  payment_status varchar(20) default 'unpaid' check (payment_status in ('paid', 'unpaid', 'refunded')) not null,
  payment_method varchar(20) check (payment_method in ('cash', 'card')) not null,
  patient_id int references patient(patient_id)
);

create table tests (
  test_id int primary key,
  test_type varchar(50) not null
);

-- creating patient data
insert into patient values (1, 'Ali', 'M', '01-01-1990', 'ali@example.com', '1234567890', '123 Street, City', 'ali123', 'password123');
insert into patient values (2, 'Sara', 'F', '02-02-1992', 'sara@example.com', '0987654321', '456 Avenue, City', 'sara123', 'password123');
insert into patient values (3, 'John', 'M', '03-03-1985', 'john@example.com', '5555555555', '789 Boulevard, City', 'john123', 'password123');
insert into patient values (4, 'Emma', 'F', '04-04-1995', 'emma@example.com', '1112223333', '321 Road, City', 'emma123', 'password123');
insert into patient values (5, 'Michael', 'M', '05-05-1988', 'michael@example.com', '2223334444', '654 Avenue, City', 'michael123', 'password123');

-- part A (DML Queries)
update patient set email = 'ali@mail.com', phone = '1111111111' where patient_id = 1;

-- creating an invoice
insert into invoice values (1, '01-01-2025', 150.00, 'unpaid', 'card', 1);

-- part B (DML Queries)
update invoice set payment_status = 'paid' where invoice_id = 1;

-- creating doctors
insert into doctor values (1, 'Dr. Smith', 'Cardiology', 'drsmith', 'docpass1');
insert into doctor values (2, 'Dr. Johnson', 'Neurology', 'drjohnson', 'docpass2');

-- creating appointments
insert into appointment values (1, '10-10-2025', TO_TIMESTAMP('10-10-2025 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'scheduled', 101, 1, 1);
insert into appointment values (2, '10-11-2025', TO_TIMESTAMP('10-11-2025 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'scheduled', 102, 2, 2);
insert into appointment values (3, '10-12-2025', TO_TIMESTAMP('10-12-2025 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'cancelled', 103, 3, 1);

-- part C (DML Queries)
delete from appointment where status = 'cancelled';

-- creating invoices
insert into invoice values (2, '15-10-2025', 200.00, 'unpaid', 'cash', 2);
insert into invoice values (3, '20-10-2025', 300.00, 'unpaid', 'card', 3);
insert into invoice values (4, '25-10-2025', 250.00, 'refunded', 'cash', 4);

-- part D (DML Queries)
delete from invoice where payment_status = 'refunded';

-- part E (DML Queries) -- Booked appointments are 'scheduled'
select * from appointment where status = 'scheduled';

-- part F (DML Queries)
select * from invoice where payment_status = 'unpaid';

-- create tests
insert into tests values (1, 'Blood Test');
insert into tests values (2, 'X Ray');
insert into tests values (3, 'MRI');
insert into tests values (4, 'CT Scan');

-- part G (DML Queries)
select * from tests where test_type like 'Blood Test';

-- creating prescriptions
insert into prescription values (1, '09-02-2025', 'Take rest and drink fluids', 1, 1, 0);
insert into prescription values (2, '10-02-2025', 'Take prescribed medication', 2, 2, 1);
insert into prescription values (3, '11-02-2025', 'Follow up in one week', 3, 1, 1);

-- part H (DML Queries) -- Prescriptions made on '02-09-2025' but format here is MM-DD-YYYY
select * from prescription where prescription_date = '09-02-2025';

-- part A (Advanced Queries)
select p.name as "Patient Name", d.name as "Doctor Name" from appointment a
join patient p on a.patient_id = p.patient_id
join doctor d on a.doctor_id = d.doctor_id;

-- add a test_id in prescription table
alter table prescription add test_id int references tests(test_id);

-- add a prescription with blood test
insert into prescription values (4, '12-02-2025', 'Get blood test done', 4, 2, 0, 1);

-- part B (Advanced Queries)
select p.name as "Patient Name", t.test_type as "Test Type", d.name as "Doctor Name" from prescription pr
join patient p on pr.patient_id = p.patient_id
join doctor d on pr.doctor_id = d.doctor_id
join tests t on pr.test_id = t.test_id;

-- create patient called ali khan and also prescriptions for it
insert into patient values (6, 'Ali Khan', 'M', '01-01-1990', 'alikhan@example.com', '1234567890', '123 Street, City', 'alikhan123', 'password123');
insert into prescription values (5, '12-02-2025', 'Get blood test done', 6, 2, 0, 1);
insert into prescription values (6, '13-02-2025', 'Rest for 3 days then come for a follow up', 6, 2, 1, null);

-- part C (Advanced Queries)
select pr.* from prescription pr
join patient p on pr.patient_id = p.patient_id
where p.name like 'Ali Khan';

-- part D (Advanced Queries)
select d.name, pr.* from prescription pr
join doctor d on pr.doctor_id = d.doctor_id
where pr.followup_required = 1;

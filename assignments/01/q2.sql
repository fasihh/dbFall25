-- defining schema
create table members (
  memberId int primary key,
  name varchar(20) unique,
  email varchar(30),
  joinDate date default current_date
);

create table books (
  bookId int primary key,
  title varchar(50),
  author varchar(30),
  copiesAvailable int check (copiesAvailable >= 0)
);

create table issuedBooks (
  issueId int primary key,
  memberId int references members(memberId),
  bookId int references books(bookId),
  issueDate date default current_date,
  returnDate date
);

-- defining catalog (based on the way defined in slides)
create table relations (
  relation_name varchar(100) primary key,
  no_of_columns int not null
);

create table relation_columns (
  column_name varchar(100),
  data_type varchar(50),
  belongs_to_relation varchar(100) references relations(relation_name),
  constraints varchar(100),
  primary key (column_name, belongs_to_relation)
);

insert into relations values ('members', 4);
insert into relations values ('books', 4);
insert into relations values ('issuedBooks', 5);

insert into relation_columns values ('memberId', 'int', 'members', 'primary key');
insert into relation_columns values ('name', 'varchar(20)', 'members', 'unique');
insert into relation_columns values ('email', 'varchar(30)', 'members', '');
insert into relation_columns values ('joinDate', 'date', 'members', 'default current_date');

insert into relation_columns values ('bookId', 'int', 'books', 'primary key');
insert into relation_columns values ('title', 'varchar(50)', 'books', '');
insert into relation_columns values ('author', 'varchar(30)', 'books', '');
insert into relation_columns values ('copiesAvailable', 'int', 'books', 'check (copiesAvailable >= 0)');

insert into relation_columns values ('issueId', 'int', 'issuedBooks', 'primary key');
insert into relation_columns values ('memberId', 'int', 'issuedBooks', 'foreign key references members(memberId)');
insert into relation_columns values ('bookId', 'int', 'issuedBooks', 'foreign key references books(bookId)');
insert into relation_columns values ('issueDate', 'date', 'issuedBooks', 'default current_date');
insert into relation_columns values ('returnDate', 'date', 'issuedBooks', '');


-- inserting data
insert into members (memberId, name, email) values (1, 'Alice', 'alice@mail.com');
insert into members (memberId, name, email) values (2, 'Bob', 'bob@mail.com');
insert into members (memberId, name, email) values (3, 'Charlie', 'charlie@mail.com');

insert into books values (101, 'Book 1', 'Author 1', 3);
insert into books values (102, 'Book 2', 'Author 2', 2);
insert into books values (103, 'Book 3', 'Author 3', 1);

insert into issuedBooks (issueId, memberId, bookId) values (1, 1, 101);
update books set copiesAvailable = copiesAvailable - 1 where bookId = 101;

select m.name, b.title, ib.issueDate from members m
left join issuedBooks ib on m.memberId = ib.memberId
left join books b on ib.bookId = b.bookId;

-- constraint violation demonstration
insert into members (memberId, name, email) values (1, 'David', 'david@mail.com');
insert into issuedBooks (issueId, memberId, bookId) values (2, 4, 103);
update books set copiesAvailable = -1 where bookId = 103;

-- improvement
-- 1. a way to let the end user know if due date is nearby. and when it exceeds, have the user be fined
-- 2. add specific users and roles on what they can do with the system

-- queries
-- a
select * from members m where not exists (
  select 1 from issuedBooks ib where m.memberId = ib.memberId
);
-- b
select * from books b where b.copiesAvailable = (
  select max(copiesAvailable) from books
);
-- c - most active member would be the one who has issued the most books
select t.name from (
  select m.name, count(ib.issueId) as booksIssued from members m
  join issuedBooks ib on m.memberId = ib.memberId
  group by m.name
  order by booksIssued desc
) t where ROWNUM = 1;
-- d
select b.* from books b where not exists (
  select 1 from issuedBooks ib where b.bookId = ib.bookId
);
-- e
select * from members m
join issuedBooks ib on m.memberId = ib.memberId
where ib.returnDate is null and current_date - ib.issueDate > 30;

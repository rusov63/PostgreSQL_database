create table employees
(
	employee_id int primary key,
	first_name varchar(10) not null,
	last_name varchar(10) not  null,
	title varchar(100) not null,
	birth_date date not null,
	notes text
);

select * from employees
select * from customers
select * from orders

drop table employees
drop table customers
drop table orders

create table customers
(
	customer_id varchar(10) not null,
	company_name varchar(100) not null,
	contact_name text
)

create table orders
(
	order_id int primary key,
	customer_id varchar(10) not null,
	employee_id int references employees(employee_id),
	order_date date,
	ship_city varchar(50)
)
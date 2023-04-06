CREATE TABLE employees
(
	user_id int primary key,
	fullname varchar(100) not null
);

select * from orders

create table customers
(
	user_id int primary key,
	fullname varchar(100) not null,
	PhoneNumber varchar(64) not null,
	image varchar(300)
);

create table orders
(
	user_id int primary key,
	number_order int references customers(user_id) not null,
	product text,
	Quantity int not null
)
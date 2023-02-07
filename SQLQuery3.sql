create database assignment3

use [assignment3]
go
create table department
(
dept_id int primary key ,
dept_name nvarchar(40)
)

use [assignment3]
go
create table employee
(
emp_id int primary key,
dept_id int foreign key references department(dept_id),
mngr_id int,
emp_name nvarchar(50),
salary int
)

insert into department values
(1001,'FINANCE'),
(2001,'AUDIT'),
(3001,'MARKETING'),
(4001,'PRODUCTION')

insert into employee values
(68319,1001,NULL,'KAYLING',6000),
(66928,3001,68319,'BLAZE',2750),
(67832,1001,68319,'CLARE',2550),
(65646,2001,68319,'JONAS',2957),
(67858,2001,65646,'SCARLET',3100),
(69062,2001,65646,'FRANK',3000),
(63679,4001,69062,'SANDRINE',900)

select * from employee
select * from department

/*  1. write a SQL query to find Employees who have the biggest salary in their Department */

select department.dept_name, MAX(salary) as max_salary from 
employee join  department
on employee.dept_id=department.dept_id
group by department.dept_name




/*  2. write a SQL query to find Departments that have less than 3 people in it  */


select department.dept_name, COUNT(employee.emp_id) from department join employee
on employee.dept_id=department.dept_id
group by department.dept_name
having count(*)< 3


/*   3. write a SQL query to find All Department along with the number of people there  */

select department.dept_name, COUNT(employee.emp_id) from department join employee
on employee.dept_id=department.dept_id
group by department.dept_name



/*   4. write a SQL query to find All Department along with the total salary there*/


select department.dept_name, sum(employee.salary) from employee join department
on employee.dept_id=department.dept_id
group by department.dept_name
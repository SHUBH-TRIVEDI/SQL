create database assignment2

use [assignment2] 
go
create table salesman(salesman_id int not null primary key,
name nvarchar(50) not null,
city nvarchar(50) not null,
commission decimal(10,2) not null,)

create table customer
(customer_id int not null primary key,
cust_name nvarchar(40) not null,
city nvarchar(40) not null,
grade  int null,
salesman_id int not null,FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id))create table orders(
ord_no int not null primary key,
purch_amt int,
ord_date date not null,
customer_id int not null foreign key references customer(customer_id),
salesman_id int not null foreign key references salesman(salesman_id)
)insert into salesman values
(5001,'James Hoog','New York',0.15),
(5002,'Nail Knite','Paris',0.13),
(5005,'Pit Alex','London',0.11),
(5006,'Mc Lyon','Paris',0.14),
(5007,'Paul Adam','Rome',0.13),
(5003,'Lauson Hen','San Jose',0.12)insert into customer values
(3002,'Nick Rimando','New York',100,5001),
(3007,'Brad Davis','New York',200,5001),
(3005,'Graham Zusi','California',200,5002),
(3008,'Julian Green',' London',300,5002),
(3004,'Fabian Johnson','Paris',300,5006),
(3009,'Geoff Cameron','Berlin',100,5003),
(3003,'Jozy Altidor','Moscow',200,5007),
(3001,'Brad Guzan','London',null,5005)insert into orders values
(70001,150.5,'2012-10-05',3005,5002),
(70009,270.65,'2012-09-10',3001,5005),
(70002,65.26,'2012-10-05',3002,5001),
(70004,110.5,'2012-08-17',3009,5003),
(70007,948.5,'2012-09-10',3005,5002),
(70005,2400.6,'2012-07-27',3007,5001),
(70008,5760,'2012-09-10',3002,5001),
(70010,1983.43,'2012-10-10',3004,5006),
(70003,2480.4,'2012-10-10',3009,5003),
(70012,250.45,'2012-06-27',3008,5002),
(70011,75.29,'2012-08-17',3003,5007),
(70013,3045.6 ,'2012-04-25',3002,5001)select * from customerselect * from salesmanselect * from orders/*     1. write a SQL query to find the salesperson and customer 
who reside in the same city. Return Salesman, cust_name and city */ 

select salesman.name,  customer.cust_name, customer.city from
customer join salesman 
on customer.city =salesman.city

/*     2. write a SQL query to find those orders where the order 
amount exists between 500 and 2000. 
Return ord_no, purch_amt, cust_name, city  */

select  orders.ord_no, orders.purch_amt, customer.cust_name , customer.city
from orders, customer where orders.customer_id = customer.customer_id and purch_amt between 500 and 2000

/* select   orders.ord_no, orders.purch_amt, customer.cust_name , customer.city
from orders join customer 
ON orders.purch_amt>500 and orders.purch_amt<2000 */


/*   3. write a SQL query to find the salesperson(s) and the 
customer(s) he represents.
Return Customer Name, city, Salesman, commission */

select customer.cust_name, customer.city, salesman.name, salesman.commission
from customer join salesman
on customer.salesman_id=salesman.salesman_id


/*   4. write a SQL query to find salespeople who received commissions
of more than 12 percent from the company. 
Return Customer Name, customer city, Salesman, commission  */

select customer.cust_name, customer.city, salesman.name, salesman.commission
from customer join salesman on customer.salesman_id= salesman.salesman_id
where salesman.commission>0.12

/*  5. write a SQL query to locate those salespeople who do not live 
in the same city where their customers live and have received a 
commission of more than 12% from the company. 
Return Customer Name, customer city, Salesman, salesman city,commission */

select customer.cust_name, customer.city, salesman.name, salesman.commission
from customer join salesman on customer.salesman_id= salesman.salesman_id
where salesman.commission>0.12 and salesman.city != customer.city



/*   6. write a SQL query to find the details of an order. Return 
ord_no,ord_date, purch_amt,Customer Name, grade, Salesman,commission */

select orders.ord_no, orders.ord_date, orders.purch_amt, customer.cust_name,
customer.grade, salesman.name, salesman.commission
from orders inner join customer
on orders.customer_id=customer.customer_id
join salesman on
customer.salesman_id =salesman.salesman_id


/*   7. Write a SQL statement to join the tables salesman, customer and orders 
so that the same column of each table appears once and only the relational 
rows are returned. */

select *
from orders join customer
on orders.customer_id=customer.customer_id
join salesman on
customer.salesman_id =salesman.salesman_id


/*   8. write a SQL query to display the customername, customer city, grade,
salesman,salesman city.The results should be sorted byascending customer_id.*/

SELECT customer.cust_name,customer.city,customer.grade, 
salesman.name AS "Salesman",salesman.city 
FROM customer  
LEFT JOIN salesman  
ON customer.salesman_id=salesman.salesman_id 
order by customer.customer_id;


/*  9. write a SQL query to find those customers with a grade less than 300.Return
cust_name, customer city, grade, Salesman, salesmancity. The result should be
ordered by ascending customer_id. */

SELECT customer.cust_name,customer.city,customer.grade, 
salesman.name AS "Salesman",salesman.city 
FROM customer  
LEFT JOIN salesman  
ON customer.salesman_id=salesman.salesman_id 
where  grade<300
order by customer.customer_id ;


/*  10. Write a SQL statement to make a report with customer name, city, 
order number,order date, and order amount in ascending order according to the
order date to determine whether any of the existing customers have placed an order or not*/

select customer.cust_name,customer.city, orders.ord_no, orders.ord_date, orders.purch_amt
from customer left join orders
on customer.customer_id=orders.customer_id
order by ord_date

/*   11. Write a SQL statement to generate a report with customer name, city,
order number,order date, order amount, salesperson name, and commission to 
determine if any ofthe existing customers have not placed orders or if they
have placed orders throughtheir salesman or by themselves*/

select  orders.ord_no, orders.ord_date, orders.purch_amt,
salesman.name, salesman.commission
from orders  left join salesman
on orders.salesman_id= salesman.salesman_id

customer.cust_name,customer.city

/*   12. Write a SQL statement to generate a list in ascending order of 
salespersons who work either for one or more customers or have not yet 
joined any of the customers */

SELECT b.name AS "Salesman" 
FROM customer a 
RIGHT OUTER JOIN salesman b 
ON b.salesman_id=a.salesman_id 
ORDER BY b.salesman_id desc

/* 13. write a SQL query to list all salespersons along with customer name, 
city, grade,order number, date, and amount. */

select salesman.name,customer.cust_name, customer.city, orders.ord_no, orders.ord_date, orders.purch_amt
from customer right join salesman  
on customer.salesman_id = salesman.salesman_id
right join orders
on customer.customer_id = orders.customer_id


/*  14. Write a SQL statement to make a list for the salesmen who either work for one or
more customers or yet to join any of the customers. The customer may have placed,
either one or more orders on or above order amount 2000 and must have a grade, or
he may not have placed any order to the associated supplier.*/



select customer.cust_name,customer.city,customer.grade, 
salesman.name AS "Salesman", 
orders.ord_no, orders.ord_date, orders.purch_amt  from orders
inner join customer
on orders.customer_id = customer.customer_id
inner join salesman
on orders.salesman_id = salesman.salesman_id
where orders.purch_amt > 2000


/*  15. Write a SQL statement to make a list for the salesmen who either work for one or
more customers or yet to join any of the customers. The customer may have placed,
either one or more orders on or above order amount 2000 and must have a grade, or
he may not have placed any order to the associated supplier.*/

SELECT a.cust_name,a.city,a.grade, 
b.name AS "Salesman", 
c.ord_no, c.ord_date, c.purch_amt 
FROM customer a 
RIGHT OUTER JOIN salesman b 
ON b.salesman_id=a.salesman_id 
LEFT OUTER JOIN orders c 
ON c.customer_id=a.customer_id 
WHERE c.purch_amt>=2000 
AND a.grade IS NOT NULL;


/*   16. Write a SQL statement to generate a report with the customer name, city, order no.
order date, purchase amount for only those customers on the list who must have a
grade and placed one or more orders or which order(s) have been placed by the
customer who neither is on the list nor has a grade.*/

SELECT customer.cust_name, customer.city, orders.ord_no,
orders.ord_date,orders.purch_amt AS "Order Amount" 
FROM customer
FULL OUTER JOIN orders  
ON customer.customer_id=orders.customer_id 
WHERE customer.grade IS NOT NULL


/*  17. Write a SQL query to combine each row of the salesman table with each row of the
customer table */

select * from
salesman cross join customer

/*  18. Write a SQL statement to create a Cartesian product between salesperson and
customer, i.e. each salesperson will appear for all customers and vice versa for that
salesperson who belongs to that city  */

select * from
salesman cross join customer 

/*   19. Write a SQL statement to create a Cartesian product between salesperson and
customer, i.e. each salesperson will appear for every customer and vice versa for
those salesmen who belong to a city and customers who require a grade  */

SELECT * 
FROM salesman  
CROSS JOIN  customer  
WHERE salesman.city IS NOT NULL 
AND customer.grade IS NOT NULL;

/* 20. Write a SQL statement to make a Cartesian product between salesman and
customer i.e. each salesman will appear for all customers and vice versa for those
salesmen who must belong to a city which is not the same as his customer and the
customers should have their own grade */SELECT * 
FROM salesman 
CROSS JOIN customer  
WHERE salesman.city IS NOT NULL 
AND customer.grade IS NOT NULL 
AND  salesman.city<>customer.city;









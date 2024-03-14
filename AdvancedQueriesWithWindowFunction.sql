
-- Create a customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    customer_email VARCHAR(100)
);

-- Insert some sample data with duplicates
INSERT INTO customers VALUES
(1, 'John', 'john@gmail.com'),
(2, 'Alice', 'alice@gmail.com'),
(3, 'Bob', 'bob@gmail.com'),
(4, 'Eve', 'eve@gmail.com'),
(5, 'Eve', 'eve@gmail.com'),
(6, 'Michael', 'michael@yahoo.com'),
(7, 'Sarah', 'sarah@hotmail.com'),
(8, 'John', 'john@gmail.com');

-- 01-- Fetch all the duplicate records in a table.
WITH CustomerList AS(
SELECT *,
    ROW_NUMBER() OVER (PARTITION BY customer_name ORDER BY customer_id) AS rn
    FROM customers c
)
SELECT customer_id, customer_name, customer_email
FROM CustomerList CL
WHERE CL.rn <> 1

-- 02 Fetch the second last record from customer table.

WITH CustomerList AS(
SELECT *,
    ROW_NUMBER() OVER (ORDER BY customer_id DESC) AS rn
    FROM customers c
)
SELECT customer_id, customer_name, customer_email
FROM CustomerList CL
WHERE CL.rn = 2 
-----------------------------------------------------------------------------------------------------

--Create a empluyees table

create table employees
( emp_id int primary key
, emp_name varchar(50) not null
, department varchar(50)
, monthly_salary int);

insert into employees values(201, 'Alice', 'Marketing', 4200);
insert into employees values(202, 'Bob', 'Finance', 3200);
insert into employees values(203, 'Charlie', 'IT', 4100);
insert into employees values(204, 'David', 'HR', 6700);
insert into employees values(205, 'Emma', 'Marketing', 3200);
insert into employees values(206, 'Frank', 'Finance', 5200);
insert into employees values(207, 'Grace', 'IT', 7500);
insert into employees values(208, 'Henry', 'HR', 3000);
insert into employees values(209, 'Isabella', 'Marketing', 4800);
insert into employees values(210, 'Jack', 'Finance', 7100);
insert into employees values(211, 'Katie', 'IT', 9200);
insert into employees values(212, 'Leo', 'HR', 1500);
insert into employees values(213, 'Mia', 'Marketing', 2300);
insert into employees values(214, 'Noah', 'Finance', 4200);
insert into employees values(215, 'Olivia', 'IT', 5500);
insert into employees values(216, 'Peter', 'HR', 6800);
insert into employees values(217, 'Quinn', 'Marketing', 3200);
insert into employees values(218, 'Ryan', 'Finance', 5300);
insert into employees values(219, 'Sophia', 'IT', 6300);
insert into employees values(220, 'Thomas', 'HR', 3800);
insert into employees values(221, 'Uma', 'Marketing', 4700);
insert into employees values(222, 'Vincent', 'Finance', 6200);
insert into employees values(223, 'Wendy', 'IT', 7300);
insert into employees values(224, 'Xavier', 'HR', 4100);
insert into employees values(225, 'Yara', 'Marketing', 3800);
insert into employees values(226, 'Zane', 'Finance', 5200);
insert into employees values(227, 'Alice', 'HR', 6700);
insert into employees values(228, 'Bob', 'Marketing', 3200);
insert into employees values(229, 'Charlie', 'Finance', 4200);
insert into employees values(230, 'David', 'IT', 6100);
insert into employees values(231, 'Emma', 'HR', 5400);
insert into employees values(232, 'Frank', 'Marketing', 3700);
insert into employees values(233, 'Grace', 'Finance', 5200);
insert into employees values(234, 'Henry', 'IT', 4400);
insert into employees values(235, 'Isabella', 'HR', 7800);
insert into employees values(236, 'Jack', 'Marketing', 4200);
insert into employees values(237, 'Katie', 'Finance', 5900);
insert into employees values(238, 'Leo', 'IT', 7100);
insert into employees values(239, 'Mia', 'HR', 3200);
insert into employees values(240, 'Noah', 'Marketing', 4300);
insert into employees values(241, 'Olivia', 'Finance', 5400);
insert into employees values(242, 'Peter', 'IT', 6700);
insert into employees values(243, 'Quinn', 'HR', 4200);
insert into employees values(244, 'Ryan', 'Marketing', 5100);
insert into employees values(245, 'Sophia', 'Finance', 6400);
insert into employees values(246, 'Thomas', 'IT', 7700);
insert into employees values(247, 'Uma', 'HR', 5200);
insert into employees values(248, 'Vincent', 'Marketing', 4500);
insert into employees values(249, 'Wendy', 'Finance', 5600);
insert into employees values(250, 'Xavier', 'IT', 6900);
insert into employees values(251, 'Yara', 'HR', 4800);
insert into employees values(252, 'Zane', 'Marketing', 4700);

--03  display only the details of employees who either earn the highest salary or the lowest salary in each department from the employees table.

WITH EmployeeList AS (
SELECT *, max(monthly_salary) over (partition by department) as max_salary,
min(monthly_salary) over (partition by department) as min_salary
FROM employees E
)
SELECT EL.emp_id, EL.emp_name, EL.department,EL.monthly_salary
FROM EmployeeList EL
WHERE EL.monthly_salary = EL.max_salary 
OR EL.monthly_salary = EL.min_salary 
-----------------------------------------------------------------------------------------------------------------
-- Create a login_details table

create table custom_login_details(
login_id int primary key,
user_name varchar(50) not null,
login_date date);

delete from custom_login_details;
insert into custom_login_details values
(101, 'John', DATEADD(DAY, 0, GETDATE())),
(102, 'David', DATEADD(DAY, 0, GETDATE())),
(103, 'Emma', DATEADD(DAY, 1, GETDATE())),
(104, 'Emma', DATEADD(DAY, 1, GETDATE())),
(105, 'Emma', DATEADD(DAY, 1, GETDATE())),
(106, 'John', DATEADD(DAY, 2, GETDATE())),
(107, 'John', DATEADD(DAY, 2, GETDATE())),
(108, 'Emma', DATEADD(DAY, 3, GETDATE())),
(109, 'Emma', DATEADD(DAY, 3, GETDATE())),
(110, 'David', DATEADD(DAY, 4, GETDATE())),
(111, 'David', DATEADD(DAY, 4, GETDATE())),
(112, 'David', DATEADD(DAY, 5, GETDATE())),
(113, 'David', DATEADD(DAY, 6, GETDATE())),
(114, 'Emma', DATEADD(DAY, 7, GETDATE())),
(115, 'Emma', DATEADD(DAY, 7, GETDATE())),
(116, 'Emma', DATEADD(DAY, 7, GETDATE())),
(117, 'John', DATEADD(DAY, 8, GETDATE())),
(118, 'John', DATEADD(DAY, 8, GETDATE())),
(119, 'David', DATEADD(DAY, 9, GETDATE())),
(120, 'David', DATEADD(DAY, 9, GETDATE())),
(121, 'David', DATEADD(DAY, 9, GETDATE())),
(122, 'Emma', DATEADD(DAY, 10, GETDATE())),
(123, 'Emma', DATEADD(DAY, 10, GETDATE())),
(124, 'Emma', DATEADD(DAY, 10, GETDATE())),
(125, 'John', DATEADD(DAY, 11, GETDATE())),
(126, 'John', DATEADD(DAY, 11, GETDATE())),
(127, 'David', DATEADD(DAY, 12, GETDATE())),
(128, 'David', DATEADD(DAY, 12, GETDATE())),
(129, 'David', DATEADD(DAY, 12, GETDATE())),
(130, 'Emma', DATEADD(DAY, 13, GETDATE())),
(131, 'Emma', DATEADD(DAY, 13, GETDATE())),
(132, 'Emma', DATEADD(DAY, 13, GETDATE())),
(133, 'John', DATEADD(DAY, 14, GETDATE())),
(134, 'John', DATEADD(DAY, 14, GETDATE())),
(135, 'David', DATEADD(DAY, 15, GETDATE())),
(136, 'David', DATEADD(DAY, 15, GETDATE())),
(137, 'David', DATEADD(DAY, 15, GETDATE())),
(138, 'Emma', DATEADD(DAY, 16, GETDATE())),
(139, 'Emma', DATEADD(DAY, 16, GETDATE())),
(140, 'Emma', DATEADD(DAY, 16, GETDATE()));


-- --04-Query to fetch users who logged in consecutively 3 or more times

-- subquery solution
select distinct repeated_names
from (
    select *,
    case 
        when user_name = lead(user_name) over(order by login_id)
        and  user_name = lead(user_name,2) over(order by login_id)
        then user_name 
        else null 
    end as repeated_names
    from custom_login_details
) x
where x.repeated_names is not null;

-CTE solution
WITH LoginList AS (
 select *,
    case 
        when user_name = lead(user_name) over(order by login_id)
        and  user_name = lead(user_name,2) over(order by login_id)
        then user_name 
        else null 
    end as repeated_names
    from custom_login_details
)
SELECT DISTINCT LL.repeated_names
FROM LoginList LL
WHERE LL.repeated_names IS NOT NULL
---------------------------------------------------------------------------------------------------------

-- Students Table 

create table modified_students
(
id int primary key,
student_name varchar(50) not null
);
insert into modified_students values
(1, 'John'),
(2, 'Matthew'),
(3, 'Alexander'),
(4, 'William'),
(5, 'Henry'),
(6, 'Oliver'),
(7, 'Jacob');

-- interchange the adjacent student names.If there are no adjacent student then kepp the student name the same.

SELECT id, student_name,
CASE 
WHEN id%2 <> 0 THEN LEAD(student_name,1,student_name) OVER(ORDER BY id)
WHEN id%2 = 0 then lag(student_name) over(order by id) END
AS new_student_name
FROM modified_students;
----------------------------------------------------------------

create table weather
(
id int,
city varchar(50),
temperature int,
day date
);
delete from weather;
insert into weather values
(1, 'Manchester', -1, ('2021-01-01')),
(2, 'Manchester', -2, ('2021-01-02')),
(3, 'Manchester', 4, ('2021-01-03')),
(4, 'Manchester', 1, ('2021-01-04')),
(5, 'Manchester', -2, ('2021-01-05')),
(6, 'Manchester', -5, ('2021-01-06')),
(7, 'Manchester', -7, ('2021-01-07')),
(8, 'Manchester', 5, ('2021-01-08')),
(9, 'Glasgow', -3, ('2021-01-01')),
(10, 'Glasgow', -4, ('2021-01-02')),
(11, 'Glasgow', -5, ('2021-01-03')),
(12, 'Glasgow', -2, ('2021-01-04')),
(13, 'Glasgow', -3, ('2021-01-05')),
(14, 'Glasgow', -6, ('2021-01-06')),
(15, 'Glasgow', 1, ('2021-01-07')),
(16, 'Glasgow', -4, ('2021-01-08'));


---fetch all the records when London had extremely cold temperature for 3 consecutive days or more

WITH FlaggedList AS (
 SELECT *,
        CASE WHEN temperature < 0
              and lead(temperature) OVER(ORDER BY city, day) < 0
              and lead(temperature,2) OVER(ORDER BY city,day) < 0
			  and lead(city) OVER(ORDER BY city, day) = city
        THEN 'Y'
        WHEN temperature < 0
              and lead(temperature) OVER(ORDER BY city,day) < 0
              and lag(temperature) OVER(ORDER BY city,day) < 0
			  and lead(city) OVER(ORDER BY city, day)= city
			  and lag(city) OVER(ORDER BY city, day)= city
        THEN 'Y'
        WHEN temperature < 0
              and lag(temperature) OVER(ORDER BY city,day) < 0
              and lag(temperature,2) OVER(ORDER BY city,day) < 0
			  and lag(city) OVER(ORDER BY city, day) = city
			  and lag(city,2) OVER(ORDER BY city, day) = city
        THEN 'Y'
        END AS flag
    FROM weather
)
SELECT id, city, temperature, day
FROM FlaggedList 
where flag = 'Y'







create table employee
( emp_ID int primary key
, emp_NAME varchar(50) not null
, department varchar(50)
, monthly_salary int)

insert into employee values(101, 'John', 'Administration', 4000);
insert into employee values(102, 'Alice', 'Human Resources', 3000);
insert into employee values(103, 'Emily', 'Information Technology', 4000);
insert into employee values(104, 'David', 'Finance', 6500);
insert into employee values(105, 'Michael', 'Human Resources', 3000);
insert into employee values(106, 'Emma',  'Finance', 5000);
insert into employee values(107, 'Sophia', 'Human Resources', 7000);
insert into employee values(108, 'Daniel', 'Administration', 4000);
insert into employee values(109, 'Olivia', 'Information Technology', 6500);
insert into employee values(110, 'William', 'Information Technology', 7000);
insert into employee values(111, 'Isabella', 'Information Technology', 8000);
insert into employee values(112, 'James', 'Information Technology', 10000);
insert into employee values(113, 'Mia', 'Administration', 2000);
insert into employee values(114, 'Ethan', 'Human Resources', 3000);
insert into employee values(115, 'Charlotte', 'Information Technology', 4500);
insert into employee values(116, 'Alexander', 'Finance', 6500);
insert into employee values(117, 'Ava', 'Human Resources', 3500);
insert into employee values(118, 'Benjamin', 'Finance', 5500);
insert into employee values(119, 'Amelia', 'Human Resources', 8000);
insert into employee values(120, 'Lucas', 'Administration', 5000);
insert into employee values(121, 'Harper', 'Information Technology', 6000);
insert into employee values(122, 'Mason', 'Information Technology', 8000);
insert into employee values(123, 'Evelyn', 'Information Technology', 8000);
insert into employee values(124, 'Elijah', 'Information Technology', 11000);

select * from employee;

select emp_id, emp_name, dept_name, salary
from (
select *,
row_number() over (order by emp_id desc) as rn
from employee e) x
where x.rn = 2;
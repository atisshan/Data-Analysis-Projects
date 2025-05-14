-- CREATE DATABASE Company_data;
-- CREATE TABLE Employee_demographics(
-- EmployeeID int,
-- First_name varchar(255),
-- Last_name varchar(255),
-- Age int,
-- Gender varchar(20)
-- );

CREATE TABLE Employee_salary(
EmployeeID int,
JobTitle varchar(255),
Salary int);



-- INSERT INTO employee_demographics VALUES
-- (1001, "John", 'Doe', 25, 'Male'),
-- (1002, "Mary", 'Joe', 35, 'Female'),
-- (1003, "James", 'Shnippe', 28, 'Male'),
-- (1004, "Hennah", 'Dennis', 23, 'Female'),
-- (1005, "Shaleen", 'Atieno', 25, 'Female'),
-- (1006, "Hamisi", 'Hamadi', 38, 'Female'),
-- (1007, "June", 'Khalid', 20, 'Male'),
-- (1008, "Juana", 'Ale', 40, 'Male')




-- INSERT INTO employee_salary VALUES
-- (1001, 'salesman', 200000),
-- (1002, 'Project manager', 450000),
-- (1003, 'Web Developer', 550000),
-- (1004, 'UI/UX', 400000),
-- (1005, 'Data Analyst', 500000),
-- (1006, 'Communication Specialist', 100000),
-- (1007, 'Manager', 120000),
-- (1008, 'Receptionist', 80000)




SELECT * FROM employee_demographics;
SELECT COUNT(Last_name) as Last_name_count FROM employee_demographics;
SELECT * FROM employee_salary;
SELECT MIN(Salary) FROM employee_salary;
SELECT *, AVG(Salary) AS Average_Saalary FROM employee_salary;

SELECT * FROM employee_salary 
WHERE JobTitle <> 'salesman';


SELECT * FROM employee_salary
WHERE Salary > 100000;

SELECT * FROM employee_demographics
where Age >= 25 OR Gender LIKE "%Female";

SELECT * FROM employee_demographics
WHERE First_name LIKE "s%";

SELECT * FROM employee_demographics
WHERE First_name IN("John", "Mary", "James");  -- including mutliples


SELECT Gender, COUNT(Gender) FROM employee_demographics
group by Gender
ORDER BY Gender asc;

SELECT Gender, Age FROM employee_demographics
group by 1, 2
order by  2 asc;


SELECT * FROM employee_demographics as employee_demo
join employee_salary as employee_sal WHERE 
employee_demo.EmployeeID=employee_sal.EmployeeID;



-- INSERT INTO employee_salary
-- VALUES
-- (1009, "clerk", 75000),
-- (1010, "Bussiness associate", 100000);



with cTE_Example as
(select First_name,JobTitle,Salary from employee_demographics 
inner join employee_salary
ON employee_demographics.EmployeeID=employee_salary.EmployeeID
group by First_name,JobTitle,Salary)

select * from cTE_Example;

with CTE_example3 as
(
select avg(Salary) as Average_Salary from employee_salary)
select * from CTE_example3;


select First_name,JobTitle,Salary, 
CASE
WHEN JobTitle = "Project Manager" THEN Salary + (Salary * .05)
ELSE Salary + (Salary *.03)
END as New_Salary
from employee_demographics 
inner join employee_salary
ON employee_demographics.EmployeeID=employee_salary.EmployeeID
group by First_name,JobTitle,Salary
order by first_name;


select First_name, JobTitle, Gender,count(Gender) 
over (partition by Gender)
 from employee_demographics dem 
join employee_salary sal on 
	dem.EmployeeID=sal.EmployeeID;
    
    
    
select Gender, count(Gender) from employee_demographics
group by Gender;

select Gender, count(Gender)
OVER (PARTITION BY Gender) from employee_demographics;


CREATE TEMPORARY TABLE employee_table(
EmployeeID int, 
JobTitle varchar(255),
 Salary int);

insert into employee_table
select * from employee_salary;

select * from employee_table;



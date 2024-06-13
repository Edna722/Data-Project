-- create table employee_table(
-- 	 first_name varchar(30)
-- 	,last_name varchar(40)
-- 	,email varchar(70)
-- 	,phone_number varchar(20)
-- 	,hire_date date
-- 	,job_ varchar(40)
-- 	,salary varchar(10)
-- 	,commission_percent decimal(7,2)
-- 	,manager varchar(25)
-- 	,department varchar(30)
-- )

-- drop table employee_table

select * from employee_table

--return employee with maximum salary 
select * from employee_table
where salary = (select Max(salary) from employee_table)

--select highest salary in employee table
select Max (salary) from employee_table

--select 2nd highest salary 
select Max(salary) from employee_table
where salary not in (select Max(salary) from employee_table)

--select range of employees based on id 
-- select * from employee_table where employee_id between  and 

--return employee name, highest salary and department 
select first_name, last_name, salary, email,department 
from employee_table 
where salary IN (select Max(salary) from employee_table)
-- return highest salary , employee name, department name for each 
select first_name, last_name, department, salary
from employee_table
where salary in (select Max(salary) from employee_table group by department)
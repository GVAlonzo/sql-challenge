----------------------------------------------------------------
--  SQL Homework - Employee Database: A Mystery in Two Parts
--
--       Author: George Alonzo
--     Due Date: October 30, 2021
--
----------------------------------------------------------------

-- STEP 1: Tables created via QuickDBD-export.sql
-- STEP 2: Data imported via Import feature in this order:
--             1. titles
--             2. employees
--             3. salaries
--             4. departments
--             5. dept_manager
--             6. dept_emp

----------------------------------------------------------------


----------------------------------------------------------------
-- Validate data imports
----------------------------------------------------------------
select count(*) 
from titles;
-- 7

select count(*)
from employees;
-- -> 300,024

select count (*)
from salaries;
-- -> 300,024

select count(*)
from departments;
-- -> 9

select count(*)
from dept_manager;
-- -> 24

select count(*)
from dept_emp;
-- -> 331,603

----------------------------------------------------------------
-- Preview data in tables
----------------------------------------------------------------
select *
from titles
limit 10;

select *
from employees
limit 10;

select *
from salaries
limit 10;

select *
from departments
limit 10;

select *
from dept_manager
limit 10;

select *
from dept_emp
limit 10;

----------------------------------------------------------------
-- DATA ANALYSIS
----------------------------------------------------------------

-- 1 List the following details of each employee: 
--		employee number, last name, first name, sex, and salary.
select e.emp_no, last_name, first_name, sex, salary
from employees e, salaries s
where e.emp_no = s.emp_no
order by 2,3,1;

-- 2 List first name, last name, and hire date for 
-- 		employees who were hired in 1986.
-- NOTE: BETWEEN IS INCLUSIVE!
select first_name, last_name, hire_date
from employees
where hire_date between '1986-01-01' and '1986-12-31';


-- 3 List the manager of each department with the following 
--		information: department number, department name, 
--		the manager's employee number, last name, first name.



-- 4 List the department of each employee with the following 
--		information: employee number, last name, first name, and department name.



-- 5 List first name, last name, and sex for employees whose 
--		first name is "Hercules" and last names begin with "B."
select first_name, last_name, sex
from employees
where first_name = 'Hercules' and last_name like 'B%'


-- 6 List all employees in the Sales department, including 
--		their employee number, last name, first name, and department name.



-- 7 List all employees in the Sales and Development departments, 
--		including their employee number, last name, first name, and department name.



-- 8 In descending order, list the frequency count of employee 
--		last names, i.e., how many employees share each last name.
select last_name, count(*) as CountofLast
from employees
group by 1
order by 2 desc;


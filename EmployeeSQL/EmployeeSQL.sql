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
-- Validate data imports
----------------------------------------------------------------
select count(*) 
from titles;
-- -> 7

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
-- PRE-DATA ANALYSIS
----------------------------------------------------------------
select * from salaries
order by salary;

-- \/ Minimum salary is 40000, confirming no 0 or blanks.
select min(salary)
from salaries;

-- \/ Verifies there are no NULL salaries
select * from salaries
where salary is null;

----------------------------------------------------------------
-- DATA ANALYSIS
----------------------------------------------------------------

-- 1 List the following details of each employee: 
--		employee number, last name, first name, sex, and salary.

-- \/ THIS RETURNS 300024 ROWS (SAME # OF ROWS IN EMPLOYEES TABLE)
select e.emp_no, last_name, first_name, sex, salary
from employees e, salaries s
where e.emp_no = s.emp_no
order by 2,3,1;

-- Alternate version of above with INNER JOIN
-- \/ THIS RETURNS 300024 ROWS (SAME # OF ROWS IN EMPLOYEES TABLE)
select e.emp_no, last_name, first_name, sex, salary
from employees e
inner join salaries s
on e.emp_no = s.emp_no
order by last_name,first_name,e.emp_no;

----------------------------------------------------------------

-- 2 List first name, last name, and hire date for 
-- 		employees who were hired in 1986.

-- NOTE: BETWEEN IS INCLUSIVE!
-- \/ THIS RETURNS 36150 ROWS
select first_name, last_name, hire_date
from employees
where hire_date between '1986-01-01' and '1986-12-31';

----------------------------------------------------------------

-- 3 List the manager of each department with the following 
--		information: department number, department name, 
--		the manager's employee number, last name, first name.

-- \/ THIS RETURNS 24 ROWS (SAME # OF ROWS IN THE DEPT_MANAGER TABLE)
select d.dept_no, dept_name, dm.emp_no, last_name, first_name
from departments d, dept_manager dm, employees e
where d.dept_no = dm.dept_no
and dm.emp_no = e.emp_no;

-- Alternate version of above with INNER JOIN
-- \/ THIS RETURNS 24 ROWS (SAME # OF ROWS IN THE DEPT_MANAGER TABLE)
select d.dept_no, dept_name, dm.emp_no, last_name, first_name
from departments d
inner join dept_manager dm
on d.dept_no = dm.dept_no
inner join employees e
on dm.emp_no = e.emp_no;

----------------------------------------------------------------

-- 4 List the department of each employee with the following 
--		information: employee number, last name, first name, and department name.

-- \/ THIS RETURNS 331603 ROWS (SAME # OF ROWS IN THE DEPT_EMP TABLE)
-- NOTE: Employees can belong to more than one department
select e.emp_no, last_name, first_name, dept_name
from employees e, dept_emp de, departments d
where e.emp_no = de.emp_no
and de.dept_no = d.dept_no;

-- Alternate version of above with INNER JOIN
-- \/ THIS RETURNS 331603 ROWS (SAME # OF ROWS IN THE DEPT_EMP TABLE)
-- NOTE: Employees can belong to more than one department
select e.emp_no, last_name, first_name, dept_name
from employees e
inner join dept_emp de
on e.emp_no = de.emp_no
inner join departments d
on de.dept_no = d.dept_no;


-- 5 List first name, last name, and sex for employees whose 
--		first name is "Hercules" and last names begin with "B."

-- \/ THIS RETURNS 20 ROWS
select first_name, last_name, sex
from employees
where first_name = 'Hercules' and last_name like 'B%';


-- 6 List all employees in the Sales department, including 
--		their employee number, last name, first name, and department name.

-- \/ THIS RETURNS 52245 ROWS, NO DIFFERENCE BETWEEN INNER & RIGHT JOINS
select e.emp_no, last_name, first_name, dept_name
from employees e
inner join dept_emp de
on e.emp_no = de.emp_no
inner join departments d
on de.dept_no = d.dept_no
where dept_name = 'Sales';


-- 7 List all employees in the Sales and Development departments, 
--		including their employee number, last name, first name, and department name.

-- \/ THIS RETURNS 137952 ROWS, NO DIFFERENCE BETWEEN INNER & RIGHT JOINS
select e.emp_no, last_name, first_name, dept_name
from employees e
inner join dept_emp de
on e.emp_no = de.emp_no
inner join departments d
on de.dept_no = d.dept_no
where dept_name in ('Sales','Development');


-- 8 In descending order, list the frequency count of employee 
--		last names, i.e., how many employees share each last name.

-- \/ THIS RETURNS 1638 ROWS
select last_name, count(last_name) as CountOfLastName
from employees
group by 1
order by 2 desc;

-- LOOKS LIKE ONLY ONE DISTINCT LAST NAME - "Foolsday"
select last_name, count(last_name) as CountOfLastName
from employees
group by 1
having Count(last_name) = 1;


----------------------------------------------------------------
-- Below is testing SQL prior to using for Bonus w/ Pandas
----------------------------------------------------------------
select title, round(avg(salary),2) as AvgSalary
from titles t
inner join employees e
on t.title_id = e.emp_title_id
inner join salaries s
on e.emp_no = s.emp_no
group by title;

SELECT TITLE, ROUND(AVG(SALARY),2) AS AVGSALARY FROM TITLES T INNER JOIN EMPLOYEES E ON T.TITLE_ID = E.EMP_TITLE_ID INNER JOIN SALARIES S ON E.EMP_NO = S.EMP_NO GROUP BY TITLE;


----------------------------------------------------------------
-- Epilogue
----------------------------------------------------------------
select * from employees
where emp_no = 499942;

-- HA HA!!

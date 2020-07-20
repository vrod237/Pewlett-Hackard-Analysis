-- Creating tables for PH-EmployeeDB
--CREATE TABLE departments (
     --dept_no VARCHAR(4) NOT NULL,
     --dept_name VARCHAR(40) NOT NULL,
     --PRIMARY KEY (dept_no),
     --UNIQUE (dept_name));

--DROP TABLE employees;
--
--CREATE TABLE employees (
	--emp_no VARCHAR(6) NOT NULL,
     --birth_date DATE NOT NULL,
     --first_name VARCHAR NOT NULL,
     --last_name VARCHAR NOT NULL,
     --gender VARCHAR NOT NULL,
     --hire_date DATE NOT NULL,
     --PRIMARY KEY (emp_no));

--DROP TABLE dept_manager;
--
--CREATE TABLE dept_manager (
--dept_no VARCHAR(4) NOT NULL,
	--emp_no VARCHAR(6) NOT NULL,
	--from_date DATE NOT NULL,
	--to_date DATE NOT NULL,
--FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
--FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	--PRIMARY KEY (emp_no, dept_no));

--DROP TABLE salaries;
--
--CREATE TABLE salaries (
  --emp_no VARCHAR(6) NOT NULL,
  --salary INT NOT NULL,
  --from_date DATE NOT NULL,
  --to_date DATE NOT NULL,
  --FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  --PRIMARY KEY (emp_no));

--DROP TABLE titles;
--
--CREATE TABLE titles (
	--emp_no VARCHAR(6) NOT NULL,
	--title VARCHAR NOT NULL,
	--from_date DATE NOT NULL,
  	--to_date DATE NOT NULL,
	--FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  	--PRIMARY KEY (emp_no, title, from_date));

--CREATE TABLE deptEmp (
	--emp_no VARCHAR(6) NOT NULL,
	--dept_no VARCHAR(4) NOT NULL,
	--from_date DATE NOT NULL,
  	--to_date DATE NOT NULL,
	--FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	--FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	--PRIMARY KEY (emp_no, dept_no));

--SELECT * FROM departments;
--SELECT * FROM employees;
--SELECT * FROM dept_manager;
--SELECT * FROM salaries;
--SELECT * FROM titles;
--SELECT * FROM deptEmp;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create new table
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
retirement_info.last_name,
	deptemp.to_date
FROM retirement_info
LEFT JOIN deptemp
ON retirement_info.emp_no = deptemp.emp_no;

SELECT ri.emp_no,
	ri.first_name,
ri.last_name,
	de.to_date 
FROM retirement_info as ri
LEFT JOIN deptemp as de
ON ri.emp_no = de.emp_no;

SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;
	 
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN deptemp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO employee_count_dept
FROM current_emp as ce
LEFT JOIN deptemp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT emp_no,
	first_name,
last_name,
	gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM emp_info;

SELECT e.emp_no,
	e.first_name,
e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN deptemp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	      AND (de.to_date = '9999-01-01');
		  
SELECT * FROM emp_info;

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
		
-- Department Retirees
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name	
INTO dept_info
FROM current_emp as ce
INNER JOIN deptemp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

SELECT * FROM employees;
SELECT * FROM titles;

SELECT * FROM dept_info;

SELECT emp_no, first_name, last_name, dept_name
--INTO retirement_DevSales_info
FROM dept_info
WHERE (dept_name IN ('Sales', 'Development'));


--Challenge Dev 1 - 33,118 total people
SELECT
	e.emp_no,
	e.first_name,
	e.last_name,
	de.to_date
--INTO Emp_Ret
FROM employees as e
	LEFT JOIN deptemp as de
		ON e.emp_no = de.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND(de.to_date = '9999-01-01')
	AND(e.hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--54722 as count including duplicates
SELECT
	rt.emp_no,
	rt.first_name,
	rt.last_name,
	ti.title,
	ti.from_date,
	s.salary
INTO ret_emp_dup
FROM Emp_Ret as rt
INNER JOIN titles as ti
	ON(rt.emp_no = ti.emp_no)
INNER JOIN salaries as s
	ON(ti.emp_no = s.emp_no);

--33,118 total employees retiring after removing duplicates
SELECT emp_no,
first_name,
last_name,
title,
from_date,
salary
INTO total_emp_ret
FROM
 (SELECT emp_no,
first_name,
last_name,
title,
from_date,
salary, ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) rn
 FROM ret_emp_dup
 ) tmp WHERE rn = 1
ORDER BY emp_no;

-- Number of employees with each title
SELECT COUNT(emp_no), title
INTO EmpWithEachTitle
FROM ret_emp_dup
GROUP BY title
ORDER BY title;


--Number of titles retiring
select count(distinct concat(title)) AS NumberOfTitlesRetiring
INTO NumOfTitlesRet
from   ret_emp_dup;



--Challenge 2--
--Emp born between jan 1, 1965 and dec 31, 1965
SELECT 
e.emp_no,
e.first_name,
e.last_name,
ti.title,
de.from_date,
de.to_date
INTO mentor_eli
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
INNER JOIN deptemp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND(de.to_date = '9999-01-01');


SELECT COUNT(emp_no)
FROM mentor_eli;


SELECT emp_no,
first_name,
last_name,
title,
from_date,
to_date
INTO true_mentor_eli
FROM
 (SELECT emp_no,
first_name,
last_name,
title,
from_date,
to_date, ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) rn
 FROM mentor_eli
 ) tmp WHERE rn = 1
ORDER BY emp_no;

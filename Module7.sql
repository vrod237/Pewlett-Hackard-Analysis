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

# Pewlett-Hackard-Analysis

In this analysis, we are going to figure out how many employees per title who will be retiring (phase 1) and indentify the number of employees who are eligible to participate in a mentorship program (phase 2). This information will assist the manager in preparing for the "silver tsunami" as many current employees reach retirement age. Additionally, this analysis will explain how we got to each answer and will go over any potential problems that may arise and how they were resolved.
   
    
I started off phase 1 by doing a left join with the employees and dept_temp tables and pulling everyone born between Jan 1, 1952 and December 31, 1955 as well as those hired between Jan 1, 1985 and December 31st 1988 (this is what we used in the module and we, the class, assumed this was missing from the challege). I then sorted out the dupicates which will be explained below. From the join table I created, I pulled a count of employees with each title. For phase 2, I did an inner join with employees, titles and dept_emp tables and pulled those who were born between Jan 1, 1965 and December 31, 1965. Issues arose in both phase 1 and 2, where there were many duplicates. This is due to employees changing job titles by promotion or moving to a different team. However, this was easily resolved by partitioning the data to show the most recent title per employee. Below is a small portion of the code I used, for phase 1, this code divides each "emp_no" into groups and sorts them by descending order. Row number assigns an integer to every row in the emp_no starting from 1 for each emp_no. Then where "rn = 1" we are pulling each emp_no that is equal to one which is the most recent job title.
- ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
  ORDER BY from_date DESC) rn
  FROM retire_emp_test2
  ) tmp WHERE rn = 1
  ORDER BY emp_no;

    
    
For phase 1, a total of 33,118 employees will be retiring soon. These employees come from a total of 7 different job titles which are: Assistant Engineer, Engineer, Manager, Senior Engineer, Senior Staff, Staff, Technique Leader. For phase 2, a total of 1,549 employees are eligible to participate in the mentorship program. Now that doesn't mean that everyone will participate but it will give a decent sized amount of employees the opportunity to help shape the future of the company by mentoring newhires. A limitation to this analysis can be how the information was entered, there could have been a mistake made by the HR Department when they input some information correctly, such as date of birth, department number/name, etc. A wrong date of birth could have resulted in an additional employee being counted as retiring soon when they could actually have a year or two left to hit that mark.

# Pewlett-Hackard-Analysis

In this analysis, we are going to figure out how many employees per title who will be retiring (phase 1) and indentify the number of employees who are eligible to participate in a mentorship program (phase 2). This information will assist the manager in preparing for the "silver tsunami" as many current employees reach retirement age. Additionally, this analysis will explain how we got to each answer and will go over any potential problems that may arise and how they were resolved.
   
    
    - In your second paragraph, summarize the steps that you took to solve the problem, as well as the challenges that you encountered along the way. This is an excellent spot to provide examples and descriptions of the code that you used.

Issues arose in both phase 1 and 2, where there were many duplicates. This is due to employees changing job titles by promotion or moving to a different team. However, this was easily resolved by partitioning the data to show the most recent title per employee. Below is a small portion of the code I used, for phase 1, this code divides each "emp_no" into groups and sorts them by descending order. Row number assigns an integer to every row in the emp_no starting from 1 for each emp_no. Then where "rn = 1" we are pulling each emp_no that is equal to one which is the most recent job title.
- ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
  ORDER BY from_date DESC) rn
  FROM retire_emp_test2
  ) tmp WHERE rn = 1
  ORDER BY emp_no;

    - In your final paragraph, share the results of your analysis and discuss the data that you’ve generated. Have you identified any limitations to the analysis? What next steps would you recommend?
    
For phase 1, a total of 33,118 employees will be retiring soon. These employees come from a total of 7 different job titles which are: Assistant Engineer, Engineer, Manager, Senior Engineer, Senior Staff, Staff, Technique Leader. For phase 2, a total of 1,549 employees are eligible to participate in the mentorship program.
A limitation to this analysis can be how the information was entered, there could have been a mistake made by the HR Department when they input some information correctly, such as date of birth, department number/name, etc. A wrong date of birth could have resulted in an additional employee being counted as retiring soon when they could actually have a year or two left to hit that mark.

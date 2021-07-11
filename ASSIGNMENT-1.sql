USE hr;

SELECT * from employees;

/* 1.Write a query to display the names (first_name, last_name) using alias name “First Name", "Last Name" */
SELECT first_name as 'FIRST NAME', last_name as 'LAST NAME'
from employees;

/* 2. Write a query to get unique department ID from employee table */
SELECT department_id from employees
GROUP BY department_id;

/* 3. Write a query to get all employee details from the employee table order by first name, descending */
SELECT * from employees
ORDER BY first_name DESC;

/* 4. Write a query to get the names (first_name, last_name), salary, PF of all the employees (PF is calculated as 15% of salary) */
SELECT first_name,
	   last_name,
       salary,
       ROUND((salary*15)/100,2) as PF /* ROUND is used for removing extra trailing zeros */
       
from employees;       

/* 5. Write a query to get the employee ID, names (first_name, last_name), salary in ascending order of salary */
SELECT employee_id,
       first_name,
       last_name,
       concat(first_name,' ',last_name) as NAMES,
       salary
FROM employees
ORDER BY salary; 

/* 6. Write a query to get the total salaries payable to employees */
Select sum(salary) AS 'TOTAL SALARIES PAYABLE'
from employees;      

/* 7. Write a query to get the maximum and minimum salary from employees table */
SELECT max(salary),
       min(salary)
FROM employees;   

/* 8. Write a query to get the average salary and number of employees in the employees table */
SELECT ROUND(AVG(salary),2) AS AVERAGE_SALARY,
       COUNT(employee_id) AS NO_OF_EMPLOYEES
FROM employees;  

/*9. Write a query to get the number of employees working with the company */     
SELECT count(employee_id) AS NO_OF_EMPLOYEES
FROM employees;	

/* 10. Write a query to get the number of jobs available in the employees table */
SELECT job_id AS NO_OF_JOBS_AVAILABLE
FROM employees
GROUP BY job_id;

/* 11. Write a query get all first name from employees table in upper case */
SELECT UPPER(first_name)
FROM employees;

/* 12. Write a query to get the first 3 characters of first name from employees table */
SELECT LEFT(first_name,3)
FROM employees;

/* 13. Write a query to get first name from employees table after removing white spaces from both side */
SELECT TRIM(first_name)
FROM employees;

/* 14. Write a query to get the length of the employee names (first_name, last_name) from employees table */
SELECT concat(first_name,' ',last_name) AS EMPLOYEE_NAME,
        length(concat(first_name,' ',last_name)) AS LENGTH_OF_EMPLOYEE_NAMES
FROM employees;

/* 15. Write a query to check if the first_name fields of the employees table contains numbers */
SELECT *
FROM employees
WHERE first_name LIKE '%123456789';

/* 16. Write a query to display the name (first_name, last_name) and salary for all employees whose salary is
not in the range $10,000 through $15,000 */

SELECT CONCAT(first_name,' ',last_name) AS NAME,
	   salary
FROM employees
WHERE salary NOT BETWEEN 10000 and 15000;

/* 17. Write a query to display the name (first_name, last_name) and department ID of all employees in
departments 30 or 100 in ascending order */
SELECT CONCAT(first_name,' ',last_name) AS NAME,
       department_id
FROM EMPLOYEES
WHERE department_id = 30 or department_id = 100
ORDER BY department_id; 

/* 18. Write a query to display the name (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000 and are in department 30 or 100 */
SELECT CONCAT(first_name,' ',last_name) AS NAME,
          salary,
          department_id
FROM employees          
WHERE (salary NOT BETWEEN 10000 AND 15000) and (department_id = 30 or department_id = 100);

/* 19. Write a query to display the name (first_name, last_name) and hire date for all employees who were hired in 1987 */
SELECT CONCAT(first_name,' ',last_name) AS NAME,
       hire_date     
FROM employees
WHERE YEAR(hire_date) = 1987;       

/* 20. Write a query to display the first_name of all employees who have both "b" and "c" in their first name */
SELECT first_name
FROM employees
WHERE first_name LIKE '%b%' AND first_name LIKE '%c%';

/* 21. Write a query to display the last name, job, and salary for all employees whose job is that of a
Programmer or a Shipping Clerk, and whose salary is not equal to $4,500, $10,000, or $15,000 */

SELECT * FROM employees;
SELECT * FROM jobs;

SELECT e.last_name, e.salary, j.job_title
FROM
    employees as e
    INNER JOIN
    jobs as j ON
    e.job_id = j.job_id
WHERE  
    j.job_title IN ('Programmer','Shipping Clerk')
    AND
    e.salary NOT IN (4500,10000,15000);




/* 22. Write a query to display the last name of employees whose names have exactly 6 characters */
SELECT last_name,CHAR_LENGTH(last_name)
FROM EMPLOYEES
WHERE CHAR_LENGTH(last_name) = 6;

/* 23. Write a query to display the last name of employees having 'e' as the third character */
Select last_name
FROM employees
WHERE last_name like '__e%';

/* 24. Write a query to get the job_id and related employee's id
Partial output of the query :
job_id             EMPLOYEE
AC_ACCOUNT           206
AC_MGR               205
AD_ASST              200
AD_PRES              100
AD_VP                101 ,102
FI_ACCOUNT           110 ,113 ,111 ,109 ,112 */

SELECT job_id,
	   GROUP_CONCAT(employee_id)
FROM employees
GROUP BY job_id;

/* 25. Write a query to update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999' */
SELECT * FROM employees; 
UPDATE employees
SET phone_number = REPLACE(phone_number,'124','999')
WHERE phone_number LIKE '%124%';   

/* 26. Write a query to get the details of the employees where the length of the first name greater than or equal to 8 */
SELECT *
FROM employees
WHERE CHAR_LENGTH(first_name) >= 8;

/* 27. Write a query to append '@example.com' to email field */
SELECT 
      CONCAT(LOWER(email),'@example.com')
FROM 
    employees;      

/* 28. Write a query to extract the last 4 character of phone numbers */
SELECT RIGHT(phone_number,4)
FROM employees;

/* 29. Write a query to get the last word of the street address */
SELECT * FROM locations;

SELECT street_address, SUBSTRING_INDEX(street_address,' ',-1)
FROM locations;



/* 30. Write a query to get the locations that have minimum street length */
SELECT * FROM locations
WHERE LENGTH(street_address) <= (SELECT
        MIN(LENGTH(street_address))
        FROM locations);

/* 31. Write a query to display the first word from those job titles which contains more than one words */        
 
SELECT * FROM jobs;
SELECT job_title,
       REVERSE(SUBSTRING_INDEX(REVERSE(job_title),' ',1)) first_word
FROM jobs;       
  
/* 32. Write a query to display the length of first name for employees where last name contain character 'c' after 2nd position */
SELECT * FROM employees;

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '__c%';

/* 33. Write a query that displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the
employees' first names */
SELECT first_name, LENGTH(first_name) AS LENGTH
FROM employees
WHERE first_name REGEXP '^[AJM]'
ORDER BY first_name;

/* 34. Write a query to display the first name and salary for all employees. Format the salary to be 10 characters long, left-padded with the $ symbol. Label the column SALARY */
SELECT first_name,
	   LPAD(salary,10,'$') AS SALARY
FROM employees;    

/* 35. Write a query to display the first eight characters of the employees' first names and indicates the amounts of their salaries with '$' sign. Each '$' sign signifies a thousand dollars. Sort the data in descending order of salary */
SELECT left(first_name,8),
       REPEAT('$',FLOOR(salary/1000))
	   'SALARY($)',salary
FROM employees
ORDER BY salary DESC;       

/* 36. Write a query to display the employees with their code, first name, last name and hire date who hired either on seventh day of any month or seventh month in any year */
SELECT * FROM employees;

SELECT employee_id,first_name,last_name,hire_date
FROM employees
WHERE MONTH(hire_date) = 7
or DAY(hire_date) = 7;
   
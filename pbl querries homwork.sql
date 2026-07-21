-- 1. Structure of DEPT table
DESC HR.DEPARTMENTS;

-- 2. Structure of EMP table
DESC HR.EMPLOYEES;

-- 3. Display Ename and Deptno from Emp table where Empno is 7788
SELECT first_name, department_id 
FROM hr.employees 
WHERE employee_id = 7788;

-- 4. Display employees earning commission sorted by salary and comm (descending using positions)
SELECT first_name, salary, commission_pct 
FROM hr.employees 
WHERE commission_pct IS NOT NULL 
ORDER BY 2 DESC, 3 DESC;

-- 5. Display all unique job codes
SELECT DISTINCT job_id 
FROM hr.employees;

-- 6. Report with column aliases: Emp #, Employee, Job, Hire Date
SELECT employee_id AS "Emp #",
       first_name AS "Employee",
       job_id AS "Job",
       hire_date AS "Hire Date"
FROM hr.employees;

-- 7. Concatenated last name and job ID
SELECT last_name || ', ' || job_id AS "Employee and Title"
FROM hr.employees;

-- 8. Concatenated employee details separated by commas
SELECT first_name || ',' || job_id || ',' || hire_date || ',' || manager_id AS THE_OUTPUT
FROM hr.employees;

-- 9. Display employees named Scott or Turner ordered by hire date
SELECT first_name, job_id, hire_date
FROM hr.employees
WHERE first_name IN ('Scott', 'Turner')
ORDER BY hire_date ASC;

-- 10. Salary left-padded with $ up to 15 characters
SELECT last_name, LPAD(salary, 15, '$') AS SALARY
FROM hr.employees;

-- 11. Display last name, hire date, and starting day of week
SELECT last_name,
       hire_date,
       TO_CHAR(hire_date, 'fmDay') AS DAY
FROM hr.employees
ORDER BY MOD(TRUNC(hire_date) - DATE '1900-01-01', 7);

-- 12. Display employees in departments 20 or 30 ordered by name
SELECT first_name, department_id 
FROM hr.employees 
WHERE department_id IN (20, 30) 
ORDER BY first_name ASC;

-- 13. Employees in dept 20/30 with salary between 2000 and 3000
SELECT last_name AS "Employee",  
       salary AS "Monthly salary" 
FROM hr.employees 
WHERE salary BETWEEN 2000 AND 3000 
  AND department_id IN (20, 30);

-- 14. Employees hired in 1981
SELECT last_name, hire_date 
FROM hr.employees 
WHERE TO_CHAR(hire_date, 'YYYY') = '1981';

-- 15. Employees earning more than user prompt
SELECT first_name, salary
FROM hr.employees
WHERE salary > &user_specified_amount;

-- 16. Employees without a manager
SELECT last_name, job_id      
FROM hr.employees
WHERE manager_id IS NULL;

-- 17. Prompt for Manager ID and sort column
SELECT employee_id AS "EMPNO", 
       first_name AS "ENAME", 
       salary AS "SAL", 
       department_id AS "DEPTNO"
FROM hr.employees
WHERE manager_id = &prompt_manager_id
ORDER BY &prompt_sort_column;

-- 18. Last names with 3rd letter 'A'
SELECT last_name 
FROM hr.employees 
WHERE last_name LIKE '__A%';

-- 19. Clerks earning 800, 950, or 1300
SELECT first_name, job_id, salary
FROM hr.employees
WHERE job_id = 'CLERK'
  AND salary IN (800, 950, 1300);

-- 20. Display current date
SELECT SYSDATE AS "Date"
FROM dual;

-- 21. Salary increased by 15.5%
SELECT employee_id, 
       last_name, 
       salary,                  
       ROUND(salary * 1.155) AS "New Salary"
FROM hr.employees;

-- 22. Salary increase difference
SELECT employee_id, 
       last_name, 
       salary, 
       ROUND(salary * 1.155) AS "New Salary",
       ROUND(salary * 1.155) - salary AS "Increase"
FROM hr.employees;

-- 23. Aggregated salary statistics
SELECT MAX(salary) AS Maximum,
       MIN(salary) AS Minimum,
       SUM(salary) AS Sum,
       ROUND(AVG(salary)) AS Average
FROM hr.employees;

-- 24. Aggregated salary statistics per job type
SELECT job_id,
       MIN(salary) AS Minimum,
       MAX(salary) AS Maximum,
       SUM(salary) AS Sum,
       ROUND(AVG(salary)) AS Average
FROM hr.employees
GROUP BY job_id;

-- 25. Count of people per job
SELECT job_id,
       COUNT(*) AS "Number of People"
FROM hr.employees
GROUP BY job_id;

-- 26. Count of distinct managers
SELECT COUNT(DISTINCT manager_id) AS "Number of Managers"
FROM hr.employees;

-- 27. Difference between max and min salary
SELECT MAX(salary) - MIN(salary) AS "difference" 
FROM hr.employees;

-- 28. Lowest paid employee per manager (excluding min salary <= 2000)
SELECT manager_id, MIN(salary) AS "MIN_SALARY"
FROM hr.employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary) > 2000
ORDER BY "MIN_SALARY" DESC;

-- 29. Natural join between employees and departments
SELECT employee_id, first_name, salary, department_name, location_id
FROM hr.employees 
NATURAL JOIN (
    SELECT department_id, department_name, location_id 
    FROM hr.departments
) d;

-- 30. Inner join for salesman details
SELECT e.job_id, 
       e.manager_id, 
       e.salary, 
       e.commission_pct, 
       d.department_name
FROM hr.employees e 
INNER JOIN hr.departments d 
   ON e.department_id = d.department_id 
WHERE e.job_id = 'SALESMAN';

-- 31. Inner join for employees in Dallas
SELECT e.first_name, 
       e.job_id, 
       e.department_id, 
       d.department_name
FROM hr.employees e
INNER JOIN hr.departments d 
   ON e.department_id = d.department_id
INNER JOIN hr.locations l 
   ON d.location_id = l.location_id
WHERE l.city = 'Dallas';
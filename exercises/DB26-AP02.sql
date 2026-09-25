/*
  Lesson 02 - Expressions, NULL, conversion, and formatting
  Student: a22509596
  Class: D01EINF02
  Date: 25/09/2026
*/

USE ULHT_DB26;
GO

--A1. Formal name
SELECT EMPLOYEE_ID,
       CONCAT(LAST_NAME, ', ', FIRST_NAME) AS full_name,
       LOWER(CONCAT(LEFT(FIRST_NAME, 1), '.', LAST_NAME)) AS formal_name
FROM HR.EMPLOYEES;

--A3. Name length
SELECT LAST_NAME, LEN(LAST_NAME) As last_name_lenght from HR.EMPLOYEES;

--A4. Quarterly and annual salary
SELECT top 5 e.EMPLOYEE_ID, e.SALARY,
       e.SALARY * 4 AS quarter_salary,
       e.SALARY * 12 AS annual_salary
      
 from HR.EMPLOYEES e;

 --A5. Review date
SELECT top 5 EMPLOYEE_ID, HIRE_DATE,
       DATEADD(MONTH, 6, HIRE_DATE) AS review_date
FROM HR.EMPLOYEES;

--Part B - NULL and nullity

--B1. Employees with commission
SELECT EMPLOYEE_ID, COMMISSION_PCT
FROM HR.EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

--B2. Commission amount
select e.EMPLOYEE_ID, e.SALARY, e.COMMISSION_PCT, e.SALARY * (ISNULL(e.COMMISSION_PCT, 0)) 
From HR.EMPLOYEES e;

-- B3. Total annual compensation
select top 5 e.EMPLOYEE_ID, (e.SALARY * 4) + (ISNULL(e.COMMISSION_PCT * 4, 0)) as annual_total
from HR.EMPLOYEES e order by annual_total DESC;

-- B4. Manager label

select top 5 e.EMPLOYEE_ID, COALESCE(cast(e.MANAGER_ID AS VARCHAR(20)), 'no manager') as manager_label
from HR.EMPLOYEES e;

--Part C - Conversion
--C1. Department code
select e.EMPLOYEE_ID, CONCAT('DEP-', COALESCE(cast(e.DEPARTMENT_ID as VARCHAR(20)), 'UNASSIGNED'))
 AS department_code from HR.EMPLOYEES e;

--C2. ISO hire date
select e.EMPLOYEE_ID, CONVERT(VARCHAR(10), e.HIRE_DATE, 23) AS iso_hire_date 
from HR.EMPLOYEES e;

--C3. Safe conversion audit
select TRY_CONVERT(VARCHAR(10), e.EMPLOYEE_ID) AS EMPLOYEE_ID, TRY_CONVERT(int, EMPLOYEE_ID) as recovered_id
from HR.EMPLOYEES e;

-- Part D - Formatting
--D1. Salary with two decimal places
SELECT EMPLOYEE_ID, SALARY,
       FORMAT(SALARY, 'C', 'pt-pt') AS salary_display
FROM HR.EMPLOYEES;

--D2. Readable hire date

SELECT EMPLOYEE_ID, HIRE_DATE,
       FORMAT(HIRE_DATE, 'dd MMMM yyyy', 'pt-pt') AS hire_date_display
FROM HR.EMPLOYEES;

-- D3. Padded employee reference

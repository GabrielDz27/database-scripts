
/*Lista 1*/
-- 1)
select *
from hr.employees;
--2)
SELECT employee_id,
    First_name || ' ' || last_name AS full_name
FROM HR.EMPLOYEES;
--3)
SELECT employee_id,
    First_name || ' ' || last_name AS full_name
FROM HR.EMPLOYEES
ORDER BY First_name DESC;
--4)
SELECT LOCATIONS.CITY || '/' || LOCATIONS.COUNTRY_ID || ' ' || COUNTRIES.COUNTRY_NAME AS LOCALIZACAO
FROM HR.LOCATIONS
    INNER JOIN HR.COUNTRIES ON LOCATIONS.COUNTRY_ID = COUNTRIES.COUNTRY_ID
ORDER BY CITY;
--5)
SELECT distinct department_id
FROM HR.EMPRLOYEES
ORDER BY department_id ASC;
--6)
select distinct job_id
from hr.employees
order by job_id desc;
--7)
SELECT *
FROM HR.DEPARTMENTS
ORDER BY department_id DESC;
--8)
SELECT *
FROM HR.COUNTRIES
WHERE rownum < 20;

/*Lista 2*/
--1)
select *
from hr.COUNTRIES
where region_id = 4 ;


---2)
select *
from hr.COUNTRIES
where region_id = 4 ;

--3)
select FIRST_NAME,
    LAST_NAME,
    DEPARTMENT_ID,
    SALARY
from hr.EMPLOYEES
where SALARY > 8000 ;

--4)
select SALARY,
    (SALARY + 500) AS ADCIONAL_SALARIO
from hr.EMPLOYEES ;

--5)
select *
from hr.DEPARTMENTS
WHERE manager_id IS NULL ;

--6)
select *
from hr.DEPARTMENTS
WHERE manager_id IS NULL ;

--7)
select *
from hr.COUNTRIES
WHERE COUNTRY_ID IN ('US', 'UK', 'AR') ;

--8)
select *
from hr.COUNTRIES
WHERE (country_name LIKE 'Israel')
    OR (country_name LIKE 'Denmark') ;
    
--9)
select start_date,
    end_date
from hr.Job_History
WHERE BETWEEN TO_DATE('1993-01-01', 'YYYY-MM-DD') AND TO_DATE('1998-01-01', 'YYYY-MM-DD') ;

--10)
select start_date,
    end_date
from hr.REGIONS
WHERE region_id != 1 ;

--11)
SELECT *
FROM hr.COUNTRIES
ORDER BY country_name DESC ;

--12)
select *
from hr.COUNTRIES
WHERE country_id IN('BR', 'FR', 'US') ;

--13)
SELECT employee_id,
    first_name,
    last_name,
    email,
    phone_number,
    job_id,
    salary,
    commission_pct,
    manager_id,
    department_id
FROM hr.Employees
WHERE department_id IS NULL ;

--14)
SELECT *
FROM hr.Employees
WHERE job_id = 'IT_PROG'
    OR job_id = 'ST_MAN'
    AND SALARY < 5000
ORDER BY job_id ASC ;

--15)
SELECT job_id || ' ' || first_name || ' ' || last_name AS info_trabalhador
FROM hr.Employees ;

--16) 
SELECT *
FROM HR.Employees
WHERE SALARY BETWEEN 5000 AND 7000
    AND TO_CHAR(HIRE_DATE, 'YYYY') = '2007' ;
    
--17)
SELECT DEPARTMENT_NAME
FROM HR.Departments
WHERE DEPARTMENT_NAME like '%n' ;

--18)
SELECT DEPARTMENT_NAME
FROM HR.Departments
WHERE DEPARTMENT_NAME like 'A%' ;

--19)
SELECT DEPARTMENT_NAME
FROM HR.Departments
WHERE DEPARTMENT_NAME like '_a%'
    and DEPARTMENT_NAME like '%ing' ;
    
--20)
SELECT *
FROM HR.Locations
WHERE COUNTRY_ID like 'BR'  ;
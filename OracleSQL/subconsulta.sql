-- Liste os nomes dos funcionários que ganham mais do que o salário médio de todos os funcionários.


SELECT E.FIRST_NAME || ' ' || E.LAST_NAME
FROM HR.EMPLOYEES E
WHERE E.SALARY > (SELECT AVG(SALARY) FROM HR.EMPLOYEES);


-- Exiba os nomes dos funcionários cujo salário é maior que o maior salário do departamento 50.


SELECT E.FIRST_NAME || ' ' || E.LAST_NAME
FROM HR.EMPLOYEES E
WHERE E.SALARY > (SELECT MAX(SALARY) FROM HR.EMPLOYEES WHERE DEPARTMENT_ID =50);


-- Mostre os funcionários que trabalham no mesmo departamento que o funcionário chamado ‘Lex De Haan’.


SELECT *
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID = (
    SELECT DEPARTMENT_ID
    FROM HR.EMPLOYEES
    WHERE FIRST_NAME LIKE '%Lex%'
);


-- Liste os nomes dos funcionários que possuem o mesmo cargo (JOB_ID) que o funcionário ‘Neena Kochhar’.


SELECT *
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID = (
    SELECT JOB_ID
    FROM HR.EMPLOYEES
    WHERE FIRST_NAME LIKE '%Neena%' AND LAST_NAME LIKE '%Kochhar%'
);

--5)
-- Exiba os nomes dos funcionários cujo salário é igual ao maior
--  salário de seu próprio departamento.
SELECT * FROM HR.EMPLOYEES A
WHERE SALARY >= ALL (
    SELECT AVG(SALARY)
    FROM HR.EMPLOYEES
    WHERE DEPARTMENT_ID =  A.DEPARTMENT_ID
)


--6)
SELECT *
FROM HR.DEPARTMENTS
WHERE DEPARTMENT_ID NOT IN (
    SELECT DISTINCT DEPARTMENT_ID
    FROM HR.EMPLOYEES
    WHERE DEPARTMENT_ID IS NOT NULL
);


--7)
--Apresente os nomes dos funcionários que já trabalharam em um cargo diferente do --atual (usando JOB_HISTORY)


SELECT * FROM HR.EMPLOYEES  E
WHERE E.EMPLOYEE_ID IN (
    SELECT EMPLOYEE_ID
    FROM HR.JOB_HISTORY
    WHERE E.JOB_ID != JOB_ID
);




--8)
SELECT first_name, last_name
FROM employees
WHERE department_id IN (
   SELECT department_id
   FROM departments
   WHERE location_id IN (
       SELECT location_id
       FROM locations
       WHERE country_id IN (
           SELECT country_id
           FROM countries
           WHERE region_id = (
               SELECT region_id
               FROM regions
               WHERE region_name = 'Europe'
           )
       )
   )
);


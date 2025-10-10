
-- 1.
INSERT INTO employees (
            employee_id,
            first_name,
            last_name,
            job_id,
            salary,
            department_id,
            hire_date,
            email
      )
VALUES (
            300,
            'Carlos',
            'Silva',
            'IT_PROG',
            6000,
            60,
            SYSDATE,
            'CSILVA'
      );

-- 2.
INSERT INTO departments (department_id, department_name, location_id)
VALUES (
            280,
            'Pesquisa e Desenvolvimento',
            (
                  SELECT location_id
                  FROM departments
                  WHERE department_id = 90
            )
      );

-- 3.
INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES (
            'ANL_PROG',
            'Analista de Programação',
            5000,
            9000
      );

-- 4.
INSERT INTO job_history (
            employee_id,
            start_date,
            end_date,
            job_id,
            department_id
      )
VALUES (
            102,
            TO_DATE('01/01/2015', 'DD/MM/YYYY'),
            TO_DATE('31/12/2017', 'DD/MM/YYYY'),
            'FI_ACCOUNT',
            100
      );

-- 5.
INSERT INTO locations (
            location_id,
            street_address,
            city,
            state_province,
            country_id
      )
VALUES (
            3300,
            'Rua das Flores, 123',
            'Curitiba',
            'PR',
            'BR'
      );

-- 6.
UPDATE employees
SET salary = salary * 1.10
WHERE job_id = 'IT_PROG';

-- 7.
UPDATE departments
SET department_name = 'Marketing Digital'
WHERE department_name = 'Marketing';

-- 8.
UPDATE employees
SET commission_pct = 0.15
WHERE commission_pct IS NULL;

-- 9.
UPDATE employees
SET department_id = 80
WHERE department_id = 50;

-- 10.
UPDATE locations
SET city = 'London'
WHERE city = 'Londres';

-- 11.
DELETE FROM employees
WHERE salary < 3000;

-- 12.
DELETE FROM departments
WHERE department_name = 'Construction';

-- 13.
DELETE FROM job_history
WHERE employee_id NOT IN (
            SELECT employee_id
            FROM employees
      );

-- 14.
DELETE FROM locations
WHERE country_id = 'BR';

-- 15.
DELETE FROM employees
WHERE department_id = 70;
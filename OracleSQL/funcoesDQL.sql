-- Qual é o salário médio dos funcionários?


select avg(SALARY)
from hr.EMPLOYEES ;


-- Qual é o maior salário registrado na empresa?


select max(SALARY)
from hr.EMPLOYEES ;


-- Quantos funcionários há na tabela EMPLOYEES?


select count(*)
from hr.EMPLOYEES ;


-- Qual é o menor salário entre os funcionários?


select min(SALARY)
from hr.EMPLOYEES ;


-- Qual é a soma total dos salários pagos aos funcionários?


select sum(SALARY)
from hr.EMPLOYEES ;




-- Quantos funcionários são comissionados (COMMISSION_PCT não nulo)?


select count(*)
from hr.EMPLOYEES
where COMMISSION_PCT is not null;




-- Qual é a média dos salários dos funcionários que atuam nos departamentos 10, 20, 30 ou 40 e que tenham a letra A em seu nome?


select avg(SALARY)
from hr.EMPLOYEES
where DEPARTMENT_ID in (10, 20, 30, 40)
and FIRST_NAME like '%A%';




-- Quantos cargos (JOBS) distintos existem na tabela EMPLOYEES?


select DISTINCT JOB_ID
from hr.EMPLOYEES ;




-- Calcule o salário médio considerando apenas os funcionários que ganham mais de 8000.


select avg(SALARY)
from hr.EMPLOYEES
where SALARY >8000;




-- Qual é a média da comissão (COMMISSION_PCT) dos funcionários que recebem comissão?


select avg(COMMISSION_PCT)
from hr.EMPLOYEES
where COMMISSION_PCT is  not null;

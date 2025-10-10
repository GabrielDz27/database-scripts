
--1)
select avg(e.salary),
    d.DEPARTMENT_NAME
from hr.EMPLOYEES e
    inner join hr.DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
group by d.DEPARTMENT_NAME;

--2)
select j.job_title,
    min(e.salary),
    max(e.SALARY)
from hr.employees e
    inner join hr.jobs j on j.JOB_ID = e.JOB_ID
group by j.job_title;

--3)
select l.CITY,
    count(e.EMPLOYEE_ID)
from hr.employees e
    inner join hr.departments d on d.DEPARTMENT_ID = e.DEPARTMENT_ID
    inner join hr.locations l on l.LOCATION_ID = d.LOCATION_ID
group by l.CITY;

--4)
select c.COUNTRY_NAME,
    sum(e.salary)
from hr.employees e
    inner join hr.departments d on d.DEPARTMENT_ID = e.DEPARTMENT_ID
    inner join hr.locations l on l.LOCATION_ID = d.LOCATION_ID
    inner join hr.countries c on c.COUNTRY_ID = l.COUNTRY_ID
group by c.COUNTRY_NAME;

--5)
select r.REGION_NAME,
    avg(e.salary)
from hr.employees e
    inner join hr.departments d on d.DEPARTMENT_ID = e.DEPARTMENT_ID
    inner join hr.locations l on l.LOCATION_ID = d.LOCATION_ID
    inner join hr.countries c on c.COUNTRY_ID = l.COUNTRY_ID
    inner join hr.REGIONS r on r.REGION_ID = c.REGION_ID
where e.salary <= 5000
group by r.REGION_NAME;

--6)
select count(e.EMPLOYEE_ID),
    d.DEPARTMENT_NAME
from hr.EMPLOYEES e
    inner join hr.DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
group by d.DEPARTMENT_NAME;

--7)
select c.COUNTRY_NAME,
    avg(e.salary) as media
from hr.employees e
    inner join hr.departments d on d.DEPARTMENT_ID = e.DEPARTMENT_ID
    inner join hr.locations l on l.LOCATION_ID = d.LOCATION_ID
    inner join hr.countries c on c.COUNTRY_ID = l.COUNTRY_ID
group by c.COUNTRY_NAME
having avg(e.salary) > 6000 ;

--10)select l.CITY , max(e.salary),min(e.salary), avg(e.salary)
from hr.employees e
    inner join hr.departments d on d.DEPARTMENT_ID = e.DEPARTMENT_ID
    inner join hr.locations l on l.LOCATION_ID = d.LOCATION_ID
group by l.CITY;
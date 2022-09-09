--The average number of people that worked for the company during the year: S less than 50 employees (small) M 50 to 250 employees (medium) L more than 250 employees (large)
--Task: Analyze Full Time Data Analyst, Data Scientist, and Data Engineers around the world against the size of the company and the work year

Select *
From ds_salaries;



--Page 1 (Blue): Comparing average salary of Data Analyst in different sized companies (Small, Medium, Large) in the United States
Select employment_type, job_title, company_size,AVG(cast (salary_in_usd as int)) AverageSalary, count(job_title) as DataPoints,MAX(cast (salary_in_usd as int)) as MaxSalary,min(cast(salary_in_usd as int)) as MinSalary
From dbo.ds_salaries
Where job_title='Data Analyst' and company_size='S' and employment_type='FT'
Group By employment_type,job_title,company_size
Union
Select employment_type,job_title, company_size,AVG(cast (salary_in_usd as int)) AverageSalary, count(job_title)as DataPoints,MAX(cast (salary_in_usd as int)) as MaxSalary,min(cast(salary_in_usd as int)) as MinSalary
From dbo.ds_salaries
Where job_title='Data Analyst' AND company_size='M' and employment_type='FT'
Group By employment_type,job_title,company_size
Union
Select employment_type,job_title, company_size,AVG(cast (salary_in_usd as int)) AverageSalary, count(job_title)as DataPoints,MAX(cast (salary_in_usd as int)) as MaxSalary,min(cast(salary_in_usd as int)) as MinSalary
From dbo.ds_salaries
Where job_title='Data Analyst' AND company_size='L'  and employment_type='FT'
Group By employment_type, job_title,company_size;

--Page 1 (Red): Comparing average salary of Data Scientist in different sized companies (Small, Medium, Large) in the United States
Select employment_type, job_title, company_size,AVG(cast (salary_in_usd as int)) AverageSalary, count(job_title) as DataPoints,MAX(cast (salary_in_usd as int)) as MaxSalary,min(cast(salary_in_usd as int)) as MinSalary
From dbo.ds_salaries
Where job_title='Data Scientist' and company_size='S' and employment_type='FT'
Group By employment_type,job_title,company_size
Union
Select employment_type,job_title, company_size,AVG(cast (salary_in_usd as int)) AverageSalary, count(job_title)as DataPoints,MAX(cast (salary_in_usd as int)) as MaxSalary,min(cast(salary_in_usd as int)) as MinSalary
From dbo.ds_salaries
Where job_title='Data Scientist' AND company_size='M' and employment_type='FT'
Group By employment_type,job_title,company_size
Union
Select employment_type,job_title, company_size,AVG(cast (salary_in_usd as int)) AverageSalary, count(job_title)as DataPoints,MAX(cast (salary_in_usd as int)) as MaxSalary,min(cast(salary_in_usd as int)) as MinSalary
From dbo.ds_salaries
Where job_title='Data Scientist' AND company_size='L'  and employment_type='FT'
Group By employment_type, job_title,company_size;

--Page 1 (Yellow): Comparing average salary of Data Engineer in different sized companies (Small, Medium, Large) in the United States
Select employment_type, job_title, company_size,AVG(cast (salary_in_usd as int)) AverageSalary, count(job_title) as DataPoints,MAX(cast (salary_in_usd as int)) as MaxSalary,min(cast(salary_in_usd as int)) as MinSalary
From dbo.ds_salaries
Where job_title='Data Engineer' and company_size='S' and employment_type='FT'
Group By employment_type,job_title,company_size
Union
Select employment_type,job_title, company_size,AVG(cast (salary_in_usd as int)) AverageSalary, count(job_title)as DataPoints,MAX(cast (salary_in_usd as int)) as MaxSalary,min(cast(salary_in_usd as int)) as MinSalary
From dbo.ds_salaries
Where job_title='Data Engineer' AND company_size='M' and employment_type='FT'
Group By employment_type,job_title,company_size
Union
Select employment_type,job_title, company_size,AVG(cast (salary_in_usd as int)) AverageSalary, count(job_title)as DataPoints,MAX(cast (salary_in_usd as int)) as MaxSalary,min(cast(salary_in_usd as int)) as MinSalary
From dbo.ds_salaries
Where job_title='Data Engineer' AND company_size='L'  and employment_type='FT'
Group By employment_type, job_title,company_size;

--Page 1 Line Charts
Select employment_type, job_title, CASE when company_size='S' then 'Small' end, remote_ratio, work_year, salary_in_usd
From dbo.ds_salaries
Where (job_title='Data Analyst' or job_title='Data Scientist' or job_title='Data Engineer') and company_size='S' and employment_type='FT'
Union ALL
Select employment_type, job_title, CASE when company_size='M' then 'Medium' end,remote_ratio, work_year, salary_in_usd
From dbo.ds_salaries
Where (job_title='Data Analyst' or job_title='Data Scientist' or job_title='Data Engineer') AND company_size='M' and employment_type='FT'
Union ALL
Select employment_type, job_title, CASE when company_size='L' then 'Large' end,remote_ratio, work_year, salary_in_usd
From dbo.ds_salaries
Where (job_title='Data Analyst' or job_title='Data Scientist' or job_title='Data Engineer') AND company_size='L'  and employment_type='FT';

--Page 2: Comparing Entry, Middle and Senior level experience for Data Analyst by year

Select work_year, job_title, experience_level, salary_in_usd
From dbo.ds_salaries
Where employment_type='FT' and job_title='Data Analyst' and (experience_level='EN' or experience_level='MI' or experience_level='SE')
Union All
Select work_year, job_title, experience_level, salary_in_usd
From dbo.ds_salaries
Where employment_type='FT' and job_title='Data Scientist' and (experience_level='EN' or experience_level='MI' or experience_level='SE')
Union All
Select work_year, job_title, experience_level, salary_in_usd
From dbo.ds_salaries
Where employment_type='FT' and job_title='Data Engineer' and (experience_level='EN' or experience_level='MI' or experience_level='SE');

--Page 3 Map of Countries slide
Select DISTINCT employee_residence,
CASE
WHEN employee_residence='US' then 'United States'
WHEN employee_residence='AE' then 'United Arab Emirates'
WHEN employee_residence='AR' then 'Argentina'
WHEN employee_residence='AT' then 'Austria'
WHEN employee_residence='AU' then 'Australia'
WHEN employee_residence='BE' then 'Belgium'
WHEN employee_residence='BG' then 'Bulgaria'
WHEN employee_residence='BO' then 'Bolivia'
WHEN employee_residence='BR' then 'Brazil'
WHEN employee_residence='CA' then 'Canada'
WHEN employee_residence='CH' then 'Switzerland'
WHEN employee_residence='CL' then 'Chile'
WHEN employee_residence='CN' then 'China'
WHEN employee_residence='CO' then 'Colombia'
WHEN employee_residence='CZ' then 'Czechia'
WHEN employee_residence='DE' then 'Germany'
WHEN employee_residence='DK' then 'Denmark'
WHEN employee_residence='DZ' then 'Algeria'
WHEN employee_residence='EE' then 'Estonia'
WHEN employee_residence='ES' then 'Spain'
WHEN employee_residence='FR' then 'France'
WHEN employee_residence='GB' then 'United Kingdom'
WHEN employee_residence='GR' then 'Greece'
WHEN employee_residence='HK' then 'Hong Kong'
WHEN employee_residence='HN' then 'Honduras'
WHEN employee_residence='HR' then 'Croatia'
WHEN employee_residence='HU' then 'Hungary'
WHEN employee_residence='IE' then 'Ireland'
WHEN employee_residence='IN' then 'India'
WHEN employee_residence='IQ' then 'Iraq'
WHEN employee_residence='IR' then 'Iran'
WHEN employee_residence='IT' then 'Italy'
WHEN employee_residence='JE' then 'Jersey'
WHEN employee_residence='JP' then 'Japan'
WHEN employee_residence='KE' then 'Kenya'
WHEN employee_residence='LU' then 'Luxembourg'
WHEN employee_residence='MD' then 'Moldova'
WHEN employee_residence='MT' then 'Malta'
WHEN employee_residence='MX' then 'Mexico'
WHEN employee_residence='MY' then 'Malaysia'
WHEN employee_residence='NG' then 'Nigeria'
WHEN employee_residence='NL' then 'Netherlands'
WHEN employee_residence='NZ' then 'New Zealand'
WHEN employee_residence='PH' then 'Philippines'
WHEN employee_residence='PK' then 'Pakistan'
WHEN employee_residence='PL' then 'Poland'
WHEN employee_residence='PR' then 'Puerto Rico'
WHEN employee_residence='PT' then 'Portugal'
WHEN employee_residence='RO' then 'Romania'
WHEN employee_residence='RS' then 'Serbia'
WHEN employee_residence='RU' then 'Russia'
WHEN employee_residence='SG' then 'Singapore'
WHEN employee_residence='SI' then 'Slovenia'
WHEN employee_residence='TN' then 'Tunisia'
WHEN employee_residence='TR' then 'Turkey'
WHEN employee_residence='UA' then 'Ukraine'
WHEN employee_residence='VN' then 'Vietnam'
END as Country, Count(employee_residence) as CountryCount, job_title
From dbo.ds_salaries
Where (job_title='Data Analyst' or job_title='Data Scientist' or job_title='Data Engineer') and employment_type='FT'
Group by employee_residence, job_title;



--Page 4 Job Position Count
Select job_title,count(job_title) as CountJob
From dbo.ds_salaries
Group by job_title;

--Page 4 Count of Salary Range
WITH Sal_CTE AS (
Select Salary_in_usd,
CASE
When cast(Salary_in_usd as int) < 100000 then 'Under 100k'
When (cast(Salary_in_usd as int) BETWEEN  99999 AND 199999) then 'Between 100k and 200k'
When cast(Salary_in_usd as int) > 199999 then 'Over 200k'
ELSE 'Unknown'
END as SalBracket
From dbo.ds_salaries)

Select SalBracket,count(SalBracket) AS SalCount
From Sal_CTE
Group by SalBracket;
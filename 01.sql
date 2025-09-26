--1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

with List as(
	select 
		industry,
		payroll_year,
		avg(average_wages)as average_salary
	from t_patrik_pagac_project_SQL_primary_final
	where calculation_code=200
	group by industry, payroll_year
	order by payroll_year
)
select 
    industry,
    payroll_year,
    average_salary,
    lag(average_salary) over (partition by industry order by payroll_year) as average_salary_last_year,
    average_salary - lag(average_salary) over (partition by industry order by payroll_year) as difference,
    case 
	    	when average_salary - lag(average_salary) over (partition by industry order by payroll_year)> 0 then 'increases'
		    when average_salary - lag(average_salary) over (partition by industry order by payroll_year)= 0 then 'stagnates'
		    when average_salary - lag(average_salary) over (partition by industry order by payroll_year)< 0 then 'decreases'
		    else 'unknown'
end as trend
    from List
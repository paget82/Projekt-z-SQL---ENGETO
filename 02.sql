--2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

with Year_Income as(   
	select 
		payroll_year,
		trunc(avg(average_wages)::numeric, 0)as average_salary
	from t_patrik_pagac_project_SQL_primary_final
	where calculation_code=200
	group by payroll_year
),
Milk_Bread as(
	select  
		food_category,
		round(avg(	price)::numeric, 1)as average_price,
		payroll_year
	from t_patrik_pagac_project_SQL_primary_final
	where 1=1
		and food_category in ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
	group by payroll_year, food_category
),
Years_Range as(
	select min(payroll_year)as min_year,
			   max(payroll_year)as max_year
	from Milk_Bread
)
select 
	m.food_category,
	m.payroll_year,
	y.average_salary,
	 m.average_price,
	trunc((average_salary/ 	average_price) ,0) as count
from Milk_Bread m
join Year_Income y
on y.payroll_year=m.payroll_year
join Years_Range r
on m.payroll_year=r.min_year or m.payroll_year=r.max_year
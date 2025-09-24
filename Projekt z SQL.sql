    --1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

with List as(
	select 
		industry,
		avg(average_wages)as average_salary,
		payroll_year
	from t_patrik_pagac_project_SQL_primary_final
	where calculation_code=200
	group by payroll_year, industry
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
		    else 'Unknown'
end as status
    from List
    
    
--2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

with YearIncome as(   
		select 
			payroll_year as payroll_years,
			trunc(avg(average_wages)::numeric, 0)as average_salary
		from t_patrik_pagac_project_SQL_primary_final
		where calculation_code=200
		group by payroll_year
		order by payroll_year
),
Bread as(
	select  
		food_category,
		round(avg(	price)::numeric, 1)as average_price,
		payroll_year
	from t_patrik_pagac_project_SQL_primary_final
	where 1=1
		and food_category ='Chléb konzumní kmínový'
	group by payroll_year, food_category
),
Milk as(
	select  
		food_category,
		round(avg(	price)::numeric, 1)as average_price,
		payroll_year
	from t_patrik_pagac_project_SQL_primary_final
	where 1=1
		and food_category = 'Mléko polotučné pasterované'
	group by payroll_year, food_category
),
Milk_Bread as(
select  
		food_category,
		 average_price,
		payroll_year
from Bread
union all
select  
		food_category,
		 average_price,
		payroll_year
from Milk
)
select 
		m.food_category,
		 m.average_price,
		m.payroll_year,
		y.average_salary,
		trunc(average_salary/ 	(avg(	 m.average_price)::numeric) ,0) as count
from Milk_Bread m
join YearIncome y
on y.payroll_years=m.payroll_year
group by 		
		m.food_category,
		 m.average_price,
		m.payroll_year,
		y.average_salary
order by m.food_category, m.payroll_year

--3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 
 
with AvgPrices  as(
	select 
			food_category,
			round(avg(price	)::numeric, 2)as avg_price,
			payroll_year
	from t_patrik_pagac_project_SQL_primary_final
	group by  payroll_year, food_category  
),
YoYGrowth as(
	select 
		food_category,
		payroll_year,
		avg_price,
		  lag(avg_price) over (partition by food_category order by payroll_year) as prev_price,
		round(
		(	avg_price -  lag(avg_price) over (partition by food_category order by payroll_year))/ 
		nullif(lag(avg_price) over (partition by food_category order by payroll_year  ),0)*100, 2)  as yoy_growth_percent
	from AvgPrices 
)
select 
	food_category,
	round(avg(yoy_growth_percent),2)as avg_growth
from YoYGrowth
where yoy_growth_percent is not null
group  by food_category
order by avg_growth asc
limit 1;

		
--4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

with FoodGrowth  as(
	select 
			payroll_year,
		    round(
          ((avg(price) - lag(avg(price)) over (order by payroll_year))
         / lag(avg(price)) over (order by payroll_year))::numeric* 100, 2  )as food_YoyGrowth
	from t_patrik_pagac_project_SQL_primary_final
	group by  payroll_year
	),
	WageGrowth  as(
    select
    payroll_year,
    round(
            ((avg(average_wages) - lag(avg(average_wages)) over (order by payroll_year))
             / lag(avg(average_wages)) over (order by payroll_year)) * 100, 2  ) as wage_YoyGrowth
    from t_patrik_pagac_project_SQL_primary_final
    where calculation_code = 200
    group by payroll_year
    )
    select
    	w.	payroll_year,
		f.food_YoyGrowth,
		w.	wage_YoyGrowth,
		 f.food_YoyGrowth -w.wage_YoyGrowth as  difference
    from FoodGrowth f
    join WageGrowth w
    on w.payroll_year=f.payroll_year
    where f.food_YoyGrowth -w.wage_YoyGrowth >5
    order by difference desc 


--5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
   		
with YoyFoodGrowth  as(
	select 
			payroll_year,
		    round(
          ((avg(price) - lag(avg(price)) over(order by payroll_year))
         / lag(avg(price)) over(order by payroll_year))::numeric* 100, 2  )as food_YoyGrowth
	from t_patrik_pagac_project_SQL_primary_final
	group by  payroll_year
	),
YoyWageGrowth  as(
    select
    payroll_year,
    round(
            ((avg(average_wages) - lag(avg(average_wages)) over (order by payroll_year))
             / lag(avg(average_wages)) over (order by payroll_year)) * 100, 2  ) as wage_YoyGrowth
    from t_patrik_pagac_project_SQL_primary_final
    where calculation_code = 200
    group by payroll_year
    ),
YoyGdp  as(  
	select 
		year, 
		round(
	((gdp-lag(gdp)over(order by year))
	/lag(gdp)over(order by year))::numeric* 100, 2  )as gdp_growth
	from t_patrik_pagac_project_SQL_secondary_final
	where country = 'Czech Republic'
)
select 
	f.payroll_year, 
	g.gdp_growth,
	f.food_YoyGrowth,
	w.wage_YoyGrowth
from YoyFoodGrowth f
join YoyWageGrowth w
on f.payroll_year=w.payroll_year
join YoyGdp g
on f.payroll_year=g.year

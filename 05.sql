--5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
   		
with YoyFoodGrowth  as(
	select 
			payroll_year,
		    round(
		          ((avg(price) - lag(avg(price)) over(order by payroll_year))
		         / lag(avg(price)) over(order by payroll_year))::numeric* 100
         , 2  )as food_YoyGrowth
	from t_patrik_pagac_project_SQL_primary_final
	group by  payroll_year
	),
YoyWageGrowth  as(
    select
    		payroll_year,
    		round(
	            ((avg(average_wages) - lag(avg(average_wages)) over (order by payroll_year))
	             / lag(avg(average_wages)) over (order by payroll_year)) * 100
         , 2  ) as wage_YoyGrowth
    from t_patrik_pagac_project_SQL_primary_final
    where calculation_code = 200
    group by payroll_year
    ),
YoyGdp  as(  
	select 
			year, 
			gdp,
			round(
				((gdp-lag(gdp)over(order by year))
				/lag(gdp)over(order by year))::numeric* 100
			,	2  )as gdp_YoyGrowth
	from t_patrik_pagac_project_SQL_secondary_final
	where country = 'Czech Republic'
)
select 
	f.payroll_year, 
	g.gdp_YoyGrowth,
	w.wage_YoyGrowth,
	f.food_YoyGrowth,
	g.gdp_YoyGrowth,
	lead(w.wage_YoyGrowth)over (order by f.payroll_year)as wage_next_year,
	lead(f.food_YoyGrowth)over (order by f.payroll_year)as food_next_year
from YoyFoodGrowth f
join YoyWageGrowth w
	on f.payroll_year=w.payroll_year
join YoyGdp g
	on f.payroll_year=g.year
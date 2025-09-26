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
    --where f.food_YoyGrowth -w.wage_YoyGrowth >5
    order by difference desc 
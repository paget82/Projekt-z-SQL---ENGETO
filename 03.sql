--3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 
 
with AvgPrices  as(
	select 
			food_category,
			payroll_year,
			round(avg(price	)::numeric, 2)as avg_price
	from t_patrik_pagac_project_SQL_primary_final
	group by food_category, payroll_year
),
YoYGrowth as(
	select 
		food_category,
		payroll_year,
		avg_price,
		lag(avg_price) over (partition by food_category order by payroll_year) as prev_price,
		round(
		(	avg_price -  lag(avg_price) over (partition by food_category order by payroll_year))/ 
		nullif(lag(avg_price) over (partition by food_category order by payroll_year  ),0)*100
		, 2)  as yoy_growth_percent
	from AvgPrices 
)
select 
	food_category,
	round(avg(yoy_growth_percent),2)as avg_growth
from YoYGrowth 
where yoy_growth_percent is not null
group  by food_category
order by avg_growth asc
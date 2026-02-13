--5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
   		
WITH yoy_food_growth AS (
	SELECT
		payroll_year,
		ROUND(((AVG(price) - LAG(AVG(price)) OVER (ORDER BY payroll_year))
		/ LAG(AVG(price)) OVER (ORDER BY payroll_year))::NUMERIC * 100, 2) AS yoy_food_growth
	FROM t_patrik_pagac_project_SQL_primary_final
	GROUP BY payroll_year
),

yoy_wage_growth AS (
	SELECT
		payroll_year,
		ROUND(((AVG(average_wages) - LAG(AVG(average_wages)) OVER (ORDER BY payroll_year))
		/ LAG(AVG(average_wages)) OVER (ORDER BY payroll_year)) * 100, 2) AS wage_yoy_growth
	FROM t_patrik_pagac_project_SQL_primary_final
	WHERE calculation_code = 200
	GROUP BY payroll_year
),

yoy_gdp AS (  
	SELECT 
		year, 
		gdp,
		ROUND(((gdp - LAG(gdp) OVER (ORDER BY year))
		/ LAG(gdp) OVER (ORDER BY year))::NUMERIC * 100, 2) AS gdp_yoy_growth
	FROM t_patrik_pagac_project_SQL_secondary_final
	WHERE country = 'Czech Republic'
)

SELECT
	f.payroll_year, 
	g.gdp_yoy_growth,
	w.wage_yoy_growth,
	f.food_yoy_growth,
	g.gdp_yoy_growth,
	LEAD(w.wage_yoy_growth) OVER (ORDER BY f.payroll_year) AS wage_next_year,
	LEAD(f.food_yoy_growth) OVER (ORDER BY f.payroll_year) AS food_next_year
FROM yoy_food_growth AS f
JOIN yoy_wage_growth AS w
	ON f.payroll_year = w.payroll_year
JOIN yoy_gdp AS g
	ON f.payroll_year = g.year;

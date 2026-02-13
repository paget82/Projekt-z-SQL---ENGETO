--2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

WITH year_income AS (   
	SELECT 
		payroll_year,
		TRUNC(AVG(average_wages)::NUMERIC, 0) AS average_salary
	FROM t_patrik_pagac_project_SQL_primary_final
	WHERE calculation_code = 200
	GROUP BY payroll_year
),

milk_bread AS (
	SELECT  
		food_category,
		ROUND(AVG(price)::NUMERIC, 1) AS average_price,
		payroll_year
	FROM t_patrik_pagac_project_SQL_primary_final
	WHERE food_category IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
	GROUP BY payroll_year, food_category
),

years_range AS (
	SELECT 
		MIN(payroll_year) AS min_year,
		MAX(payroll_year) AS max_year
	FROM milk_bread
)

SELECT
	m.food_category,
	m.payroll_year,
	y.average_salary,
	m.average_price,
	TRUNC((y.average_salary / m.average_price), 0) AS count
FROM milk_bread AS m
JOIN year_income AS y
	ON y.payroll_year = m.payroll_year
JOIN years_range AS r
	ON m.payroll_year = r.min_year 
	OR m.payroll_year = r.max_year;

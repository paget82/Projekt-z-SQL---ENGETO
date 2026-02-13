--4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

WITH food_growth AS (
	SELECT
		payroll_year,
	    ROUND(((AVG(price) - LAG(AVG(price)) OVER (ORDER BY payroll_year))
		/ LAG(AVG(price)) OVER (ORDER BY payroll_year))::NUMERIC * 100, 2) AS food_yoy_growth
	FROM t_patrik_pagac_project_SQL_primary_final
	GROUP BY payroll_year
),

wage_growth AS (
	SELECT
		payroll_year,
		ROUND(((AVG(average_wages) - LAG(AVG(average_wages)) OVER (ORDER BY payroll_year))
		/ LAG(AVG(average_wages)) OVER (ORDER BY payroll_year)) * 100, 2) AS wage_YoyGrowth
	FROM t_patrik_pagac_project_SQL_primary_final
	WHERE calculation_code = 200
	GROUP BY payroll_year
)

SELECT
	w.payroll_year,
	f.food_yoy_growth,
	w.wage_yoy_growth,
	f.food_yoy_growth -w.wage_yoy_growth AS difference
FROM food_growth AS f
JOIN wage_growth AS w
	ON w.payroll_year = f.payroll_year
WHERE f.food_yoy_growth - w.wage_yoy_growth > 5
ORDER BY difference DESC;

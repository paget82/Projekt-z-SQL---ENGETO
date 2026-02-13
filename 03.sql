--3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 
 
WITH avg_prices AS (
	SELECT
		food_category,
		payroll_year,
		ROUND(AVG(price)::NUMERIC, 2) AS avg_price
	FROM t_patrik_pagac_project_SQL_primary_final
	GROUP BY food_category, payroll_year
),

yoy_growth AS (
	SELECT
		food_category,
		payroll_year,
		avg_price,
		LAG(avg_price) OVER (PARTITION BY food_category ORDER BY payroll_year) AS prev_price,
		ROUND((avg_price -  LAG(avg_price) OVER (PARTITION BY food_category ORDER BY payroll_year)) / 
		NULLIF(LAG(avg_price) OVER (PARTITION BY food_category ORDER BY payroll_year), 0) * 100, 2) AS yoy_growth_percent
	FROM avg_prices
)

SELECT 
	food_category,
	ROUND(AVG(yoy_growth_percent), 2) AS avg_growth
FROM yoy_growth
WHERE yoy_growth_percent IS NOT NULL
GROUP BY food_category
ORDER BY avg_growth;

CREATE TABLE t_patrik_pagac_project_SQL_primary_final AS
SELECT
	cpc.name AS food_category,
	cp.value AS price,
	cpib.name AS industry,
	cp2.value AS average_wages,
	TO_CHAR(cp.date_from, 'DD, Month YYYY') AS price_mesured_from,
	TO_CHAR(cp.date_to, 'DD, Month YYYY') AS price_mesured_to,
	cp2.payroll_year,
	calculation_code
FROM czechia_price AS cp  
JOIN czechia_payroll AS cp2   
	ON DATE_PART('year', cp.date_from) = cp2.payroll_year
	AND cp2.value_type_code = 5958 
	AND cp.region_code IS NULL
JOIN czechia_price_category AS cpc  
	ON cp.category_code = cpc.code 	
JOIN czechia_payroll_industry_branch AS cpib 
	ON cp2.industry_branch_code = cpib.code  
ORDER BY payroll_year;

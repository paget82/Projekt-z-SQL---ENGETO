CREATE TABLE t_patrik_pagac_project_SQL_secondary_final AS
SELECT 
	e.country,
	c.continent,
	e.year,
	e.gdp,
	e.population,
	e.gini
FROM economies AS e
JOIN countries AS c 
	ON c.country = e.country
WHERE c.continent = 'Europe' 
	AND e.year BETWEEN '2006' AND '2018'
ORDER BY e.year;

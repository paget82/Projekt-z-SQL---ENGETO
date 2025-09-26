create table t_patrik_pagac_project_SQL_secondary_final as
	select 
		e.country,
		c.continent,
		e.year,
		e.gdp,
		e.population,
		e.gini
	from economies e
		join countries c 
		on c.country=e.country
	where 1=1
		and c.continent='Europe' 
		and e.year between '2006' and '2018'
	order by e.year asc
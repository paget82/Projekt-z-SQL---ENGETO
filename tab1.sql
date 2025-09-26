create table t_patrik_pagac_project_SQL_primary_final as
	select 
		cpc.name as food_category,
		cp.value as price,
		cpib.name as industry,
		cp2.value as average_wages,
		to_char(cp.date_from, 'DD, Month YYYY') as price_mesured_from,
		to_char(cp.date_to, 'DD, Month YYYY') as price_mesured_to,
		cp2.payroll_year,
		calculation_code
	from 
		czechia_price cp  
	join czechia_payroll cp2   
		on date_part('year', cp.date_from)=cp2.payroll_year
		and cp2.value_type_code = 5958 
		and  cp.region_code is null
	join czechia_price_category cpc  
		on cp.category_code=cpc.code 	
	join czechia_payroll_industry_branch cpib 
		on cp2.industry_branch_code=cpib.code  
	order by payroll_year asc;
SELECT DISTINCT 
year_price AS common_year,
avg_price,
percent_payroll,
percent_avg_price,
previous_percent_diff_GDP,
percent_diff_GDP 
FROM t_zuzana_salamon_project_SQL_primary_final tzspspf 
WHERE name_industry IS NULL 
	OR avg_price IS NULL
GROUP BY year_price 
ORDER BY common_year;

SELECT DISTINCT 
year_price AS common_year,
name_industry,
percent_payroll,
percent_diff_GDP 
FROM t_zuzana_salamon_project_SQL_primary_final tzspspf 
WHERE name_industry IS NULL 
ORDER BY percent_diff_GDP DESC;

SELECT DISTINCT 
year_price AS common_year,
name_industry,
percent_payroll, 
previous_percent_diff_GDP
FROM t_zuzana_salamon_project_SQL_primary_final tzspspf 
WHERE name_industry IS NULL 
ORDER BY previous_percent_diff_GDP DESC;


SELECT DISTINCT 
year_price AS common_year,
product_name,
percent_avg_price,
percent_diff_GDP
FROM t_zuzana_salamon_project_SQL_primary_final tzspspf  
WHERE percent_avg_price  IS NOT NULL
ORDER BY percent_diff_GDP DESC;

SELECT DISTINCT 
year_price AS common_year,
product_name,
percent_avg_price,
previous_percent_diff_GDP 
FROM t_zuzana_salamon_project_SQL_primary_final tzspspf  
WHERE percent_avg_price  IS NOT NULL
ORDER BY previous_percent_diff_GDP DESC;

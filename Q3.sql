SELECT DISTINCT 
first_year.product_name,
first_year.avg_price AS year_2006,
last_year.avg_price AS year_2018,
(last_year.avg_price - first_year.avg_price) AS price_difference,
((last_year.avg_price - first_year.avg_price)/first_year.avg_price)*100 AS percent_price_difference
FROM t_zuzana_salamon_project_SQL_primary_final first_year
JOIN t_zuzana_salamon_project_SQL_primary_final last_year ON last_year.product_name = first_year.product_name 
AND last_year.year_price = 2018  
WHERE first_year.product_name IS NOT NULL   
	AND first_year.year_price = 2006
ORDER BY percent_price_difference;

SELECT 
DISTINCT product_name,
percent_avg_price,
year_price 
FROM t_zuzana_salamon_project_SQL_primary_final tzspf 
WHERE product_name IS NOT NULL 
	AND percent_avg_price IS NOT NULL 	
	AND percent_avg_price > 0
ORDER BY percent_avg_price;


SELECT 
MIN (year_price),
MAX (year_price)
FROM t_zuzana_salamon_project_SQL_primary_final tzf;

-- rok 2006 a 2018 kod 111301 a 114201

SELECT 
year_price,
product_name,
price_unit,
category_code,
name_industry,
total_value_payroll,
units_for_annual_salary
FROM t_zuzana_salamon_project_SQL_primary_final tzsp
JOIN czechia_price_category cpc ON cpc.code = tzsp.category_code
WHERE category_code IN (111301,114201) AND year_price IN(2006,2018)
	AND name_industry IS NULL;
	JOIN czechia_price_category cpc ON cpc.code = tzsp.category_code;

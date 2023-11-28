
SELECT *
FROM czechia_payroll cp
ORDER BY payroll_year ;

SELECT 
*
FROM czechia_payroll cp
WHERE payroll_quarter IS NULL;

SELECT 
*
FROM czechia_payroll cp
WHERE industry_branch_code IS NOT NULL 
	AND cp.value_type_code = '5958' 
	AND cp.calculation_code = '200'
	AND cp.unit_code = '200'
ORDER BY payroll_year DESC;

CREATE TABLE t_zuzana_salamon_SQL_primary_payroll
SELECT 
AVG(value) AS total_value,
cp.industry_branch_code,							
cpib.name AS name_industry,
cp.payroll_year 
FROM czechia_payroll cp
	LEFT JOIN czechia_payroll_industry_branch cpib ON cpib.code = cp.industry_branch_code 
WHERE cp.value_type_code = '5958' 
	AND cp.calculation_code = '200'
	AND cp.unit_code = '200'
GROUP BY industry_branch_code, payroll_year;

SELECT *
FROM t_zuzana_salamon_SQL_primary_payroll tp ;

SELECT *
FROM czechia_price cp;

CREATE TABLE t_zuzana_salamon_SQL_primary_price
SELECT 
AVG(cp.value) AS avg_price,
year(date_from) AS year_price,
category_code 
FROM czechia_price cp
GROUP BY category_code, YEAR(date_from);

SELECT *
FROM t_zuzana_salamon_SQL_primary_price tc;

CREATE TABLE t_zuzana_salamon_project_SQL_payroll
SELECT 
cpib.name AS name_industry,
tp.total_value AS total_value_payroll,
tp.payroll_year, 
tp2.total_value AS previous_year,
tp.industry_branch_code,
tp.total_value - tp2.total_value AS diff_value,
100*(tp.total_value - tp2.total_value)/tp.total_value AS percent_payroll
FROM t_zuzana_salamon_SQL_primary_payroll tp
	LEFT JOIN t_zuzana_salamon_SQL_primary_payroll tp2 ON (tp2.industry_branch_code = tp.industry_branch_code 
		OR (tp2.industry_branch_code IS NULL AND tp.industry_branch_code IS NULL))
		AND tp2.payroll_year = tp.payroll_year -1
	LEFT JOIN czechia_payroll_industry_branch cpib ON cpib.code = tp.industry_branch_code;

SELECT 
*
FROM t_zuzana_salamon_project_SQL_payroll tzspsp ;

CREATE TABLE t_zuzana_salamon_project_SQL_price
SELECT 
tpc.category_code,
cpc.name AS product_name,
tpc.avg_price,
tpc.year_price,
tpc2.avg_price AS previous_avg_price,
tpc.avg_price - tpc2.avg_price AS diff_avg_price,
100*(tpc.avg_price-tpc2.avg_price)/tpc.avg_price AS percent_avg_price
FROM t_zuzana_salamon_SQL_primary_price tpc
	LEFT JOIN t_zuzana_salamon_SQL_primary_price tpc2 ON tpc2.category_code = tpc.category_code 
		AND tpc2.year_price = tpc.year_price -1
	LEFT JOIN czechia_price_category cpc ON cpc.code = tpc.category_code;

SELECT *
FROM t_zuzana_salamon_project_SQL_price tzspsp ;

CREATE TABLE t_zuzana_salamon_project_SQL_GDP
SELECT 
e.`year`,
e.GDP,
e2.GDP AS previous,
e2.GDP - e.GDP AS diff_GDP,
100*(e.GDP - e2.GDP)/e.GDP AS percent_diff_GDP
FROM economies e 
	LEFT JOIN economies e2 ON e2.`year` = e.`year` -1 AND e2.country = e.country 
WHERE e.country = 'Czech Republic';

CREATE TABLE t_zuzana_salamon_project_SQL_primary_final
SELECT 
tzsp.name_industry,
tzsp.previous_year,
tzsp.total_value_payroll,
tzsp.diff_value,
tzsp.percent_payroll,
cpc.name AS product_name,
tzspc.category_code,
tzspc.avg_price,
tzspc.diff_avg_price,
tzspc.percent_avg_price,
tzspc.year_price,
tgdp.percent_diff_GDP,
tgdp2.percent_diff_GDP AS previous_percent_diff_GDP,
ROUND(tzsp.total_value_payroll/tzspc.avg_price,2) AS units_for_annual_salary
FROM t_zuzana_salamon_project_SQL_payroll tzsp
	LEFT JOIN t_zuzana_salamon_project_SQL_price tzspc ON tzspc.year_price = tzsp.payroll_year 
	LEFT JOIN czechia_price_category cpc ON cpc.code = tzspc.category_code
	LEFT JOIN t_zuzana_salamon_project_SQL_GDP tgdp ON tgdp.`year` = tzspc.year_price 
	LEFT JOIN t_zuzana_salamon_project_SQL_GDP tgdp2 ON tgdp2.`year` = tzspc.year_price -1;
		
SELECT *
FROM t_zuzana_salamon_project_SQL_primary_final;

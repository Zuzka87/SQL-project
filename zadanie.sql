SELECT 
SUM(value) AS total_value,
industry_branch_code,
payroll_year 
FROM czechia_payroll cp
WHERE cp.value_type_code = '5958' AND cp.calculation_code = '200' AND cp.unit_code = '200'
GROUP BY industry_branch_code, payroll_year;

CREATE TABLE t_zuzana_salamon_SQL_primary_payroll
SELECT 
SUM(value) AS total_value,
industry_branch_code,
payroll_year 
FROM czechia_payroll cp
WHERE cp.value_type_code = '5958' AND cp.calculation_code = '200' AND cp.unit_code = '200'
GROUP BY industry_branch_code, payroll_year;

SELECT *
FROM t_zuzana_salamon_SQL_primary_payroll tp ;

SELECT 
tp.industry_branch_code,
tp.payroll_year,
tp.total_value - tp2.total_value
FROM t_zuzana_salamon_SQL_primary_payroll tp
JOIN t_zuzana_salamon_SQL_primary_payroll tp2 ON tp2.industry_branch_code = tp.industry_branch_code AND tp2.payroll_year = tp.payroll_year -1
WHERE tp.total_value < tp2.total_value ;

SELECT 
AVG(cp.value) AS avg_price,
year(date_from) AS year_price,
category_code 
FROM czechia_price cp
GROUP BY category_code, YEAR(date_from);

CREATE TABLE t_zuzana_salamon_SQL_primary_price
SELECT 
AVG(cp.value) AS avg_price,
year(date_from) AS year_price,
category_code 
FROM czechia_price cp
GROUP BY category_code, YEAR(date_from);

SELECT *
FROM t_zuzana_salamon_SQL_primary_price tc;

SELECT 
min(year_price),
max(year_price)
FROM t_zuzana_salamon_SQL_primary_price tc;

SELECT 
tc.category_code,
tc.year_price,
tp.industry_branch_code,
tp.total_value/tc.avg_price 
FROM t_zuzana_salamon_SQL_primary_price tc
JOIN t_zuzana_salamon_SQL_primary_payroll tp ON tp.payroll_year = tc.year_price 
WHERE tc.category_code IN(111301,114201) AND tc.year_price IN(2006,2018);

SELECT 
tc.year_price,
tc.category_code,
cpc.name AS name_product,
100*(tc.avg_price - tc2.avg_price)/tc.avg_price AS percent
FROM t_zuzana_salamon_SQL_primary_price tc
JOIN t_zuzana_salamon_SQL_primary_price tc2 ON tc2.category_code = tc.category_code AND tc2.year_price = tc.year_price -1
JOIN czechia_price_category cpc ON cpc.code = tc.category_code
WHERE tc.avg_price > tc2.avg_price
ORDER BY (tc.avg_price - tc2.avg_price)/tc.avg_price;

CREATE TABLE t_zuzana_salamon_SQL_primary_price2
SELECT 
tc.year_price,
tc.category_code,
cpc.name AS name_product,
100*(tc.avg_price - tc2.avg_price)/tc.avg_price AS percent
FROM t_zuzana_salamon_SQL_primary_price tc
JOIN t_zuzana_salamon_SQL_primary_price tc2 ON tc2.category_code = tc.category_code AND tc2.year_price = tc.year_price -1
JOIN czechia_price_category cpc ON cpc.code = tc.category_code
WHERE tc.avg_price > tc2.avg_price
ORDER BY (tc.avg_price - tc2.avg_price)/tc.avg_price;

SELECT *
FROM t_zuzana_salamon_SQL_primary_price2;

SELECT 
tp.total_value,
tp.industry_branch_code,
tp.payroll_year,
100*(tp.total_value - tp2.total_value)/tp.total_value AS percent_payroll
FROM t_zuzana_salamon_SQL_primary_payroll tp
JOIN t_zuzana_salamon_SQL_primary_payroll tp2 ON tp2.industry_branch_code = tp.industry_branch_code AND tp2.payroll_year = tp.payroll_year -1;

CREATE TABLE t_zuzana_salamon_SQL_primary_payroll2
SELECT 
tp.total_value,
tp.industry_branch_code,
tp.payroll_year,
100*(tp.total_value - tp2.total_value)/tp.total_value AS percent_payroll
FROM t_zuzana_salamon_SQL_primary_payroll tp
JOIN t_zuzana_salamon_SQL_primary_payroll tp2 ON tp2.industry_branch_code = tp.industry_branch_code AND tp2.payroll_year = tp.payroll_year -1;

SELECT *
FROM t_zuzana_salamon_SQL_primary_payroll2 tp2;

SELECT *
FROM t_zuzana_salamon_SQL_primary_payroll2 tp2
JOIN t_zuzana_salamon_SQL_primary_price2 tc2 ON tc2.year_price = tp2.payroll_year; 

SELECT 
DISTINCT tc2.year_price 
FROM t_zuzana_salamon_SQL_primary_payroll2 tp2
JOIN t_zuzana_salamon_SQL_primary_price2 tc2 ON tc2.year_price = tp2.payroll_year
WHERE tc2.percent - tp2.percent_payroll > 10
ORDER BY tc2.percent - tp2.percent_payroll DESC; 

SELECT
e.`year`, 
100*(e.GDP - e2.GDP)/e.GDP,
tp2.industry_branch_code,
tp2.percent_payroll,
tc2.name_product,
tc2.percent 
FROM economies e
JOIN economies e2 ON e2.`year` = e.`year` -1 AND e2.country = e.country 
JOIN t_zuzana_salamon_SQL_primary_payroll2 tp2 ON tp2.payroll_year = e.`year` 
JOIN t_zuzana_salamon_SQL_primary_price2 tc2 ON tc2.year_price = e.`year` 
WHERE e.country = 'Czech Republic';





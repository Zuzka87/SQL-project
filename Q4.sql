SELECT DISTINCT 
tzp.year_price,
tzp.percent_payroll,
tzp.percent_avg_price,
tzp.percent_avg_price - tzp.percent_payroll AS increase
FROM t_zuzana_salamon_project_SQL_primary_final tzp
WHERE tzp.percent_payroll > 0
	AND tzp.percent_avg_price > 0
	AND (tzp.percent_avg_price - tzp.percent_payroll) > 10
GROUP BY tzp.year_price 
ORDER BY increase;

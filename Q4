SELECT
tzp.year_price,
tzp.name_industry,
tzp.percent_payroll,
tzp.product_name,
tzp.percent_avg_price,
tzp.percent_payroll - tzp.percent_avg_price AS increase
FROM t_zuzana_salamon_project_SQL_primary_final tzp
WHERE tzp.percent_payroll > 0
	AND tzp.percent_avg_price > 0
	AND (tzp.percent_payroll - tzp.percent_avg_price) > 10
ORDER BY increase;

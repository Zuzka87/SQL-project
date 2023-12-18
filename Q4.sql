SELECT DISTINCT
tzp.year_price,
avg (tzp.percent_avg_price),
avg (tzp.percent_payroll),
avg (tzp.percent_avg_price) - avg (tzp.percent_payroll) AS increase
FROM t_zuzana_salamon_project_SQL_primary_final tzp
WHERE tzp.name_industry IS NULL
GROUP BY tzp.year_price
ORDER BY increase DESC;

SELECT 
MIN (year_price),
MAX (year_price)
FROM t_zuzana_salamon_project_SQL_primary_final tzf;

CREATE TABLE t_zuzana_salamon_project_SQL_secondary_final
SELECT 
e.country,
e.GDP AS HDP,
e.gini AS GINI,
e.`year`,
c.population 
FROM economies e
    JOIN countries c ON c.country = e.country 
WHERE e.country != 'Czech Republic' 
		AND e.`year` BETWEEN 2006 AND 2018;

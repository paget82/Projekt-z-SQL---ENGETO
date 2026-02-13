--1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

WITH list AS (
    SELECT 
        industry,
        payroll_year,
        AVG(average_wages) AS average_salary
    FROM t_patrik_pagac_project_SQL_primary_final
    WHERE calculation_code = 200
    GROUP BY industry, payroll_year

)
SELECT
    industry,
    payroll_year,
    average_salary,
    LAG(average_salary) OVER (PARTITION BY industry ORDER BY payroll_year) AS average_salary_last_year,
    average_salary - LAG(average_salary) OVER (PARTITION BY industry ORDER BY payroll_year) AS difference,
    CASE
        WHEN average_salary - LAG(average_salary) OVER (PARTITION BY industry ORDER BY payroll_year) > 0 THEN 'increases'
        WHEN average_salary - LAG(average_salary) OVER (PARTITION BY industry ORDER BY payroll_year) = 0 THEN 'stagnates'
        WHEN average_salary - LAG(average_salary) OVER (PARTITION BY industry ORDER BY payroll_year) < 0 THEN 'decreases'
        ELSE 'unknown'
    END AS trend
FROM list
ORDER BY industry, payroll_year;

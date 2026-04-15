WITH salary_agg AS (
    SELECT
        company_id,
        AVG(salary_year_avg) AS average_salary,
        ARRAY_AGG(salary_year_avg) AS salaries_array
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    GROUP BY company_id
),
salary_flat AS (
    SELECT
        company_id,
        average_salary,
        UNNEST(salaries_array) AS salary
    FROM salary_agg
)
SELECT
    company_id,
    salary,
    average_salary
FROM salary_flat
WHERE salary > (average_salary * 1.5);
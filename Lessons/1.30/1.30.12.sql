WITH salary_scale AS (
    SELECT
        job_id,
        job_title_short,
        salary_year_avg,
        MIN(salary_year_avg) OVER (PARTITION BY job_title_short) AS min_salary,
        MAX(salary_year_avg) OVER (PARTITION BY job_title_short) AS max_salary
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
)

SELECT
    *,
    ((salary_year_avg - min_salary)/NULLIF(max_salary - min_salary, 0)) AS normalised_salary 
FROM
    salary_scale;
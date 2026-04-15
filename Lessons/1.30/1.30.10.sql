WITH salaries_variation AS (
    SELECT
        job_title_short,
        job_posted_date,
        salary_year_avg,
        LEAD(salary_year_avg) OVER(
            PARTITION BY job_title_short
            ORDER BY job_posted_date
        ) AS prev_salary
    FROM 
        job_postings_fact
    WHERE salary_year_avg IS NOT NULL
)

SELECT
    job_title_short,
    job_posted_date,
    salary_year_avg,
    salary_year_avg - prev_salary AS salary_lag
FROM salaries_variation;

SELECT
    job_title_short,
    salary_year_avg,
    LEAD(salary_year_avg) OVER(
        PARTITION BY job_title_short
        ORDER BY job_posted_date
    ) next_salary,
    CASE
        WHEN salary_year_avg > next_salary THEN 'Decreasing'
        WHEN salary_year_avg < next_salary THEN 'Increasing'
        ELSE 'Stable'
    END AS trend_direction
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL;
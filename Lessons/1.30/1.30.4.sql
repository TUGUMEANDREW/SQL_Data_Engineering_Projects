SELECT
    company_id,
    job_posted_date,
    salary_year_avg,
    SUM(salary_year_avg) OVER(
        PARTITION BY company_id
        ORDER BY job_posted_date) AS running_salary_total
FROM
    job_postings_fact
WHERE   
    salary_year_avg IS NOT NULL
ORDER BY 
    job_posted_date;
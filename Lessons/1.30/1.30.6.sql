SELECT *
FROM (
    SELECT
        job_id,
        job_title_short,
        salary_year_avg,
        RANK() OVER (
            PARTITION BY job_title_short
            ORDER BY salary_year_avg DESC
        ) AS rank
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL)
WHERE rank <= 3;
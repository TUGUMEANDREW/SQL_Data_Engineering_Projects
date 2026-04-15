WITH posting_intervals AS (
    SELECT
        company_id,
        job_posted_date,
        LAG(job_posted_date) OVER(
            PARTITION BY company_id
            ORDER BY job_posted_date
            ) AS prev_date 
    FROM job_postings_fact
)

SELECT
    company_id,
    job_posted_date,
    prev_date,
    job_posted_date - prev_date AS days_between_postings
FROM posting_intervals
WHERE prev_date IS NOT NULL;
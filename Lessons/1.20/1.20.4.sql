SELECT
    job_posted_date,
    company_id,
    job_title_short,
    job_posted_date::DATE AS dt,
    company_id::STRING || '-' || job_posted_date::DATE::STRING AS compound_key
FROM
    job_postings_fact
LIMIT 10; 
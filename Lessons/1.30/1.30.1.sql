SELECT
    job_id,
    job_posted_date,
    ROW_NUMBER() OVER () AS global_row_id
FROM job_postings_fact
ORDER BY job_posted_date;
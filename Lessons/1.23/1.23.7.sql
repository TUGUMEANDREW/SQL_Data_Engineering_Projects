SELECT
    src.name AS company_name
FROM
    data_jobs.company_dim AS src
WHERE EXISTS (
    SELECT 1
    FROM data_jobs.job_postings_fact AS tgt
    WHERE src.company_id = tgt.company_id
);

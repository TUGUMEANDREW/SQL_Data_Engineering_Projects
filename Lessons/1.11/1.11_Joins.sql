SELECT
    jpf.job_id,
    cd.name,
    jpf.job_title_short
FROM job_postings_fact AS jpf
    LEFT JOIN company_dim AS cd
        ON jpf.company_id = cd.company_id;
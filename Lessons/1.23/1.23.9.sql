SELECT
    sd.skills
FROM
    data_jobs.skills_dim AS sd
WHERE NOT EXISTS (
    SELECT 1
    FROM data_jobs.skills_job_dim AS sjd
    INNER JOIN data_jobs.job_postings_fact AS jpf
        ON sjd.job_id = jpf.job_id
    WHERE sjd.skill_id = sd.skill_id
        AND jpf.job_title_short = 'Senior Data Engineer'
);
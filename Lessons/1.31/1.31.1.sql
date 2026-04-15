SELECT
    jpf.job_id,
    jpf.job_title_short,
    ARRAY_LENGTH(ARRAY_AGG(sjd.skill_id)) AS skill_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
GROUP BY
    jpf.job_id,
    jpf.job_title_short
HAVING ARRAY_LENGTH(ARRAY_AGG(sjd.skill_id)) > 12
ORDER BY skill_count DESC;
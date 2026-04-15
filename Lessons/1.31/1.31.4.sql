WITH job_skill_counts AS (
    SELECT
        jpf.job_id,
        jpf.job_title_short,
        ARRAY_LENGTH(ARRAY_AGG(sjd.skill_id)) AS skill_count
    FROM job_postings_fact AS jpf
    LEFT JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    WHERE job_title_short IN ('Data Engineer', 'Data Analyst')
    GROUP BY 
        jpf.job_id,
        jpf.job_title_short
)

SELECT
    job_title_short,
    AVG(skill_count) AS avg_skill_count
FROM job_skill_counts
GROUP BY job_title_short
ORDER BY avg_skill_count DESC;

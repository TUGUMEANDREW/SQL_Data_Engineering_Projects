CREATE TEMPORARY TABLE ds_skills_count_temp AS
SELECT
    sd.skills,
    COUNT(sjd.job_id) AS skill_count
FROM data_jobs.skills_dim AS sd
INNER JOIN data_jobs.skills_job_dim AS sjd ON sd.skill_id = sjd.skill_id
INNER JOIN data_jobs.job_postings_fact AS jpf ON sjd.job_id = jpf.job_id
WHERE job_title_short = 'Data Scientist'
GROUP BY
    sd.skills;

SELECT *
FROM ds_skills_count_temp
ORDER BY 
    skill_count DESC;
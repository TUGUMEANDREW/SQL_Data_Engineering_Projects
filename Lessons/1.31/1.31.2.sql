SELECT
    cd.name AS company_name,
    ARRAY_AGG(DISTINCT jpf.job_location) AS hiring_locations
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd ON jpf.company_id = cd.company_id
GROUP BY cd.name;
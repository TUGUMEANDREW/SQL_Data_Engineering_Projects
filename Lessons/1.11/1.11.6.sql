EXPLAIN ANALYZE
SELECT
    cd.company_id,
    cd.name AS company_name,
    COUNT(jpf.job_id) AS posting_count
FROM
    job_postings_fact AS jpf
    LEFT JOIN company_dim AS cd
        ON jpf.company_id = cd.company_id
WHERE
    job_country = 'United States'
GROUP BY
    cd.company_id,
    cd.name
HAVING
    COUNT(jpf.job_id) > 3_000
ORDER BY
    COUNT(jpf.job_id) DESC;
SELECT *
FROM information_schema.tables
WHERE table_name = 'job_postings_fact';

SELECT
    table_name,
    constraint_name,
    COUNT(table_name) AS constraint_name_count
FROM information_schema.key_column_usage
WHERE table_catalog = 'data_jobs'
GROUP BY
    table_name,
    constraint_name
HAVING
    COUNT(table_name) > 1;
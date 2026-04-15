/*  Count the total number of job postings from December 2024, grouped by job title and whether 
a degree is mentioned.You will analyze these requirements by converting the Boolean degree flag 
into an Integer (0 or 1) to segment the data. */

SELECT
    job_title_short,
    job_no_degree_mention::INT,
    COUNT(job_id) AS job_postings
FROM
    job_postings_fact
WHERE
    job_posted_date::DATE BETWEEN '2024-12-01' AND '2024-12-31'
GROUP BY
    job_title_short,
    job_no_degree_mention::INTEGER
ORDER BY
    job_title_short,
    job_no_degree_mention::INTEGER;

ALTER TABLE dev.applications_fact
RENAME COLUMN follow_up_timestamp TO follow_up_date;

SELECT *
FROM dev.applications_fact;

DESCRIBE dev.applications_fact;
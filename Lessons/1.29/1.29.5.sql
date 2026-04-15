SELECT
    name,
    LOWER(TRIM(name)) AS normalized_name
FROM company_dim;
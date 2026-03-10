INSERT INTO SILVER_LOANS_MASTER
SELECT
    loan_id,
    customer_id,
    UPPER(TRIM(loan_type)) AS loan_type,
    principal_amount,
    interest_rate,
    emi_amount,
    TO_DATE(sanction_date) AS sanction_date,
    UPPER(TRIM(status)) AS status,
    dpd_days,
    current_timestamp
FROM sh_bronze.bronze_loans_MASTER_RAW
WHERE loan_id IS NOT NULL
AND customer_id IS NOT NULL
AND principal_amount > 0
AND interest_rate BETWEEN 0 AND 30
AND dpd_days >= 0;

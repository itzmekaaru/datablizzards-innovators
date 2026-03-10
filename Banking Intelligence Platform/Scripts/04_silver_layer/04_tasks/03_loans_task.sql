CREATE OR REPLACE TASK LOAD_SILVER_LOANS
WAREHOUSE = SNOWFLAKE_LEARNING_WH
WHEN SYSTEM$STREAM_HAS_DATA('BRONZE_LOANS_STREAM')
AS
INSERT INTO SILVER_LOANS_MASTER
SELECT
    loan_id,
    customer_id,
    UPPER(TRIM(loan_type)) AS loan_type,
    principal_amount,
    interest_rate,
    emi_amount,
    TO_DATE(sanction_date),
    UPPER(TRIM(status)),
    dpd_days,
    inserted_timestamp
FROM BRONZE_LOANS_STREAM
WHERE METADATA$ACTION = 'INSERT'

AND loan_id IS NOT NULL
AND customer_id IS NOT NULL
AND principal_amount > 0
AND interest_rate BETWEEN 0 AND 30
AND emi_amount > 0
AND dpd_days >= 0
AND sanction_date <= CURRENT_DATE
AND UPPER(TRIM(status)) IN ('ACTIVE','CLOSED','NPA')
AND UPPER(TRIM(loan_type)) IN ('GOLD','PERSONAL','EDUCATION','AUTO','HOME');
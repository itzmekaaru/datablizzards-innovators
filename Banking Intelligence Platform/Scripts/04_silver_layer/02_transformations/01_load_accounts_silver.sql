INSERT INTO HACKATHON_DB.SH_SILVER.SILVER_ACCOUNTS_MASTER
SELECT
    account_id,
    customer_id,
    customer_name,
    LOWER(email),
    phone,
    address,
    state,
    account_type,
    account_status,
    TRY_TO_DATE(open_date),
    TRY_TO_DATE(close_date),
    credit_score,
    kyc_status,
    CURRENT_TIMESTAMP
FROM HACKATHON_DB.SH_BRONZE.BRONZE_ACCOUNTS_MASTER_RAW
WHERE
account_id IS NOT NULL
AND customer_id IS NOT NULL
AND email LIKE '%@%.%'
AND LENGTH(phone) = 10
AND credit_score BETWEEN 300 AND 900
AND account_status IN ('ACTIVE','DORMANT','CLOSED')
AND kyc_status IN ('VERIFIED','PENDING','REJECTED');
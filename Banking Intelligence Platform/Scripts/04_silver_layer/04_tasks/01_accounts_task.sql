CREATE OR REPLACE TASK accounts_silver_task
WAREHOUSE = COMPUTE_WH
WHEN SYSTEM$STREAM_HAS_DATA('accounts_stream')
AS

MERGE INTO HACKATHON_DB.SH_SILVER.SILVER_ACCOUNTS_MASTER T
USING (
    SELECT *
    FROM accounts_stream
    WHERE
    account_id IS NOT NULL
    AND credit_score BETWEEN 300 AND 900
) S
ON T.account_id = S.account_id

WHEN NOT MATCHED THEN
INSERT (
    account_id,
    customer_id,
    customer_name,
    email,
    phone,
    address,
    state,
    account_type,
    account_status,
    open_date,
    close_date,
    credit_score,
    kyc_status,
    load_timestamp
)
VALUES (
    S.account_id,
    S.customer_id,
    S.customer_name,
    LOWER(S.email),
    S.phone,
    S.address,
    S.state,
    S.account_type,
    S.account_status,
    TRY_TO_DATE(S.open_date),
    TRY_TO_DATE(S.close_date),
    S.credit_score,
    S.kyc_status,
    CURRENT_TIMESTAMP
);
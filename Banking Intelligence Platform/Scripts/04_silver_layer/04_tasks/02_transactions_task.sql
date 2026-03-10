CREATE OR REPLACE TASK SH_SILVER.TASK_TRANSACTIONS_INCREMENTAL
WAREHOUSE = SNOWFLAKE_LEARNING_WH
WHEN SYSTEM$STREAM_HAS_DATA('SH_BRONZE.STREAM_TRANSACTIONS_BRONZE')
AS

MERGE INTO SH_SILVER.SILVER_TRANSACTIONS_MASTER T
USING
(
SELECT
TRIM(txn_id) AS txn_id,
TRIM(account_id) AS account_id,
CAST(timestamp AS TIMESTAMP) AS timestamp,
UPPER(TRIM(txn_type)) AS txn_type,
UPPER(TRIM(channel)) AS channel,

CASE 
WHEN amount < 0 THEN NULL
ELSE amount
END AS amount,

UPPER(TRIM(merchant_category)) AS merchant_category,
UPPER(TRIM(device_info)) AS device_info,
TRIM(ip_address) AS ip_address,

CASE
WHEN is_flagged = 1 THEN TRUE
WHEN is_flagged = 0 THEN FALSE
ELSE FALSE
END AS is_flagged,

CURRENT_TIMESTAMP AS load_timestamp

FROM SH_BRONZE.STREAM_TRANSACTIONS_BRONZE
WHERE txn_id IS NOT NULL
AND account_id IS NOT NULL
AND amount IS NOT NULL
) S

ON T.txn_id = S.txn_id

WHEN NOT MATCHED THEN INSERT
VALUES
(
S.txn_id,
S.account_id,
S.timestamp,
S.txn_type,
S.channel,
S.amount,
S.merchant_category,
S.device_info,
S.ip_address,
S.is_flagged,
CURRENT_TIMESTAMP
);
INSERT INTO SH_SILVER.SILVER_TRANSACTIONS_MASTER
(
    txn_id,
    account_id,
    timestamp,
    txn_type,
    channel,
    amount,
    merchant_category,
    device_info,
    ip_address,
    is_flagged,
    load_timestamp
)

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

FROM SH_BRONZE.BRONZE_TRANSACTIONS_MASTER_RAW

WHERE txn_id IS NOT NULL
AND account_id IS NOT NULL
AND amount IS NOT NULL;
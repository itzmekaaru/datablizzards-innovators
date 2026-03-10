CREATE OR REPLACE TABLE SILVER_TRANSACTIONS_MASTER (
    txn_id STRING,
    account_id STRING,
    timestamp TIMESTAMP,
    txn_type STRING,
    channel STRING,
    amount NUMBER(18,2),
    merchant_category STRING,
    device_info STRING,
    ip_address STRING,
    is_flagged BOOLEAN,
    load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
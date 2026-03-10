CREATE OR REPLACE TABLE SILVER_ACCOUNTS_MASTER (
    account_id STRING,
    customer_id STRING,
    customer_name STRING,
    email STRING,
    phone NUMBER,
    address STRING,
    state STRING,
    account_type STRING,
    account_status STRING,
    open_date DATE,
    close_date DATE,
    credit_score NUMBER,
    kyc_status STRING,
    load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
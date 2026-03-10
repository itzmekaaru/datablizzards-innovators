CREATE OR REPLACE TABLE SH_BRONZE.BRONZE_LOANS_MASTER_RAW (
    loan_id STRING,
    customer_id STRING,
    loan_type STRING,
    principal_amount NUMBER(18,2),
    interest_rate NUMBER(5,2),
    emi_amount NUMBER(18,2),
    sanction_date DATE,
    status STRING,
    dpd_days NUMBER,
    load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
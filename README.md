# Banking Intelligence Platform using Snowflake Medallion Architecture

## Overview

This project implements a **modern data engineering pipeline using Snowflake Medallion Architecture** to build a banking analytics platform.
The system ingests raw banking datasets, performs validation and transformations, and generates business intelligence KPIs for different stakeholders.

The platform supports **incremental data processing, fraud monitoring, credit risk analysis, and customer activity insights** using Snowflake features such as **Streams, Tasks, Stored Procedures, and Role-Based Access Control (RBAC)**.

---

# Problem Statement

Banks generate large volumes of transactional and customer data.
However, raw data alone cannot provide business insights.

The objective of this project is to design and implement a **scalable data platform** that:

* Ingests banking data from external storage
* Validates and cleans the data
* Detects fraud patterns
* Analyzes credit risk and loan health
* Provides stakeholder-specific dashboards

---

# Architecture Overview

The system follows the **Medallion Architecture pattern**.

```
External Data (AWS S3)
        │
        ▼
Snowflake Stage
        │
        ▼
Bronze Layer (Raw Data)
        │
        ▼
Silver Layer (Validated & Cleaned Data)
        │
        ▼
Gold Layer (Business KPIs / Data Marts)
        │
        ▼
Stakeholder Dashboards
```

---

# Medallion Data Layers

## Bronze Layer – Raw Data

The Bronze layer stores **raw ingested data without transformations**.

Tables:

* `BRONZE_ACCOUNTS_MASTER_RAW`
* `BRONZE_TRANSACTIONS_MASTER_RAW`
* `BRONZE_LOANS_MASTER_RAW`

Data is loaded using **Snowflake COPY INTO** from external stage.

Purpose:

* Preserve original source data
* Enable reproducibility
* Support reprocessing if required

---

## Silver Layer – Cleaned & Validated Data

The Silver layer applies **data quality checks and transformations**.

Tables:

* `SILVER_ACCOUNTS_MASTER`
* `SILVER_TRANSACTIONS_MASTER`
* `SILVER_LOANS_MASTER`

### Validation Examples

Accounts

* account_id must not be null
* credit_score must be between 300 and 900
* email must be valid

Transactions

* txn_id must not be null
* amount must be positive
* timestamp must be valid

Loans

* principal_amount must be greater than 0
* interest_rate must be between 0 and 30
* dpd_days must be non-negative

### Incremental Processing

Snowflake features used:

* **Streams** for change data capture
* **Tasks** for automated incremental loads
* **MERGE statements** for upsert logic

This ensures that **new data automatically flows from Bronze to Silver**.

---

## Gold Layer – Business KPIs

The Gold layer contains **aggregated analytics datasets** used by dashboards.

Tables:

* `FRAUD_PROBABILITY_SCORE`
* `CUSTOMER_CREDIT_RISK`
* `SAVINGS_ACTIVITY_RATIO`
* `LOAN_HEALTH_INDEX`
* `CHANNEL_ATV`

A stored procedure calculates these KPIs from the Silver layer.

---

# Key Business KPIs

### Fraud Probability Score

Detect suspicious accounts based on transaction patterns.

Example logic:

* High-value transactions (>50,000)
* Multiple high-value transactions increase risk

---

### Customer Credit Risk

Customer risk classification based on:

* Credit score
* Number of loans
* Loan repayment behavior

Categories:

* Low Risk
* Medium Risk
* High Risk

---

### Savings Activity Ratio

Measures customer engagement in savings accounts.

Activity Levels:

* High Activity
* Medium Activity
* Low Activity

---

### Loan Health Index

Monitors loan repayment behavior.

Loan status:

* Healthy
* Delinquent (DPD > 30)

---

### Channel Average Transaction Value

Analyzes transaction patterns across channels:

* ATM
* UPI
* NetBanking
* POS

---

# Data Governance

The platform implements governance mechanisms to protect sensitive data.

### Dynamic Data Masking

Customer phone numbers are masked for non-admin roles.

Example policy:

```
MASK_PHONE_NUMBER
```

---

### Role-Based Access Control (RBAC)

Three stakeholder roles are created:

| Role             | Access                      |
| ---------------- | --------------------------- |
| Fraud Analyst    | Fraud KPIs                  |
| Risk Manager     | Credit and loan risk        |
| Business Analyst | Customer activity analytics |

Each role accesses only **specific views (data marts)**.

---

# Stakeholder Data Marts

Views created for each role.

Fraud Analyst:

```
VW_FRAUD_DASHBOARD
```

Risk Manager:

```
VW_RISK_DASHBOARD
```

Business Analyst:

```
VW_BUSINESS_DASHBOARD
```

This ensures **secure and role-specific analytics access**.

---

# Dashboard KPIs

The analytics dashboard includes the following tiles:

1. Fraud Risk Distribution
2. High Value Transactions
3. Customer Credit Risk Segmentation
4. Loan Portfolio Health
5. Savings Activity Levels
6. Transaction Channel Analysis

---

# Technologies Used

| Technology        | Purpose                 |
| ----------------- | ----------------------- |
| Snowflake         | Data warehouse          |
| AWS S3            | Data storage            |
| SQL               | Data transformation     |
| Snowflake Streams | Change data capture     |
| Snowflake Tasks   | Automation              |
| RBAC              | Security and governance |

---

# Project Pipeline

```
AWS S3 → Snowflake Stage
        ↓
COPY INTO
        ↓
Bronze Tables (Raw Data)
        ↓
Streams
        ↓
Tasks + MERGE
        ↓
Silver Tables (Clean Data)
        ↓
Stored Procedure
        ↓
Gold KPI Tables
        ↓
Role-Based Views
        ↓
Dashboards
```

---

# Repository Structure

```
banking-medallion-snowflake/
│
├── README.md
├── architecture/
├── sql/
│   ├── setup
│   ├── ingestion
│   ├── silver_layer
│   ├── gold_layer
│   └── data_marts
├── dashboards/
├── docs/
└── datasets/
```

---

# Key Snowflake Features Demonstrated

* Medallion Data Architecture
* External Stage Integration
* COPY INTO Data Ingestion
* Data Quality Validation
* Incremental Processing using Streams
* Automated Pipelines using Tasks
* Stored Procedures for KPI Generation
* Role-Based Access Control
* Dynamic Data Masking

---

# Future Enhancements

Possible improvements:

* Real-time fraud detection
* Machine learning-based risk scoring
* Near real-time streaming ingestion
* Advanced anomaly detection models

---

# Author

Developed as part of a **Banking Data Engineering Hackathon Project** demonstrating a scalable analytics platform using Snowflake.

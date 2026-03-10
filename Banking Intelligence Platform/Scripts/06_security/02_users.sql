create user fraud_user;
create user risk_user;
create user business_user;

GRANT ROLE FRAUD_ANALYST_ROLE TO USER fraud_user;
GRANT ROLE RISK_MANAGER_ROLE TO USER risk_user;
GRANT ROLE BUSINESS_ANALYST_ROLE TO USER business_user;
CREATE OR REPLACE VIEW SH_GOLD.VW_RISK_DASHBOARD AS
SELECT
c.customer_id,
c.risk_category,
l.loan_status,
l.principal_amount,
l.dpd_days,
l.load_timestamp
FROM SH_GOLD.CUSTOMER_CREDIT_RISK c
LEFT JOIN SH_GOLD.LOAN_HEALTH_INDEX l
ON c.customer_id = l.customer_id;

GRANT SELECT ON VIEW SH_GOLD.VW_RISK_DASHBOARD
TO ROLE RISK_MANAGER_ROLE;
COPY INTO "HACKATHON_DB"."SH_BRONZE"."BRONZE_ACCOUNTS_MASTER_RAW"
FROM (
    SELECT $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, null
    FROM '@"HACKATHON_DB"."SH_STAGES"."STAGE_CSV"'
)
FILES = ('Rajalakshmi_Engineering_College_Banking_Usecase/accounts_master.csv')
FILE_FORMAT = (format_name = file_csv)
ON_ERROR=ABORT_STATEMENT;
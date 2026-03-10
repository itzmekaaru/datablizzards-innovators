COPY INTO "HACKATHON_DB"."SH_BRONZE"."BRONZE_LOANS_MASTER_RAW"
FROM (
    SELECT null, null, null, null, null, null, null, null, null, null
    FROM '@"HACKATHON_DB"."SH_STAGES"."STAGE_CSV"'
)
FILES = ('Rajalakshmi_Engineering_College_Banking_Usecase/loans_master.csv')
FILE_FORMAT = (
    TYPE=CSV,
    SKIP_HEADER=-1,
    FIELD_DELIMITER=',',
    TRIM_SPACE=TRUE,
    FIELD_OPTIONALLY_ENCLOSED_BY='"',
    REPLACE_INVALID_CHARACTERS=TRUE,
    DATE_FORMAT=AUTO,
    TIME_FORMAT=AUTO,
    TIMESTAMP_FORMAT=AUTO
)
ON_ERROR=ABORT_STATEMENT;
-- For more details, see: https://docs.snowflake.com/en/sql-reference/sql/copy-into-table
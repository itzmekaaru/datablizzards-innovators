CREATE OR REPLACE STAGE stage_csv
    storage_integration = storage_int
    URL =  's3://datablizzards-hackathon-s3-bucket/Rajalakshmi_Engineering_College_Banking_Usecase/'
    file_format = file_csv
;

desc stage stage_csv;

LIST @stage_csv;
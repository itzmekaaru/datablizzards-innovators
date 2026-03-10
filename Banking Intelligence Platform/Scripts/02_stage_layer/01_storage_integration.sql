CREATE OR REPLACE STORAGE INTEGRATION storage_int
    TYPE = external_stage
    STORAGE_ALLOWED_LOCATIONS = ('s3://datablizzards-hackathon-s3-bucket/Rajalakshmi_Engineering_College_Banking_Usecase/')
    ENABLED = true
    STORAGE_PROVIDER = S3
    STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::161438779444:role/hackathon-prac-role'
;
DESC INTEGRATION storage_int ;
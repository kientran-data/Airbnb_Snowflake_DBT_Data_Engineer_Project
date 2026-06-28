USE DATABASE AIRBNB;
USE SCHEMA STAGING;

-- 1. Create File Format
CREATE OR REPLACE FILE FORMAT csv_format
  TYPE = 'CSV' 
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;

-- 2. Create the Stage
CREATE OR REPLACE STAGE snowstage
  FILE_FORMAT = csv_format
  URL='s3://snowbucket-airbnb-kien/source/';
    
-- 3. Ingest Bookings
COPY INTO bookings
FROM @snowstage
FILES=('bookings.csv')
CREDENTIALS=(aws_key_id = '<access_key>', aws_secret_key = '<secret_key>');

-- 4. Ingest Hosts
COPY INTO hosts
FROM @snowstage
FILES=('hosts.csv')
CREDENTIALS=(aws_key_id = '<access_key>', aws_secret_key = '<secret_key>');

-- 5. Ingest Listings
COPY INTO listings
FROM @snowstage
FILES=('listings.csv')
CREDENTIALS=(aws_key_id = '<access_key>', aws_secret_key = '<secret_key>')
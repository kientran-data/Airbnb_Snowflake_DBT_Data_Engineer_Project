-- 1. Setup Database and Schema
CREATE DATABASE IF NOT EXISTS AIRBNB;
USE DATABASE AIRBNB;

CREATE SCHEMA IF NOT EXISTS STAGING;
USE SCHEMA STAGING;

-- 2. Create Table Structures
CREATE OR REPLACE TABLE bookings (
    booking_id VARCHAR,
    listing_id VARCHAR,
    booking_date DATE,
    nights_booked INT,
    booking_amount FLOAT,
    cleaning_fee FLOAT,
    service_fee FLOAT,
    booking_status VARCHAR,
    created_at TIMESTAMP
);

CREATE OR REPLACE TABLE hosts (
    host_id VARCHAR,
    host_name VARCHAR,
    host_since DATE,
    is_superhost VARCHAR,
    response_rate FLOAT,
    created_at TIMESTAMP
);

CREATE OR REPLACE TABLE listings (
    listing_id VARCHAR,
    host_id VARCHAR,
    property_type VARCHAR,
    room_type VARCHAR,
    city VARCHAR,
    country VARCHAR,
    accommodates INT,
    bedrooms INT,
    bathrooms INT,
    price_per_night FLOAT,
    created_at TIMESTAMP
);
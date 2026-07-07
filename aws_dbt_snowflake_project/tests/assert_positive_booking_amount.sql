-- This test checks if there are any negative booking amounts.
-- If this query returns ANY rows, dbt will fail the test.

SELECT 
    booking_id, 
    total_booking_amount
FROM {{ ref('silver_bookings') }}
WHERE total_booking_amount < 0
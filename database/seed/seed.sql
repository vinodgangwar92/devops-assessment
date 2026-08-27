INSERT INTO hotel_bookings
(org_id, hotel_id, city, checkin_date, checkout_date, amount, status, created_at)
SELECT
    ('00000000-0000-0000-0000-' || LPAD((i % 5 + 1)::text, 12, '0'))::uuid,
    'HOTEL-' || (i % 10 + 1),
    CASE i % 5
        WHEN 0 THEN 'delhi'
        WHEN 1 THEN 'mumbai'
        WHEN 2 THEN 'bangalore'
        WHEN 3 THEN 'pune'
        ELSE 'hyderabad'
    END,
    CURRENT_DATE + (i % 30),
    CURRENT_DATE + (i % 30) + 2,
    (1000 + (i * 125))::numeric(12,2),
    CASE i % 4
        WHEN 0 THEN 'confirmed'
        WHEN 1 THEN 'pending'
        WHEN 2 THEN 'cancelled'
        ELSE 'completed'
    END,
    NOW() - (i || ' days')::interval
FROM generate_series(1, 120) AS I;

INSERT INTO booking_events (booking_id, event_type, payload)
SELECT
    id,
    'booking_created',
    '{"source": "web"}'::jsonb
FROM hotel_bookings
LIMIT 20;

INSERT INTO booking_events (booking_id, event_type, payload)
SELECT
    id,
    'payment_completed',
    '{"payment": "success"}'::jsonb
FROM hotel_bookings
WHERE status = 'confirmed'
LIMIT 10;

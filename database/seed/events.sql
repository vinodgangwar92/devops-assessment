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

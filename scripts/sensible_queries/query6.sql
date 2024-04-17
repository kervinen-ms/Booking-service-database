-- Вывести, сколько времени 'простаивает' кинозал между каждыми двумя сеансами
WITH leads AS(
    SELECT id, auditorium_no, theater_id,
           starts_at,
           LEAD(starts_at, 1, starts_at) OVER (PARTITION BY auditorium_no, theater_id ORDER BY starts_at)
    FROM bs.showtimes
)
SELECT id, auditorium_no, theater_id, lead - starts_at as differ
FROM leads
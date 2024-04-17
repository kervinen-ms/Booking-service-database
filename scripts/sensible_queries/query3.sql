-- Вывести сборы фильма 'Кошмар на улице Вязов'

WITH FreddyShows AS(
    SELECT CONCAT(id,'#', auditorium_no, '#', theater_id)
    FROM bs.showtimes
    WHERE movie_id IN (
        SELECT id
        FROM bs.movies
        WHERE title = 'Кошмар на улице Вязов')
    )
SELECT DISTINCT 
    SUM(trf.ticket_price) OVER 
        (PARTITION BY rsv.showtime_id, rsv.auditorium_no, rsv.theater_id)
FROM bs.reservations AS rsv 
        JOIN bs.tariffs trf 
            ON rsv.tariff_id = trf.id
WHERE CONCAT(rsv.showtime_id, '#', rsv.auditorium_no,'#', rsv.theater_id)
        IN (SELECT * FROM FreddyShows)

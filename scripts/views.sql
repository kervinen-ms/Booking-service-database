CREATE VIEW users_info AS
SELECT first_name, second_name,
       LEFT(phone_no, 8) ||  " ###-##-" || RIGHT(phone_no, 2)
FROM bs.users


CREATE VIEW theaters_info AS
SELECT nm, address, phone_no
FROM bs.theaters


CREATE VIEW prices_info AS 
SELECT trfs.nm as tariff, thtrs.nm as thtr, trfs.ticket_price
FROM bs.tariffs trfs JOIN bs.theaters thtrs
ON trfs.theater_id = thtrs.id


CREATE VIEW canceled_reservations AS
WITH shows_movies AS
    SELECT shws.id AS id, mvs.running_time
    FROM bs.showtimes shws JOIN bs.movies mvs
    ON shws.movie_id = mvs.id
SELECT rsvs.user_id
FROM bs.reservations rsvs JOIN shows_movies
ON rsvs.showtime_id = shows_movies.id
WHERE rsvs.started_at + shows_movies.running_time > rsvs.ended_at


CREATE VIEW ticket_counter AS
SELECT DISTINCT rsrvs.tariff_id, trfs.theater_id, count(rsrvs.id) OVER (PARTITION BY trfs.id) AS cnt
FROM bs.reservations rsrvs JOIN bs.tariffs trfs 
ON trfs.id = rsrvs.tariff_id


CREATE VIEW movies_languahes AS
SELECT DISTINCT mvs.title, shws.audio_language
FROM bs.showtimes shws JOIN bs.movies mvs
ON mvs.id = shws.movie_id


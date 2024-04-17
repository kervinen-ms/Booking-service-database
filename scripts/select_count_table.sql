SELECT
    'theaters' AS table_name,
    count(*) AS cnt
FROM
    bs.theaters

UNION ALL

SELECT
    'auditoriums' AS table_name,
    count(*) AS cnt
FROM
    bs.auditoriums

UNION ALL

SELECT
    'movies' AS table_name,
    count(*) AS cnt
FROM
    bs.movies

UNION ALL

SELECT
    'showtimes' AS table_name,
    count(*) AS cnt
FROM
    bs.showtimes

UNION ALL

SELECT
    'seats' AS table_name,
    count(*) AS cnt
FROM
    bs.seats

UNION ALL

SELECT
    'users' AS table_name,
    count(*) AS cnt
FROM
    bs.users

UNION ALL

SELECT
    'tariffs' AS table_name,
    count(*) AS cnt
FROM
    bs.tariffs

UNION ALL

SELECT
    'reservations' AS table_name,
    count(*) AS cnt
FROM
    bs.reservations

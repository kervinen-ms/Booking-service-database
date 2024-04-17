CREATE SCHEMA bs;

CREATE TYPE auditorium_type AS ENUM ('ordinary', 'VIP', 'child-friendly');

CREATE TYPE _language       AS ENUM('russian', 'english', 'spanish', 'french', 'korean');

CREATE TYPE age_rating      AS ENUM('0+', '6+', '12+', '16+', '18+');

CREATE TYPE seat_type       AS ENUM('chair', 'couch', 'pouf');

CREATE TABLE bs.theaters(
    id          SERIAL,
    nm          VARCHAR(255) NOT NULL,
    address     VARCHAR(255) NOT NULL,
    phone_no    VARCHAR(19),
    
    CONSTRAINT  theaters_pk PRIMARY KEY (id),
    
    CONSTRAINT  phone_validation CHECK 
    (phone_no ~ '\+7 \(\d{3}\) \d{3}-\d{2}-\d{2}')
);

CREATE TABLE bs.auditoriums(
    _no         INTEGER,
    _type       auditorium_type,
    theater_id  INTEGER,
    
    CONSTRAINT auditorium_pk    PRIMARY KEY (_no, theater_id),
    CONSTRAINT fk_theater       FOREIGN KEY (theater_id) 
    REFERENCES bs.theaters(id)
);

CREATE TABLE bs.movies(
    id              SERIAL,
    title           VARCHAR(255) NOT NULL,
    running_time    TIME NOT NULL,
    _age            age_rating NOT NULL,
    premiere_date   DATE NOT NULL,
    budget          INTEGER,
    
    CONSTRAINT movies_pk PRIMARY KEY(id)
);

CREATE TABLE bs.showtimes(
    id SERIAL,
    auditorium_no   INTEGER,
    theater_id      INTEGER,
    movie_id        INTEGER,
    audio_language  _language NOT NULL,
    with_subtitles  BOOLEAN   NOT NULL,
    starts_at       TIMESTAMP NOT NULL,
    ends_at         TIMESTAMP NOT NULL,
    
    CONSTRAINT fk_auditorium    FOREIGN KEY (auditorium_no, theater_id) 
    REFERENCES bs.auditoriums(_no, theater_id),
    
    CONSTRAINT fk_movie         FOREIGN KEY (movie_id)                  
    REFERENCES bs.movies(id),
    
    CONSTRAINT showtimes_pk     PRIMARY KEY (id, auditorium_no, theater_id)
);

CREATE TABLE bs.seats(
    _no             INTEGER,
    _row            INTEGER,
    auditorium_no   INTEGER,
    theater_id      INTEGER,
    _type seat_type NOT NULL,
    
    CONSTRAINT fk_auditorium    FOREIGN KEY (auditorium_no, theater_id)
    REFERENCES bs.auditoriums(_no, theater_id),
    
    CONSTRAINT seats_pk         PRIMARY KEY(_no, _row, auditorium_no, theater_id)
);

CREATE TABLE bs.users(
    id              SERIAL,
    email           VARCHAR(255) UNIQUE,
    phone_no        VARCHAR(19)  UNIQUE, 
    first_name      VARCHAR(255),
    second_name     VARCHAR(255),
    
    CONSTRAINT phone_validation CHECK 
    (phone_no ~ '\+7 \(\d{3}\) \d{3}-\d{2}-\d{2}'),
    
    CONSTRAINT email_validation CHECK 
    (email ~ '[-\w\.]+@([-\w]+\.)+[-\w]{2,4}'),
    
    CONSTRAINT users_pk PRIMARY KEY(id)
);

CREATE TABLE bs.tariffs(
    id              SERIAL,
    theater_id      INTEGER,
    nm              VARCHAR(255),
    ticket_price    INTEGER,
    CONSTRAINT tariffs_pk PRIMARY KEY (id),
    
    CONSTRAINT fk_theater FOREIGN KEY (theater_id) REFERENCES bs.theaters(id)
);

CREATE TABLE bs.reservations(
    id              SERIAL,
    seat_no         INTEGER,
    seat_row        INTEGER,
    auditorium_no   INTEGER,
    theater_id      INTEGER,
    showtime_id     INTEGER,
    tariff_id       INTEGER,
    user_id         INTEGER,
    started_at      TIMESTAMP,
    ended_at        TIMESTAMP,
    
    CONSTRAINT reservations_pk  PRIMARY KEY (id),
    
    CONSTRAINT fk_seat          FOREIGN KEY (seat_no, seat_row, auditorium_no, theater_id)
    REFERENCES bs.seats(_no, _row, auditorium_no, theater_id),
    
    CONSTRAINT fk_showtime      FOREIGN KEY (showtime_id, auditorium_no, theater_id)
    REFERENCES bs.showtimes(id, auditorium_no, theater_id),
    
    CONSTRAINT fk_tariff        FOREIGN KEY (tariff_id) REFERENCES bs.tariffs(id),
    
    CONSTRAINT fk_user          FOREIGN KEY (user_id)   REFERENCES bs.users(id)
);

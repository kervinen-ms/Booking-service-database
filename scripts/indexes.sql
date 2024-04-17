-- Зал идентифицируется парой (id зала, id кинотеатра), поэтому логично получать доступ к этой паре по индексу
CREATE UNIQUE INDEX theater_auditorium_indx
ON bs.auditoriums (id, theater_id)

-- Аналогично место в кинотеатре задается рядом и номером в этом ряду
CREATE INDEX seat_indx
ON bs.seats (_no, _row)
-- 1. Задача про кинотеатр.
-- У фильма, который идет в кинотеатре, есть название, длительность (пусть будет 60, 90 или 120 минут), цена билета (в разное время и дни может быть разной), 
-- время начала сеанса (один фильм может быть показан несколько раз в разное время и с разной ценой билета). Есть информация о купленных билетах (номер билета, на какой сеанс).
-- Задания:
-- ● Составить грамотную нормализованную схему хранения этих данных в БД. Внести в нее 4–5 фильмов, расписание на один день и несколько проданных билетов.
-- ● Сделать запросы, считающие и выводящие в понятном виде:
-- ○ ошибки в расписании (фильмы накладываются друг на друга), отсортированные по возрастанию времени. 
--   Выводить надо колонки «фильм 1», «время начала», «длительность», «фильм 2», «время начала», «длительность»;
-- ○ перерывы 30 минут и более между фильмами — выводить по уменьшению длительности перерыва. Колонки «фильм 1», «время начала», «длительность», «время начала второго фильма», «длительность перерыва»;
-- ○ список фильмов, для каждого — с указанием общего числа посетителей за все время, среднего числа зрителей за сеанс и общей суммы сборов по каждому фильму (отсортировать по убыванию прибыли). Внизу таблицы должна быть строчка «итого», содержащая данные по всем фильмам сразу;
-- ○ число посетителей и кассовые сборы, сгруппированные по времени начала фильма: с 9 до 15, с 15 до 18, с 18 до 21, с 21 до 00:00 (сколько посетителей пришло с 9 до 15 часов и т.д.).
-- -----------------------------------------------------
-- Schema cinema
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS cinema;
CREATE SCHEMA cinema DEFAULT CHARACTER SET utf8mb4 COLLATE = utf8mb4_0900_ai_ci ;
  
USE cinema ;

-- -----------------------------------------------------
-- Table cinema.movies
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS movies (
  id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(128) NOT NULL,
  duration INT NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE);

-- -----------------------------------------------------
-- Table cinema.halls
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS halls (
  id INT NOT NULL AUTO_INCREMENT,
  hall_name VARCHAR(64) NOT NULL,
  comments VARCHAR(128),
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE);
  
-- -----------------------------------------------------
-- Table cinema.seats
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS seats (
  id INT NOT NULL AUTO_INCREMENT,
  hall_id INT NOT NULL,
  row_num INT NOT NULL,
  seat_num INT NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE,
  INDEX fk_seats_halls_idx (hall_id ASC) VISIBLE,
  CONSTRAINT fk_seats_halls 
    FOREIGN KEY (hall_id) 
	REFERENCES halls (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION) ;
  
-- -----------------------------------------------------
-- Table cinema.sessions
-- -----------------------------------------------------
CREATE TABLE sessions (
  id INT NOT NULL AUTO_INCREMENT,
  movie_id INT NOT NULL,
  hall_id INT NOT NULL,
  session_date DATE NOT NULL,
  session_time TIME NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_sessions_halls_idx (hall_id ASC) VISIBLE,
  INDEX fk_sessions_movies_idx (movie_id ASC) VISIBLE,
  CONSTRAINT fk_sessions_halls
    FOREIGN KEY (hall_id)
    REFERENCES halls (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_sessions_movies 
    FOREIGN KEY (movie_id) 
	REFERENCES movies (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table cinema.prices
-- -----------------------------------------------------
CREATE TABLE prices (
  id INT NOT NULL AUTO_INCREMENT,
  session_id INT NOT NULL,
  price DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE,
  INDEX fk_prices_sessions_idx (session_id ASC) VISIBLE,
  CONSTRAINT fk_prices_sessions 
    FOREIGN KEY (session_id) 
	REFERENCES sessions (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
  
  
-- -----------------------------------------------------
-- Table cinema.tickets
-- -----------------------------------------------------
CREATE TABLE tickets (
  id INT NOT NULL AUTO_INCREMENT,
  session_id INT NOT NULL,
  seat_id INT NOT NULL,
  sold_out TINYINT,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE,
  INDEX fk_tickets_sessions_idx (session_id ASC) VISIBLE,
  INDEX fk_tickets_seats_idx (seat_id ASC) VISIBLE,
  CONSTRAINT fk_tickets_sessions 
    FOREIGN KEY (session_id) 
	REFERENCES sessions (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_tickets_seats 
    FOREIGN KEY (seat_id)
    REFERENCES seats (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    
-- -----------------------------------------------------
-- Fill in data tables
-- -----------------------------------------------------
INSERT INTO halls(hall_name, comments) VALUES 
  ("Зал 1", "малый зал - 10 мест"), 
  ("Зал 2", "большой зал - 30 мест");

INSERT INTO movies(title, duration) VALUES 
  ("Movie_1", 60),
  ("Movie_2", 120),
  ("Movie_3", 90),
  ("Movie_4", 60),
  ("The_Best_Movie_5", 120);
  
INSERT INTO seats(hall_id, row_num, seat_num) VALUES 
  -- зал 1
  (1, 1, 1), (1, 1, 2), (1, 1, 3), (1, 1, 4), (1, 1, 5), 
  (1, 2, 1), (1, 2, 2), (1, 2, 3), (1, 2, 4), (1, 2, 5), 
  -- зал 2
  (1, 1, 1), (1, 1, 2), (1, 1, 3), (1, 1, 4), (1, 1, 5), (1, 1, 6),
  (1, 2, 1), (1, 2, 2), (1, 2, 3), (1, 2, 4), (1, 2, 5), (1, 2, 6),
  (1, 3, 1), (1, 3, 2), (1, 3, 3), (1, 3, 4), (1, 3, 5), (1, 3, 6),
  (1, 4, 1), (1, 4, 2), (1, 4, 3), (1, 4, 4), (1, 4, 5), (1, 4, 6),
  (1, 5, 1), (1, 5, 2), (1, 5, 3), (1, 5, 4), (1, 5, 5), (1, 5, 6);
  
INSERT INTO sessions(movie_id, hall_id, session_date, session_time) VALUES
  (1, 1, '2021-08-12', '09:00'),
  (1, 1, '2021-08-12', '09:30'),
  (2, 1, '2021-08-12', '09:45'),
  (2, 1, '2021-08-12', '13:00'),
  (4, 1, '2021-08-12', '19:00'),
  (4, 1, '2021-08-12', '20:00'),
  (3, 1, '2021-08-12', '16:00'),
  (5, 1, '2021-08-11', '23:00'),
  (5, 2, '2021-08-12', '09:00');
  
INSERT INTO prices(session_id, price) VALUES
  (1, 100.00),
  (2, 150.00),
  (3, 150.00),
  (4, 150.00),
  (5, 200.00),
  (6, 150.00),
  (7, 100.00),
  (8, 150.00),
  (9, 200.00);

INSERT INTO tickets(session_id, seat_id, sold_out) VALUES
  #1 - 7 билетов
  (1, 7, 1), (1, 8, 1), (1, 1, 1), (1, 2, 1), (1, 3, 1), (1, 4, 1), (1, 5, 1),
  #2 - 7 билетов
  (2, 2, 1), (2, 3, 1), (2, 4, 1), (2, 5, 1), (2, 2, 1), (2, 3, 1), (2, 4, 1),
  #3 - 3 билета
  (3, 13, 1), (3, 25, 1), (3, 40, 1),
  #4 - 10 билетов
  (4, 1, 1), (4, 5, 1), (4, 2, 1), (4, 10, 1), (4, 4, 1), (4, 6, 1), (4, 8, 1), (4, 7, 1), (4, 9, 1), (4, 3, 1),
  #5 - 10 билетов
  (5, 10, 1), (5, 5, 1), (5, 2, 1), (5, 9, 1), (5, 4, 1), (5, 1, 1), (5, 3, 1), (5, 6, 1), (5, 7, 1), (5, 8, 1),
  #6 - 10 билетов
  (6, 2, 1), (6, 9, 1), (6, 6, 1), (6, 5, 1), (6, 7, 1), (6, 1, 1), (6, 10, 1), (6, 3, 1), (6, 8, 1), (6, 4, 1),
  #7 - 9 билетов
  (7, 2, 1), (7, 5, 1), (7, 1, 1), (7, 10, 1), (7, 4, 1), (7, 9, 1), (7, 3, 1), (7, 6, 1), (7, 7, 1),
  #8 - 7 билетов
  (8, 3, 1), (8, 4, 1), (8, 5, 1), (8, 2, 1), (8, 8, 1), (8, 9, 1), (8, 10, 1),
  #9 - 3 билета
  (9, 4, 1), (9, 8, 1), (9, 3, 1);

-- -----------------------------------------------------
-- Simple timetable view
-- -----------------------------------------------------
# DROP VIEW timetable;
# CREATE VIEW timetable AS 
SELECT s.id, s.session_date, s.hall_id, s.session_time, m.title, m.duration, 
       TIMESTAMP(s.session_date, s.session_time) AS starts_at,
       TIMESTAMPADD(MINUTE, m.duration, TIMESTAMP(s.session_date, s.session_time)) AS ends_at
FROM sessions s
JOIN movies m ON s.movie_id = m.id
ORDER BY s.session_date ASC, s.session_time ASC;
  
-- -----------------------------------------------------
-- QUERIES
-- -----------------------------------------------------
-- ошибки в расписании (фильмы накладываются друг на друга), отсортированные по возрастанию времени. 
-- Выводить надо колонки «фильм 1», «время начала», «длительность», «фильм 2», «время начала», «длительность»;
-- Комментарий: учитываем расписание для каждого зала отдельно.
-- отдельное "решение в лоб" для первого запроса
SELECT t1.title, t1.session_date, t1.session_time, t1.duration, t2.title, t2.session_date, t2.session_time, t2.duration 
FROM (
  SELECT s.id, s.hall_id, m.title, s.session_date, s.session_time, m.duration,
         TIMESTAMP(s.session_date, s.session_time) AS starts_at,
         TIMESTAMPADD(MINUTE, m.duration, TIMESTAMP(s.session_date, s.session_time)) AS ends_at
  FROM sessions s
  JOIN movies m ON s.movie_id = m.id) AS t1
JOIN (
  SELECT s.id, s.hall_id, m.title, s.session_date, s.session_time, m.duration, 
         TIMESTAMP(s.session_date, s.session_time) AS starts_at,
         TIMESTAMPADD(MINUTE, m.duration, TIMESTAMP(s.session_date, s.session_time)) AS ends_at
  FROM sessions s
  JOIN movies m ON s.movie_id = m.id) AS t2
WHERE t1.starts_at BETWEEN t2.starts_at AND t2.ends_at AND 
      t1.id <> t2.id AND
      t1.hall_id = t2.hall_id
ORDER BY t1.session_date ASC, t1.session_time ASC;

# РЕЗУЛЬТАТ:
# Movie_1	2021-08-12	09:30:00	60	Movie_1	2021-08-12	09:00:00	60
# Movie_2	2021-08-12	09:45:00	120	Movie_1	2021-08-12	09:00:00	60 // "двойное" наложение на Movie_1 в 9:00 и в 9:30
# Movie_2	2021-08-12	09:45:00	120	Movie_1	2021-08-12	09:30:00	60
# Movie_4	2021-08-12	20:00:00	60	Movie_4	2021-08-12	19:00:00	60 // нет перерыва между сеансами ~~~> наложение


-- перерывы 30 минут и более между фильмами — выводить по уменьшению длительности перерыва. 
-- Колонки «фильм 1», «время начала», «длительность», «время начала второго фильма», «длительность перерыва»;
SET @checked_hall_id = 1;
SELECT * 
FROM (
  -- рассчитываем timestamp'ы начала и окончания сеансов, сводим данные о сеансах и фильмах, выборка по условию (только в 1 зале), 
  -- сортировка по времени начала (для последующего использования в оконной функции LEAD)
  WITH timestamps_table AS (
  SELECT s.id, s.hall_id, m.title, s.session_date, s.session_time, m.duration, 
         TIMESTAMP(s.session_date, s.session_time) AS starts_at,
         TIMESTAMPADD(MINUTE, m.duration, TIMESTAMP(s.session_date, s.session_time)) AS ends_at
  FROM sessions s
  JOIN movies m ON s.movie_id = m.id
  WHERE s.hall_id = @checked_hall_id
  ORDER BY s.session_date ASC, s.session_time ASC)
  -- добавляем к полученному результату timestamp начала следующего сеанса и продолжительность перерыва в минутах
  SELECT tt.title, tt.starts_at, tt.duration,
       LEAD(starts_at, 1) OVER () next_session_starts_at,
       TIMESTAMPDIFF(MINUTE, ends_at, LEAD(starts_at, 1) OVER ()) minutes_between_sessions,
       CASE
           WHEN TIMESTAMPDIFF(MINUTE, ends_at, LEAD(starts_at, 1) OVER ()) < 0 
		        THEN 'Наложение сеансов'
           WHEN TIMESTAMPDIFF(MINUTE, ends_at, LEAD(starts_at, 1) OVER ()) = 0
                THEN 'Нет перерыва'
           WHEN TIMESTAMPDIFF(MINUTE, ends_at, LEAD(starts_at, 1) OVER ()) >= 30
                THEN 'Длинный перерыв'
       END AS error_comment
  FROM timestamps_table tt) AS result_table
  WHERE minutes_between_sessions <=0 OR minutes_between_sessions >=30;

# РЕЗУЛЬТАТ:
# ---------------------------------------------------------------------------------------------------------------------------
# title             starts_at               duration    next_session_starts_at  minutes_between_sessions    error_comment
# ---------------------------------------------------------------------------------------------------------------------------
# The_Best_Movie_5  2021-08-11 23:00:00     120         2021-08-12 09:00:00     480                         Длинный перерыв
# Movie_1           2021-08-12 09:00:00     60          2021-08-12 09:30:00     -30                         Наложение сеансов
# Movie_1           2021-08-12 09:30:00     60          2021-08-12 09:45:00     -45                         Наложение сеансов
# Movie_2           2021-08-12 09:45:00     120         2021-08-12 13:00:00     75                          Длинный перерыв
# Movie_2           2021-08-12 13:00:00     120         2021-08-12 16:00:00     60                          Длинный перерыв
# Movie_3           2021-08-12 16:00:00     90          2021-08-12 19:00:00     90                          Длинный перерыв
# Movie_4           2021-08-12 19:00:00     60          2021-08-12 20:00:00     0                           Нет перерыва


-- список фильмов, для каждого — с указанием общего числа посетителей за все время, 
-- среднего числа зрителей за сеанс и общей суммы сборов по каждому фильму (отсортировать по убыванию прибыли). 
-- Внизу таблицы должна быть строчка «итого», содержащая данные по всем фильмам сразу;
(WITH tmp AS (
  SELECT s.id, s.movie_id, SUM(p.price) total_sum, COUNT(t.id) viewers
  FROM tickets t
  JOIN sessions s ON s.id = t.session_id
  JOIN prices p ON s.id = p.session_id
  GROUP BY t.session_id)
SELECT m.title, SUM(viewers) total_viewers,
  # COUNT(movie_id) sessions_amount, -- промежуточный результат для контроля расчета среднего количества зрителей
  FORMAT(AVG(viewers), 1) avg_per_session, 
  total_sum
FROM tmp
JOIN movies m ON m.id = tmp.movie_id 
GROUP BY movie_id
ORDER BY total_sum DESC)

UNION
-- итоги по каждому полю
SELECT 'TOTAL', SUM(viewers), FORMAT(AVG(viewers), 1), SUM(total_sum)
FROM tmp;

# РЕЗУЛЬТАТ:
# ---------------------------------------------------------------------------------------------------------------------------
# title             total_viewers   avg_per_session     total_sum
# ---------------------------------------------------------------------------------------------------------------------------
# Movie_1           14              7.0                 700.00
# Movie_2           13              6.5                 450.00
# Movie_3           9               9.0                 900.00
# Movie_4           20              10.0                2000.00
# The_Best_Movie_5  10              5.0                 1050.00
# TOTAL             66              7.3                 9750.00


-- число посетителей и кассовые сборы, сгруппированные по времени начала фильма: с 9 до 15, с 15 до 18, с 18 до 21, с 21 до 00:00 
-- (сколько посетителей пришло с 9 до 15 часов и т.д.).
SELECT m.title,
       SUM(CASE WHEN s.session_time >= "09:00:00" AND s.session_time < "15:00:00" THEN 1 ELSE 0 END) AS "09_15_viewers",
       SUM(CASE WHEN s.session_time >= "09:00:00" AND s.session_time < "15:00:00" THEN p.price ELSE 0 END) AS "09_15_fee",
       SUM(CASE WHEN s.session_time >= "15:00:00" AND s.session_time < "18:00:00" THEN 1 ELSE 0 END) AS "15_18_viewers",
       SUM(CASE WHEN s.session_time >= "15:00:00" AND s.session_time < "18:00:00" THEN p.price ELSE 0 END) AS "15_18_fee",
       SUM(CASE WHEN s.session_time >= "18:00:00" AND s.session_time < "21:00:00" THEN 1 ELSE 0 END) AS "18_21_viewers",
       SUM(CASE WHEN s.session_time >= "18:00:00" AND s.session_time < "21:00:00" THEN p.price ELSE 0 END) AS "18_21_fee",
       SUM(CASE WHEN s.session_time >= "21:00:00" AND s.session_time <= "23:59:59" THEN 1 ELSE 0 END) AS "21_00_viewers",
       SUM(CASE WHEN s.session_time >= "21:00:00" AND s.session_time <= "23:59:59" THEN p.price ELSE 0 END) AS "21_00_fee"
FROM tickets t
JOIN sessions s ON s.id = t.session_id
JOIN prices p ON s.id = p.session_id
JOIN movies m ON s.movie_id = m.id
GROUP BY m.id;

# РЕЗУЛЬТАТ:
# ---------------------------------------------------------------------------------------------------------------------------
# title             09_15_viewers   09_15_fee   15_18_viewers   15_18_fee   18_21_viewers   18_21_fee   21_00_viewers   21_00_fee
# ---------------------------------------------------------------------------------------------------------------------------
# Movie_1           14              1750.00     0               0.00        0               0.00        0               0.00
# Movie_2           13              1950.00     0               0.00        0               0.00        0               0.00
# Movie_4           0               0.00        0               0.00        20              3500.00     0               0.00
# Movie_3           0               0.00        9               900.00      0               0.00        0               0.00
# The_Best_Movie_5  3               600.00      0               0.00        0               0.00        7               1050.00

# 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
# Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте
# транзакции.

-- -------------1-----------------
START TRANSACTION;
INSERT INTO sample.users (name,  birthday_at, created_at, update_at) 
	(SELECT name,  birthday_at, created_at, updated_at FROM shop.users WHERE shop.users.id = 1);
DELETE FROM shop.users WHERE id=1; 
COMMIT;
-- ---------------1------------------*/

# 2. Создайте представление, которое выводит название name товарной позиции из таблицы
# products и соответствующее название каталога name из таблицы catalogs.
-- -------------2--------------------
CREATE OR REPLACE VIEW new_show (new_name, new_catalog) 
AS SELECT products.name, catalogs.name 
FROM products
	JOIN catalogs ON catalog_id = catalogs.id;  
	
SELECT * FROM NEW_show;
-- ---------------2------------------*/

# 3. по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены
# разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и
# 2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в
# соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она
# отсутствует.

-- ------------создадим новую таблицу с датами августа --------------

DROP TABLE IF EXISTS count_date;
CREATE TABLE count_date (day int); 
INSERT INTO count_date VALUES
	(01),(02),(03),(04),(05),(06),(07),(08),(09),(10),
	(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),
	(21),(22),(23),(24),(25),(26),(27),(28),(29),(30),(31);

CREATE OR REPLACE VIEW august_days AS 
		SELECT 
				DATE(DATE('2018-07-31') + INTERVAL count_date.DAY day) AS `day`
		FROM count_date;
-- ------------создадим таблицу с полем created_at и записями за август 2018 год------
DROP TABLE IF EXISTS august_random;
CREATE TEMPORARY TABLE august_random 
	(id int PRIMARY KEY,
	created_at date);
INSERT INTO august_random VALUES
	(1,'2018-08-01'), 
  	(2,'2018-08-04'), 
  	(3,'2018-08-16'), 
  	(4,'2018-08-17');
  
SELECT 
	DATE(DATE('2018-07-31') + INTERVAL count_date.DAY day) AS `day`
	FROM count_date;
	 
SELECT DAY,  
NOT isnull (august_random.id) AS result
FROM august_days
LEFT JOIN august_random ON day = created_at
-- ----------------end 3th task---------------*/

# 4.(по желанию) Пусть имеется любая таблица с календарным полем created_at. 
# Создайте запрос, который удаляет устаревшие записи из таблицы, 
# оставляя только 5 самых свежих записей.

CREATE TEMPORARY TABLE random_date 
	(id int PRIMARY KEY,
	created_at date);
INSERT INTO random_date VALUES
	(1,'2021-08-01'), 
  	(2,'2021-08-04'), 
  	(3,'2021-08-06'), 
  	(4,'2021-08-07'),
	(5,'2021-08-10'), 
  	(6,'2021-08-14'), 
  	(7,'2021-08-16'), 
  	(8,'2021-08-17'),
	(9,'2021-08-21'), 
  	(10,'2021-08-24'), 
  	(11,'2021-08-26'), 
  	(12,'2021-08-27');
 
START TRANSACTION;
SET @number = (SELECT count(*) FROM  random_date) - 5;
DELETE FROM random_date ORDER BY created_at LIMIT 7;
COMMIT;

SELECT * FROM random_date;


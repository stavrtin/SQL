# 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
# С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
# с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

-- ---------------------1-------------------

delimiter //
DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello ()
RETURNS TINYTEXT NOT DETERMINISTIC NO sql
BEGIN 
	DECLARE HOUR int;
	SET HOUR = hour(NOW());
	CASE
		WHEN HOUR BETWEEN 0 AND 9 THEN 
		RETURN 'Утро';
		WHEN HOUR BETWEEN 10 AND 18 THEN 
		RETURN 'День';
		WHEN HOUR BETWEEN 18 AND 21 THEN 
		RETURN 'Вечер';
		WHEN HOUR BETWEEN 22 AND 23 THEN 
		RETURN 'Ночь';
	END CASE;
END//
delimiter ;
SELECT hello();
*/

# 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
# Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
# Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
# При попытке присвоить полям NULL-значение необходимо отменить операцию.

 ----------------2---------------------
USE shop;
SELECT * FROM products 
delimiter //
CREATE TRIGGER test_value BEFORE INSERT ON products
FOR EACH ROW BEGIN 
	IF NEW.name IS NULL AND NEW.desription IS NULL THEN 
		SIGNAL SQLSTATE '45000'
		SET message_text = 'Слишком много пустоты';
	END IF;
END//
-- ------------------2----------------------*/

# 3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
# Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
# Вызов функции FIBONACCI(10) должен возвращать число 55.

delimiter |
DROP FUNCTION IF EXISTS FIBONACCI |
CREATE FUNCTION FIBONACCI(num int)
RETURNS int DETERMINISTIC
BEGIN
	DECLARE fs DOUBLE;
	SET fs = SQRT(5);
	RETURN (pow((1 + fs) / 2.0, num) + pow((1 - fs) / 2.0, num)) / fs;
END | 
	
delimiter;
SELECT FIBONACCI(10);
	
	
	
	
	
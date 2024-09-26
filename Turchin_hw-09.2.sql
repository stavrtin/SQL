# 1. Создайте двух пользователей которые имеют доступ к базе данных shop. Первому
# пользователю shop_read должны быть доступны только запросы на чтение данных, второму
# пользователю shop — любые операции в пределах базы данных shop.

CREATE USER 'only_read'@'localhost';
GRANT SELECT, SHOW, VIEW ON shop.* TO 'only_read'@'localhost' IDENTIFIED BY '';
GRANT ALL ON shop.* TO 'all_comand'@'localhost' IDENTIFIED BY '';
-- выдает ошибку: 
--  SQL Error [1064] [42000]: You have an error in your SQL syntax; check the manual that corresponds 
--  to your MySQL server version for the right syntax to use near 'IDENTIFIED BY ''' at line 1


#2. (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password,
#содержащие первичный ключ, имя пользователя и его пароль. Создайте представление
#username таблицы accounts, предоставляющий доступ к столбца id и name. Создайте
#пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы
#извлекать записи из представления username.


USE example;
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
	id int,
	name varchar(50),
	password varchar(50)
);

INSERT INTO accounts 
VALUES
(1,'Max1,','asdd3fsdg'),
(2,'Max2,','as1ddfsdg'),
(3,'Max3,','asd2dfsdg'),
(4,'Max4,','as4ddfsdg'),
(5,'Max5,','a3sddfsdg');

CREATE OR REPLACE VIEW username 
AS SELECT id, name FROM accounts;

CREATE USER 'user_read'@'localhost';
GRANT SELECT (id, name) ON example.accounts TO 'user_read'@'localhost';

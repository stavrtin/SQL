
-- ------поиск сослуживцев по другим предприятим,где работал интересующий работник -----	

-- ---------------------процедура ------------
Delimiter |
DROP PROCEDURE IF EXISTS colleagues|
CREATE PROCEDURE colleagues (IN name_first VARCHAR(150), IN name_last VARCHAR(150))
BEGIN
 #-- ----------рабочий код отбора сослуживцев
SET @name_fabric = (SELECT 	fabric_name	 FROM sum_job
WHERE firstname = @name_firstname AND lastname = @name_lastname);
SET @name_date_begin = (SELECT 	date_begin	 FROM sum_job
WHERE firstname = @name_firstname AND lastname = @name_lastname);
SET @name_date_end = (SELECT 	date_end 	 FROM sum_job
WHERE firstname = @name_firstname AND lastname = @name_lastname);

SELECT firstname,
		lastname,
		sum_job.fabric_name,
		post_name,
		date_begin,
		date_end
FROM sum_job 
JOIN fabric_job ON sum_job.fabric_name = fabric_job.fabric_name
WHERE sum_job.fabric_name = @name_fabric AND (date_begin >= @name_date_end OR date_end >= @name_date_begin);
#-- ----------рабочий код отбора сослуживцев---
END|
Delimiter ;


SET @name_firstname = ' Василий'; -- --------------ищем его сослуживцев--
SET @name_lastname = ' Сафронов'; -- ------------------ищем его сослуживцев--
CALL colleagues(@name_firstname, @name_lastname);


-- ---------trigger
-- ------------проверка корректности заполнения таблицы WORKЕRS---------
SELECT * FROM workers w

delimiter //
CREATE TRIGGER test_new_worker BEFORE INSERT ON workers
FOR EACH ROW BEGIN 
	IF NEW.firstname IS NULL AND NEW.lastname IS NULL THEN 
		SIGNAL SQLSTATE '45000'
		SET message_text = 'Вы не ввели данные ФИО нового сотрудника';
	END IF;
END//



















-- 1. Запрос на просмотр штата всей фирмы (all correct)

SELECT 	lastname AS Фамилия,
		firstname AS Имя,
		post_name AS Должность,
		department_name  AS Департамент
FROM workers w 
JOIN post ON post_id = post.id 
JOIN department d ON w.department_id = d.id 
ORDER BY Фамилия


-- 2.Запрос на просмотр штата  штат конкретного департамента
-- предварительно ыбран 2й департамент
SET @choise_dep =  2;
SELECT 	lastname AS Фамилия,
		firstname AS Имя,
		post_name AS Должность,
		department_name  AS Департамент
FROM workers w 
JOIN post ON post_id = post.id 
JOIN department d ON w.department_id = d.id 
WHERE department_id = @choise_dep
ORDER BY Фамилия;


-- 3. Запрос на проверку наличия и потребности сотрудников конкретных профессий пр департаментам
SELECT 	department_name,
		post_name,
		post_vocant AS 'Кол-во вакантных',
		post_occupied AS 'Кол-во занятых'
			
FROM staff s
JOIN department d ON s.department_id = d.id 
JOIN post p ON post_id = p.id 


-- 4. Запрос на выдачу Общей потребности фирмы в профессиях:
SELECT 	post_name,
		sum(post_vocant) AS 'Кол-во вакантных',
		sum(post_occupied) AS 'Кол-во занятых',
		sum(post_vocant + post_occupied) AS 'Общее кол-во должностей'
FROM staff s
JOIN department d ON s.department_id = d.id 
JOIN post p ON post_id = p.id 
GROUP BY post_id 

-- 5. Подбор подходящих резюме по требованиям департаментов
SELECT  post AS 'На должность',
		resume.age AS 'Требуемый возраст',
		salary_max AS 'Мах оклад',
		profession AS 'Профессия канд-та', 
		rh.age AS 'Возраст канд-та',
		salary AS 'Ожидание по зп',
		lastname AS 'ФИО канд-та',
		phone AS 'Телефон'
		FROM resume JOIN request_hr rh 
WHERE post = profession AND resume.age > rh.age AND salary <= salary_max
GROUP BY post ;


-- 5. Подсчет бюджета ФОТ 1го департамента за период с ... по ...  

SET @departmetn = 2;
SET @date1 = '2000-01-01';
SET @date2 = now();
SELECT 	#id, 
		#firstname,
		#lastname,
		#post_name,
		#date_begin,
		#date_end, 
		#salary_hist,
		sum(salary_hist) 
FROM workers w 
JOIN job_history ON id = workers_id
WHERE department_id = @departmetn AND date_begin BETWEEN @date1 AND @date2 ;


-- 6. Изменеие рейтинга выбранному работнику после по решению руководителя

SET @worker_firstname =  ' Захар';
SET @worker_lastname =  ' Сафронов';
UPDATE profiles 
SET rating = 75
WHERE workers_id = (SELECT id
					FROM workers 
					WHERE workers.firstname = @worker_firstname AND workers.lastname =  @worker_lastname
					);
SELECT *
FROM profiles p  
WHERE workers_id  = 14 


-- 8. Оформление соискателя на должность в департамент
-- в примере для выбранного соискателя с фамилией  'West'
SET @name_new_man = (SELECT firstname FROM resume r 
WHERE lastname =  @new_worker);
SET @new_worker = 'West';
SET @which_department = 1;
SET @which_post = 2;
INSERT INTO workers (firstname, lastname, department_id, post_id)
VALUES
(@name_new_man, @new_worker, @which_department ,@which_post);



-- 7. (Представление) подбор сотрудников, работавших ранее вместе
-- -------общий перечень всех сотрудников фирмы с указаниемпрежжних мест работ ---------
DROP VIEW IF EXISTS sum_job;
CREATE OR REPLACE VIEW sum_job 
AS SELECT id, firstname,
		lastname,
		fabric_name,
		post_name,
		date_begin,
		date_end
FROM job_history
JOIN	workers w ON workers_id = id
ORDER BY fabric_name;

-- ------отбор предприятий, где могли пересекаться сотрудники-----
DROP VIEW IF EXISTS fabric_job;
CREATE OR REPLACE VIEW fabric_job 
AS SELECT count(id),  fabric_name
FROM sum_job  
GROUP BY fabric_name
HAVING count(id) > 1;


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


-- -----------trigger
SELECT * FROM workers w 
delimiter //
CREATE TRIGGER test_new_worker BEFORE INSERT ON workers
FOR EACH ROW BEGIN 
	IF NEW.firstname IS NULL AND NEW.lastname IS NULL THEN 
		SIGNAL SQLSTATE '45000'
		SET message_text = 'Вы не ввели данные ФИО нового сотрудника';
	END IF;
END//



















DROP DATABASE IF EXISTS hr_bild;
CREATE DATABASE hr_bild;
USE hr_bild;



DROP TABLE IF EXISTS post;
CREATE TABLE post(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
	post_name VARCHAR(50),
    post_salary_max float,
    post_salary_min float
    		);	

DROP TABLE IF EXISTS department;
CREATE TABLE department(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	department_name VARCHAR(50),
    department_shef VARCHAR(50),
    department_phone VARCHAR(100)
);
    
-- сработал ++++++++++++++++++++++++++++++
INSERT INTO `department` (`id`, `department_name`, `department_shef`, `department_phone`) VALUES ('1', ' Инженерный департамент', ' Кабанов', '8-912-157-02-91');
INSERT INTO `department` (`id`, `department_name`, `department_shef`, `department_phone`) VALUES ('2', ' Дорожный департамент', 'Рыбин', '8-936-124-71-46');
INSERT INTO `department` (`id`, `department_name`, `department_shef`, `department_phone`) VALUES ('3', ' Департамент Благоустройства', ' Петров', '8-968-394-90-26');
INSERT INTO `department` (`id`, `department_name`, `department_shef`, `department_phone`) VALUES ('4', 'Строительный департамент', ' Селезнев', '8-936-494-15-31');




    	
DROP TABLE IF EXISTS workers;
CREATE TABLE workers(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    department_id BIGINT UNSIGNED NOT NULL, 
	post_id BIGINT UNSIGNED NOT NULL,
	
FOREIGN KEY (post_id) REFERENCES post(id),
FOREIGN KEY (department_id) REFERENCES department(id)
);


DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	workers_id BIGINT UNSIGNED NOT NULL UNIQUE,
	rating CHAR(2), # присвоение рейтинга для оценки качества работника
	profession VARCHAR(100),
	birthday DATE,
	education VARCHAR(255),
	family_status CHAR(2),
    adress VARCHAR(255),
    phone BIGINT UNSIGNED UNIQUE, 
    photo_id BIGINT UNSIGNED NULL,
    
FOREIGN KEY (workers_id) REFERENCES workers(id)
);

-- пока исключим 
/*
DROP TABLE IF EXISTS family;
CREATE TABLE family (
	workers_id BIGINT UNSIGNED NOT NULL UNIQUE,
    relation CHAR(1),
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    birthday DATE,
	phone BIGINT UNSIGNED UNIQUE, 
      
FOREIGN KEY (workers_id) REFERENCES workers(id)
);

DROP TABLE IF EXISTS education;
CREATE TABLE education (
	workers_id BIGINT UNSIGNED NOT NULL UNIQUE,
    technical_school VARCHAR(150),
    profession VARCHAR(100),
    date_end DATE,
	      
FOREIGN KEY (workers_id) REFERENCES workers(id)
);
*/
/*
INSERT INTO `education` (`workers_id`, `technical_school`, `profession`, `specialization`, `date_end`) VALUES ('1', ' Колледж №7', 'арматурщик', NULL, '1998-06-02');
INSERT INTO `education` (`workers_id`, `technical_school`, `profession`, `specialization`, `date_end`) VALUES ('2', ' Архитектурный колледж', 'плотник', NULL, '2021-04-01');
INSERT INTO `education` (`workers_id`, `technical_school`, `profession`, `specialization`, `date_end`) VALUES ('3', ' Архитектурный колледж', 'плотник', NULL, '1994-06-30');
INSERT INTO `education` (`workers_id`, `technical_school`, `profession`, `specialization`, `date_end`) VALUES ('4', ' Колледж №7', 'сварщик', NULL, '1996-06-06');
INSERT INTO `education` (`workers_id`, `technical_school`, `profession`, `specialization`, `date_end`) VALUES ('5', ' Колледж №7', 'сварщик', NULL, '1996-11-06');
INSERT INTO `education` (`workers_id`, `technical_school`, `profession`, `specialization`, `date_end`) VALUES ('6', 'ПТУ№1', 'сварщик', NULL, '2008-11-02');
INSERT INTO `education` (`workers_id`, `technical_school`, `profession`, `specialization`, `date_end`) VALUES ('7', ' Архитектурный колледж', 'плотник', NULL, '1990-11-20');
INSERT INTO `education` (`workers_id`, `technical_school`, `profession`, `specialization`, `date_end`) VALUES ('8', 'ПТУ№1', 'плотник', NULL, '2008-08-24');
INSERT INTO `education` (`workers_id`, `technical_school`, `profession`, `specialization`, `date_end`) VALUES ('9', ' Архитектурный колледж', 'слесарь', NULL, '1996-11-09');
INSERT INTO `education` (`workers_id`, `technical_school`, `profession`, `specialization`, `date_end`) VALUES ('10', ' Колледж №7', 'каменщик', NULL, '1981-03-01');
*/

-- временно отключаем таблицу

DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
	staff_id SERIAL,
    department_id BIGINT UNSIGNED NOT NULL,
    post_id BIGINT UNSIGNED NOT NULL,
    post_vocant int,
    post_occupied int,
    	
FOREIGN KEY (department_id) REFERENCES department(id),
FOREIGN KEY (post_id) REFERENCES post(id)
);


DROP TABLE IF EXISTS request_HR;
CREATE TABLE request_HR (
	request_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	department_id BIGINT UNSIGNED NOT NULL,
    post VARCHAR(150),
    experience VARCHAR(100),
    age int,
    date_start DATE,
	duration_work int,
	salary_max float,
	      
FOREIGN KEY (department_id) REFERENCES department(id)
);

INSERT INTO `request_HR` (`department_id`, `post`, `experience`, `age`, `date_start`, `duration_work`, `salary_max`) 
VALUES 
(1, 'электрик', 15, 33, '2021-08-02', 2, 60000),
(1, 'сварщик', 25, 38, '2021-08-02', 3, 65000),
(2, 'сварщик', 20, 37, '2021-10-02', 4, 70000),
(1, 'разнорабочий', 4, 45, '2021-11-02', 5, 55000),
(3, ' маляр', 4, 45, '2021-12-02', 6, 64000),
(4, ' электрик', 3, 32, '2022-01-02', 4, 40000),
(4, ' арматурщик', 5, 35, '2022-02-02', 12, 30000),
(2, ' каменщик', 12, 45, '2022-03-02', 6, 50000),
(1, ' плотник', 24, 55, '2022-04-02', 8, 53000),
(2, ' бетонщик', 21, 45, '2022-04-02', 10, 23000),
(1, ' разнорабочий', 15, 365, '2022-04-02', 11, 70000);







DROP TABLE IF EXISTS job_history;
CREATE TABLE job_history (
	workers_id SERIAL, # =  BIGINT UNSIGNED NOT NULL UNIQUE,
	fabric_name VARCHAR(150),
	fabric_phone BIGINT UNIQUE, 
	post_name VARCHAR(150),
    date_begin DATE,
    date_end DATE,
    salary_hist float,
		
FOREIGN KEY (workers_id) REFERENCES workers(id)
);


DROP TABLE IF EXISTS rotation;
CREATE TABLE rotation (
	workers_id SERIAL, # =  BIGINT UNSIGNED NOT NULL UNIQUE,
	rotation_start DATE,
	duration INT,
		
FOREIGN KEY (workers_id) REFERENCES workers(id)
);




DROP TABLE IF EXISTS resume;
CREATE TABLE resume (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	firstname VARCHAR(150),
	lastname VARCHAR(150),
	age int,
	family_status char (1), 
	profession VARCHAR(100),
	technical_school VARCHAR(150),
	education_end date,
	salary float
	);


DROP TABLE IF EXISTS resume_history;
CREATE TABLE resume_history (
	resume_id BIGINT UNSIGNED NOT NULL,
	fabric_name VARCHAR(150),
	fabric_phone BIGINT UNIQUE, 
	post_name VARCHAR(150),
    date_begin DATE,
    date_end DATE,
    		
FOREIGN KEY (resume_id) REFERENCES resume(id)
);




 


INSERT INTO `post` (`id`, `post_name`, `post_salary_max`, `post_salary_min`) VALUES ('1', ' разнорабочий', '11940', '2361');
INSERT INTO `post` (`id`, `post_name`, `post_salary_max`, `post_salary_min`) VALUES ('2', ' водитель', '36810', '4196');
INSERT INTO `post` (`id`, `post_name`, `post_salary_max`, `post_salary_min`) VALUES ('3', ' бетонщик', '11313', '3815');
INSERT INTO `post` (`id`, `post_name`, `post_salary_max`, `post_salary_min`) VALUES ('4', ' слесарь', '34542', '9241');
INSERT INTO `post` (`id`, `post_name`, `post_salary_max`, `post_salary_min`) VALUES ('5', ' каменщик', '36619', '8279');
INSERT INTO `post` (`id`, `post_name`, `post_salary_max`, `post_salary_min`) VALUES ('6', 'сварщик', '21568', '4593');
INSERT INTO `post` (`id`, `post_name`, `post_salary_max`, `post_salary_min`) VALUES ('7', ' электрик', '20827', '5745');
INSERT INTO `post` (`id`, `post_name`, `post_salary_max`, `post_salary_min`) VALUES ('8', ' плотник', '22857', '4211');
INSERT INTO `post` (`id`, `post_name`, `post_salary_max`, `post_salary_min`) VALUES ('9', ' маляр', '8253', '9021');
INSERT INTO `post` (`id`, `post_name`, `post_salary_max`, `post_salary_min`) VALUES ('10', ' арматурщик', '28054', '3447');



INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('1', ' Василий', ' Сафронов', '1', '1');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('2', ' Вячеслав', ' Алексеев', '2', '2');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('3', ' Вячеслав', ' Николаев', '3', '3');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('4', ' Константин', ' Смирнов', '4', '4');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('5', ' Захар', ' Сидоров', '1', '5');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('6', ' Вячеслав', ' Николаев', '2', '6');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('7', ' Иван', 'Иванов', '3', '7');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('8', ' Александр', ' Семенов', '4', '8');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('9', ' Захар', ' Сидоров', '1', '9');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('10', ' Евгений', ' Смирнов', '2', '10');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('11', ' Евгений', ' Семенов', '3', '1');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('12', ' Владимир', ' Николаев', '4', '2');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('13', ' Иван', ' Алексеев', '1', '3');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('14', ' Захар', ' Сафронов', '2', '4');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('15', ' Сергей', ' Сафронов', '3', '5');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('16', ' Александр', ' Сидоров', '4', '6');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('17', ' Петр', ' Смирнов', '1', '7');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('18', ' Сергей', ' Сафронов', '2', '8');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('19', 'Николай', ' Сафронов', '3', '9');
INSERT INTO `workers` (`id`, `firstname`, `lastname`, `department_id`, `post_id`) VALUES ('20', ' Петр', ' Петров', '4', '10');



INSERT INTO `job_history` (`workers_id`, `fabric_name`, `fabric_phone`, `post_name`, `date_begin`, `date_end`, `salary_hist`) VALUES ('1', ' Стройканал', '89794266969', ' маляр', '2005-04-08', '2020-07-08', '36232');
INSERT INTO `job_history` (`workers_id`, `fabric_name`, `fabric_phone`, `post_name`, `date_begin`, `date_end`, `salary_hist`) VALUES ('2', ' СМУ-155', '89306075441', 'сварщик', '2015-12-23', '1994-05-14', '59699');
INSERT INTO `job_history` (`workers_id`, `fabric_name`, `fabric_phone`, `post_name`, `date_begin`, `date_end`, `salary_hist`) VALUES ('3', ' Водоканал', '89977588900', ' маляр', '1979-02-10', '2005-01-08', '37301');
INSERT INTO `job_history` (`workers_id`, `fabric_name`, `fabric_phone`, `post_name`, `date_begin`, `date_end`, `salary_hist`) VALUES ('4', ' Водоканал', '89839121771', ' разнорабочий', '1996-04-07', '2004-08-05', '54699');
INSERT INTO `job_history` (`workers_id`, `fabric_name`, `fabric_phone`, `post_name`, `date_begin`, `date_end`, `salary_hist`) VALUES ('5', ' Сройинвест', '89093122588', ' водитель', '2001-01-29', '2017-07-23', '59341');
INSERT INTO `job_history` (`workers_id`, `fabric_name`, `fabric_phone`, `post_name`, `date_begin`, `date_end`, `salary_hist`) VALUES ('6', ' СМУ-23', '89250662885', ' арматурщик', '1975-11-08', '2009-11-16', '47497');
INSERT INTO `job_history` (`workers_id`, `fabric_name`, `fabric_phone`, `post_name`, `date_begin`, `date_end`, `salary_hist`) VALUES ('7', ' СМУ-155', '89012068124', 'сварщик', '1985-01-21', '1991-11-23', '63390');
INSERT INTO `job_history` (`workers_id`, `fabric_name`, `fabric_phone`, `post_name`, `date_begin`, `date_end`, `salary_hist`) VALUES ('8', ' Стройканал', '89416600110', ' электрик', '1987-01-24', '2021-01-27', '47686');
INSERT INTO `job_history` (`workers_id`, `fabric_name`, `fabric_phone`, `post_name`, `date_begin`, `date_end`, `salary_hist`) VALUES ('9', ' Мостстрой', '89778354839', ' слесарь', '1986-03-22', '1978-02-10', '38802');
INSERT INTO `job_history` (`workers_id`, `fabric_name`, `fabric_phone`, `post_name`, `date_begin`, `date_end`, `salary_hist`) VALUES ('10', ' Стройканал', '89624634684', ' бетонщик', '1978-10-20', '1974-05-10', '59195');
INSERT INTO `job_history` (`workers_id`, `fabric_name`, `fabric_phone`, `post_name`, `date_begin`, `date_end`, `salary_hist`) VALUES ('11', ' СМУ-155', '89268656328', ' каменщик', '1975-10-07', '2003-04-21', '50623');
INSERT INTO `job_history` (`workers_id`, `fabric_name`, `fabric_phone`, `post_name`, `date_begin`, `date_end`, `salary_hist`) VALUES ('12', ' Горстрой', '89976617313', ' арматурщик', '2017-05-12', '1987-08-23', '61066');
INSERT INTO `job_history` (`workers_id`, `fabric_name`, `fabric_phone`, `post_name`, `date_begin`, `date_end`, `salary_hist`) VALUES ('13', ' Мостстрой', '89667768806', ' бетонщик', '1984-12-23', '2014-10-04', '58322');
INSERT INTO `job_history` (`workers_id`, `fabric_name`, `fabric_phone`, `post_name`, `date_begin`, `date_end`, `salary_hist`) VALUES ('14', ' СМУ-23', '89025664481', ' маляр', '2008-03-25', '2012-03-15', '47161');
INSERT INTO `job_history` (`workers_id`, `fabric_name`, `fabric_phone`, `post_name`, `date_begin`, `date_end`, `salary_hist`) VALUES ('15', ' Стройканал', '89996435937', ' стропальщик', '2006-04-03', '2017-04-29', '47184');



INSERT INTO `profiles` (`workers_id`, `rating`, `profession`, `birthday`, `education`, `family_status`, `adress`, `phone`, `photo_id`) VALUES ('1', '49', ' стропальщик', '2016-11-21', ' Строительный институт', 'ж', '8783 Greenholt Prairie\nNorth Cassie, MA 89368-5203', '169', NULL);
INSERT INTO `profiles` (`workers_id`, `rating`, `profession`, `birthday`, `education`, `family_status`, `adress`, `phone`, `photo_id`) VALUES ('2', '7', ' художник', '2001-12-27', ' АСИ', 'ж', '955 Olson Parkway Suite 570\nCollinsberg, UT 99272-0328', '480', NULL);
INSERT INTO `profiles` (`workers_id`, `rating`, `profession`, `birthday`, `education`, `family_status`, `adress`, `phone`, `photo_id`) VALUES ('3', '33', ' электрик', '2011-04-04', ' Строительный институт', 'н', '03644 Miles Points Apt. 350\nHailiemouth, TX 59966', '989', NULL);
INSERT INTO `profiles` (`workers_id`, `rating`, `profession`, `birthday`, `education`, `family_status`, `adress`, `phone`, `photo_id`) VALUES ('4', '73', 'сварщик', '2016-10-19', ' Строительный институт', 'н', '9015 Corkery Shore\nWest Demetriusmouth, PA 71916', '254', NULL);
INSERT INTO `profiles` (`workers_id`, `rating`, `profession`, `birthday`, `education`, `family_status`, `adress`, `phone`, `photo_id`) VALUES ('5', '23', ' каменщик', '1990-10-15', ' Колледж №1', 'ж', '45220 Casey Corner Suite 170\nPort Greg, MO 36725', '988', NULL);
INSERT INTO `profiles` (`workers_id`, `rating`, `profession`, `birthday`, `education`, `family_status`, `adress`, `phone`, `photo_id`) VALUES ('6', '92', ' повар', '2008-03-24', ' Колледж №1', 'ж', '0923 Rory River Suite 524\nNorth Austintown, SC 33836', '760', NULL);
INSERT INTO `profiles` (`workers_id`, `rating`, `profession`, `birthday`, `education`, `family_status`, `adress`, `phone`, `photo_id`) VALUES ('7', '66', ' художник', '2001-03-21', ' Колледж №1', 'н', '3225 Brannon Flats\nSouth Margretfort, HI 33004-7971', '194', NULL);
INSERT INTO `profiles` (`workers_id`, `rating`, `profession`, `birthday`, `education`, `family_status`, `adress`, `phone`, `photo_id`) VALUES ('8', '51', ' художник', '1977-05-16', ' Колледж №12', 'ж', '111 Bart Vista\nElseborough, KY 51545-7434', '205', NULL);
INSERT INTO `profiles` (`workers_id`, `rating`, `profession`, `birthday`, `education`, `family_status`, `adress`, `phone`, `photo_id`) VALUES ('9', '87', ' стропальщик', '1981-09-22', ' МАРХИ', 'ж', '13811 Robel Gardens\nNorth Raymond, VA 36552', '933', NULL);
INSERT INTO `profiles` (`workers_id`, `rating`, `profession`, `birthday`, `education`, `family_status`, `adress`, `phone`, `photo_id`) VALUES ('10', '17', ' плотник', '1990-11-12', ' АСИ', 'н', '952 Swift Roads Apt. 255\nPacochaport, VT 04137', '767', NULL);
INSERT INTO `profiles` (`workers_id`, `rating`, `profession`, `birthday`, `education`, `family_status`, `adress`, `phone`, `photo_id`) VALUES ('11', '13', ' программист', '2003-09-27', ' Строительный институт', 'н', '0494 Lily Loop Suite 054\nClarkport, CO 64558', '895', NULL);
INSERT INTO `profiles` (`workers_id`, `rating`, `profession`, `birthday`, `education`, `family_status`, `adress`, `phone`, `photo_id`) VALUES ('12', '78', ' разнорабочий', '1981-03-12', ' Колледж №1', 'н', '431 Miracle Spurs\nNorth Shane, ME 43496-5630', '798', NULL);
INSERT INTO `profiles` (`workers_id`, `rating`, `profession`, `birthday`, `education`, `family_status`, `adress`, `phone`, `photo_id`) VALUES ('13', '88', ' слесарь', '2017-09-20', ' АСИ', 'ж', '20962 Hand Lodge\nWest Shayne, AL 50978', '365', NULL);
INSERT INTO `profiles` (`workers_id`, `rating`, `profession`, `birthday`, `education`, `family_status`, `adress`, `phone`, `photo_id`) VALUES ('14', '78', ' плотник', '2001-03-14', ' МАРХИ', 'ж', '462 Scottie Corners\nSouth Delphia, DE 18394-7931', '112', NULL);
INSERT INTO `profiles` (`workers_id`, `rating`, `profession`, `birthday`, `education`, `family_status`, `adress`, `phone`, `photo_id`) VALUES ('15', '33', 'сварщик', '1985-05-29', ' Колледж №12', 'ж', '72669 Ratke Squares\nKaleighbury, TN 54441-2839', '187', NULL);


INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('1', 'Angel', 'Fritsch', 28, 'ж', ' плотник', ' Архитектурный колледж', '2005-10-20', '22715');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('2', 'Devan', 'Franecki', 52, 'ж', ' плотник', 'ПТУ №6', '1983-06-19', '33724');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('3', 'Makenzie', 'Rowe', 24, 'н', ' стропальщик', 'ПТУ №6', '1980-09-19', '31036');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('4', 'Garret', 'Bernier', 29, 'ж', ' электрик', 'Строительный колледж №2', '1982-03-11', '67759');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('5', 'Oceane', 'Krajcik', 45, 'н', 'сварщик', 'Строительный колледж №2', '1981-06-04', '73057');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('6', 'Andy', 'Schmeler', 38, 'ж', ' слесарь', 'ПТУ №6', '1971-01-25', '25265');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('7', 'Melvina', 'Cummerata', 58, 'н', ' плотник', ' Архитектурный колледж', '1984-04-11', '78850');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('8', 'Davin', 'Smith', 39, 'н', 'сварщик', 'ПТУ№1', '1996-04-25', '65294');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('9', 'Vincenza', 'Stoltenberg', 39, 'н', ' водитель', ' Колледж №7', '2010-03-06', '45392');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('10', 'Abraham', 'Lehner', 26, 'н', ' разнорабочий', ' Архитектурный колледж', '1985-03-03', '66390');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('11', 'Chadrick', 'McCullough', 30, 'н', 'сварщик', 'Строительный колледж №2', '1980-01-13', '64631');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('12', 'Una', 'Jast', 43, 'ж', ' водитель', 'ПТУ №6', '2013-10-29', '36200');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('13', 'Claudine', 'Pacocha', 38, 'ж', ' повар', ' Архитектурный колледж', '1984-05-24', '43150');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('14', 'Ryleigh', 'Willms', 29, 'ж', ' программист', 'ПТУ№1', '2016-11-05', '65159');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('15', 'Jay', 'Bogan', 51, 'н', 'сварщик', 'Строительный колледж №2', '1988-02-04', '54887');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('16', 'Dylan', 'Fahey', 30, 'ж', ' разнорабочий', 'Строительный колледж №2', '2017-06-08', '21314');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('17', 'Tristin', 'Daugherty', 57, 'ж', ' программист', ' Колледж №7', '2009-10-04', '73713');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('18', 'Emie', 'Jacobs', 37, 'н', ' повар', 'ПТУ №6', '1992-03-10', '45423');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('19', 'Daisha', 'O\'Keefe', 34, 'н', ' плотник', ' Колледж №7', '1984-12-30', '52412');
INSERT INTO `resume` (`id`, `firstname`, `lastname`, `age`, `family_status`, `profession`, `technical_school`, `education_end`, `salary`) VALUES ('20', 'Ruby', 'Berge', 31, 'н', ' повар', 'ПТУ №6', '1970-12-21', '47240');



INSERT INTO `resume_history` (`resume_id`, `fabric_name`, `fabric_phone`, `post_name`, `date_begin`, `date_end`) 
VALUES 
(1,'Стройтехмонтаж', 89095684789, 'сварщик', '2000-08-02','2000-12-02'),
(1,'Интех', 89095344555, 'сварщик', '2000-12-02','2001-04-02'),
(1,'Главмонтаж', 89095685539, 'сварщик', '2001-04-02','2003-08-02'),
(2,'Строймост', 89093534532, 'маляр', '1999-08-02','2002-08-02'),
(2,'Горводоканал', 89335333333, 'маляр', '2003-08-02','2003-10-02'),
(3,'Новострой', 89555665585, 'электрик', '2002-08-02','2003-08-02'),
(3,'Мосстройснаб', 89616684686, 'электрик', '2002-08-02','2003-08-02'),
(3,'СМУ-12', 89195184119, 'электрик', '2002-08-02','2003-08-02'),
(4,'Новострой-1', 89555445585, 'каменщик', '2002-08-02','2003-08-02'),
(4,'Мосстройснаб-3', 89636684686, 'каменщик', '2002-08-02','2003-08-02'),
(5,'СМУ-121', 89195144479, 'разнорабочий', '2002-08-02','2003-08-02'),
(5,'Новострой-4', 89553555585, 'разнорабочий', '2002-08-02','2003-08-02'),
(5,'Мосстрой', 89666687777, 'разнорабочий', '2002-08-02','2003-08-02'),
(6,'СМУ-21', 895588888889, 'монтажник', '2002-08-02','2003-08-02'),
(7,'Новострой-14', 89551111111, 'водитель', '2002-08-02','2003-08-02'),
(7,'Мосстрой-32', 89666564326, 'водитель', '2002-08-02','2003-08-02'),
(8,'СМУ-32', 89195183155, 'бетонщик', '2002-08-02','2003-08-02'),
(8,'СМУ-412', 89195354313, 'каменщик', '2002-08-02','2003-08-02');


INSERT INTO `rotation` (`workers_id`, `rotation_start`, `duration`) VALUES ('1', '1974-05-14', 11);
INSERT INTO `rotation` (`workers_id`, `rotation_start`, `duration`) VALUES ('2', '2007-12-26', 5);
INSERT INTO `rotation` (`workers_id`, `rotation_start`, `duration`) VALUES ('3', '2018-04-09', 1);
INSERT INTO `rotation` (`workers_id`, `rotation_start`, `duration`) VALUES ('4', '2013-06-09', 8);
INSERT INTO `rotation` (`workers_id`, `rotation_start`, `duration`) VALUES ('5', '2002-11-12', 11);
INSERT INTO `rotation` (`workers_id`, `rotation_start`, `duration`) VALUES ('6', '1990-12-04', 6);
INSERT INTO `rotation` (`workers_id`, `rotation_start`, `duration`) VALUES ('7', '1971-01-17', 5);
INSERT INTO `rotation` (`workers_id`, `rotation_start`, `duration`) VALUES ('8', '1986-06-02', 3);
INSERT INTO `rotation` (`workers_id`, `rotation_start`, `duration`) VALUES ('9', '2007-04-27', 3);
INSERT INTO `rotation` (`workers_id`, `rotation_start`, `duration`) VALUES ('10', '2012-05-30', 7);
INSERT INTO `rotation` (`workers_id`, `rotation_start`, `duration`) VALUES ('11', '2019-08-28', 7);
INSERT INTO `rotation` (`workers_id`, `rotation_start`, `duration`) VALUES ('12', '1998-10-08', 12);


INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('1', '1', '1', 1, 35);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('2', '2', '2', 21, 49);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('3', '3', '3', 19, 43);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('4', '4', '4', 6, 20);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('5', '1', '5', 25, 15);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('6', '2', '6', 9, 25);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('7', '3', '7', 29, 42);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('8', '4', '8', 11, 35);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('9', '1', '9', 22, 48);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('10', '2', '10', 39, 6);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('11', '3', '1', 22, 25);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('12', '4', '2', 13, 22);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('13', '1', '3', 2, 25);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('14', '2', '4', 17, 21);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('15', '3', '5', 25, 38);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('16', '4', '6', 48, 20);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('17', '1', '7', 28, 49);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('18', '2', '8', 32, 24);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('19', '3', '9', 14, 44);
INSERT INTO `staff` (`staff_id`, `department_id`, `post_id`, `post_vocant`, `post_occupied`) VALUES ('20', '4', '10', 34, 28);








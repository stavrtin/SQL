-- 1. штат фирмы
/*
SELECT 	lastname AS Фамилия,
		firstname AS Имя,
		post_name AS Должность,
		department_name  AS Департамент
FROM workers w 
JOIN post ON post_id = post.id 
JOIN department d ON w.department_id = d.id 
ORDER BY Фамилия
*/

-- 2. штат конкретного департамента
/*
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
*/

-- 3. Наличие и потребности департаментов в профессиях
/*
SELECT 	department_name,
		post_name,
		post_vocant AS 'Кол-во вакантных',
		post_occupied AS 'Кол-во занятых'
			
FROM staff s
JOIN department d ON s.department_id = d.id 
JOIN post p ON post_id = p.id 
*/

-- 4. Общая потребность фирмы в профессиях:
SELECT 	post_name,
		sum(post_vocant) AS 'Кол-во вакантных',
		sum(post_occupied) AS 'Кол-во занятых',
		sum(post_vocant + post_occupied) AS 'Общее кол-во должностей'
FROM staff s
JOIN department d ON s.department_id = d.id 
JOIN post p ON post_id = p.id 
GROUP BY post_id 

-- 5. количество подходящих резюме

-- 5. бюджет ФОТ 1го департамента на 2022 год  
-- 6. рейтинг
-- 7. пожбор сотрудников, работавших ранее вместе
-- 8. Оформление соискателя на должность в департамент
-- 9. Внесение изменений в личное дело сотудника (изменение состава семьи)
-- 10.Внесение изменений в трудовые книжки. 


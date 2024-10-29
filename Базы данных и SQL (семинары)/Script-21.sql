/*
Задание №1: Анализ влияния категорий продуктов на общий доход
Описание: Вам необходимо проверить, как различные категории продуктов влияют на
общий доход (общую сумму заказов) в таблице OrderDetails. Подсчитайте общее
количество заказов (сумму количества) и общий доход (сумму количества * цену) для
каждой категории продуктов. Выведите результаты, включая:
● CategoryID
● Общее количество заказов (total_quantity)
● Общий доход (total_revenue)
Отсортируйте результаты по убыванию общего дохода (total_revenue). Используйте
таблицы Products, OrderDetails и Categories.*/

SELECT
p.CategoryID,
SUM(od.Quantity) AS total_quantity,
SUM(od.Quantity * p.Price) AS total_revenue
FROM
OrderDetails od
JOIN
Products p ON od.ProductID = p.ProductID
GROUP BY
p.CategoryID
ORDER BY
total_revenue DESC;


/*
Задание №2: Анализ частоты заказа продуктов по категориям
Описание: Напишите запрос SQL для подсчета количества заказов продуктов по
каждой категории. Подсчитайте количество уникальных заказов (OrderID) для каждой
категории продуктов. Выведите результаты, включая:
● CategoryID
● Количество уникальных заказов (order_count)
Отсортируйте результаты по убыванию количества уникальных заказов
(order_count). Используйте таблицы Products, OrderDetails и Categories
*/


SELECT
p.CategoryID,
COUNT(DISTINCT od.OrderID) AS order_count
FROM
OrderDetails od
JOIN
Products p ON od.ProductID = p.ProductID
GROUP BY
p.CategoryID
ORDER BY
order_count DESC;


/*
Задание №3: Вывод наиболее популярных продуктов по количеству заказов
Описание: Выведите список продуктов (название ProductName), отсортированных по
количеству заказов в порядке убывания. Подсчитайте общее количество заказов
(Quantity) для каждого продукта. Выведите результаты, включая:
● ProductName
● Общее количество заказов (total_quantity)
Отсортируйте результаты по убыванию общего количества заказов (total_quantity).
Используйте таблицы Products и OrderDetails. */



SELECT
p.ProductName,
SUM(od.Quantity) AS total_quantity
FROM
OrderDetails od
JOIN
Products p ON od.ProductID = p.ProductID
GROUP BY
p.ProductName
ORDER BY
total_quantity DESC;

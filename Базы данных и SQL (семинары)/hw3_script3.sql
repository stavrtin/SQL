/*Задание 1: Анализ прибыли по категориям продуктов
Задание: Определите общую прибыль для каждой категории продуктов, используя таблицы OrderDetails, Orders и Products. Для расчета прибыли
умножьте цену продукта на количество, а затем суммируйте результаты по категориям.
Подсказка: Используйте JOIN для объединения таблиц OrderDetails,
Orders, Products и Categories. Примените агрегацию с функцией SUM*/ 

select * from OrderDetails

select * from Orders

select * from Products

select * from Categories

select 
--p.ProductID,
c.CategoryName, 
sum(p.Price * od.Quantity) as total_prod 
from Products as p
join OrderDetails as od on od.ProductID  = p.ProductID
join Categories as c on c.CategoryID  = p.CategoryID 
GROUP by c.CategoryName 

/*Задание 2: Количество заказов по регионам
Определите количество заказов, размещенных клиентами из различных стран, за
каждый месяц*/

select * from Копия_Customers c 

select * from Orders

select count(*),
	c.Country,
    EXTRACT(MONTH from o.OrderDate) AS Month,
    EXTRACT (YEAR from o.OrderDate) AS Year
FROM Orders as o
join Копия_Customers as c on c.CustomerID = o.CustomerID 
GROUP by country, MONTH(o.OrderDate), YEAR(o.OrderDate);




/*Задание 3: Средняя продолжительность кредитного срока для клиентов
Задание: Рассчитайте среднюю продолжительность кредитного срока для клиентов по категориям образования.*/
SELECT
education AS Education,
AVG(credit_term) AS AverageCreditTerm
FROM Clusters
GROUP BY education;

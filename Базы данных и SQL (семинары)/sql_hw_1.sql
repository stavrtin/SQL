-- 1. В каких странах проживают наши клиенты (таблица Customers)?
select distinct Country from копия_customers кc ;

--Сколько уникальных стран вы получили в ответе?
select count(distinct Country) from копия_customers кc ;

--2. Сколько клиентов проживает в Argentina?
select count(*) from копия_customers кc 
where Country = 'Argentina';

--3. Посчитайте среднюю цену и количество товаров в 8 категории (таблица Products )
select avg(Price), sum(Price), count(ProductID)  from public.копия_products
group by CategoryID having CategoryID = 8

-- 4. Посчитайте средний возраст работников (таблица Employees)

select avg(age) from ( 
                      SELECT date_part('year',age(birthdate::date)) as age from employees e);

/*5. Вам необходимо получить заказы, которые сделаны в течении 35 дней до даты 2023-10-10 (то есть с 5 
сентября до 10 октября включительно). Использовать функцию DATEDIFF, определить переменные для 
даты и диапазона. 
Определите CustomerID, который оказался в первой строке запроса.*/
                     
                    
select * from public.копия_orders 
where orderdate between '2023-09-05' and'2023-10-10';


DECLARE @starts date = '2023-09-01', 
        @finish date = '2023-09-15'
SELECT count(*) FROM Orders 
where orderdate BETWEEN @start AND @finish


/*6. Вам необходимо получить количество заказов за сентябрь месяц (тремя способами, через LIKE, с 
помощью YEAR и MONTH и сравнение начальной и конечной даты).*/

--1 
select * from копия_orders кo 
where orderdate like ('2023-09%');

--2
select * from копия_orders кo 
where YEAR(orderdate::date) = 2023 and month (orderdate) = 09;

--3
select * from копия_orders кo 
where orderdate between ('2023-09-01') and ('2023-09-31'); 


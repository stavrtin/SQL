/*Задание 1: Ранжирование продуктов по средней цене
Задание: Ранжируйте продукты в каждой категории на основе их средней цены
(AvgPrice). Используйте таблицы OrderDetails и Products.*/
-- Рассчитываем среднюю цену для каждого продукта
WITH ProductAvgPrice AS (
SELECT
p.CategoryID,
p.ProductID,
p.ProductName,
AVG(p.Price) AS AvgPrice
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.CategoryID, p.ProductID, p.ProductName
)
-- Ранжируем продукты по средней цене внутри каждой категории
SELECT
CategoryID,
ProductID,
ProductName,
AvgPrice,
RANK() OVER (PARTITION BY CategoryID ORDER BY AvgPrice DESC) AS
ProductRank
FROM ProductAvgPrice;

/*Задание 2: Средняя и максимальная сумма кредита по месяцам
Задание: Рассчитайте среднюю сумму кредита (AvgCreditAmount) для каждого
кластера в каждом месяце и сравните её с максимальной суммой кредита
(MaxCreditAmount) за тот же месяц. Используйте таблицу Clusters.*/
-- Рассчитываем среднюю сумму кредита для каждого кластера и месяца
WITH AvgCredit AS (
SELECT
month,
cluster,
AVG(credit_amount) AS AvgCreditAmount
FROM Clusters
GROUP BY month, cluster
),
-- Рассчитываем максимальную сумму кредита для каждого месяца
MaxCredit AS (
SELECT
month,
MAX(credit_amount) AS MaxCreditAmount
FROM Clusters
GROUP BY month
)
-- Объединяем результаты и выводим их
SELECT
a.month,
a.cluster,
a.AvgCreditAmount,
m.MaxCreditAmount
FROM AvgCredit a
JOIN MaxCredit m ON a.month = m.month;




/*Задание 3: Разница в суммах кредита по месяцам
Задание: Создайте таблицу с разницей (Difference) между суммой кредита и
предыдущей суммой кредита по месяцам для каждого кластера. Используйте таблицу
Clusters.*/

-- Рассчитываем сумму кредита и сумму кредита в предыдущем месяце
WITH CreditWithPrevious AS (
SELECT
month,
cluster,
credit_amount,
LAG(credit_amount) OVER (PARTITION BY cluster ORDER BY
month) AS PreviousCreditAmount
FROM Clusters
)
-- Вычисляем разницу между текущей и предыдущей суммой кредита
SELECT
month,
cluster,
credit_amount,
PreviousCreditAmount,
COALESCE(credit_amount - PreviousCreditAmount, 0) AS Difference
FROM CreditWithPrevious;
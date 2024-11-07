CREATE database shop;

-- Создание таблицы
CREATE TABLE EmployeeDetails (
EmployeeID INTEGER PRIMARY KEY,
EmployeeName TEXT,
Position TEXT,
HireDate DATE,
Salary NUMERIC);
-- Добавление данных
INSERT INTO EmployeeDetails (EmployeeID, EmployeeName, Position,
HireDate, Salary) VALUES (1, 'John Smith', 'Sales Manager',
'2022-01-15', 55000);
INSERT INTO EmployeeDetails (EmployeeID, EmployeeName, Position,
HireDate, Salary) VALUES (2, 'Jane Doe', 'Marketing Specialist',
'2021-06-30', 48000);
INSERT INTO EmployeeDetails (EmployeeID, EmployeeName, Position,
HireDate, Salary) VALUES (3, 'Emily Johnson', 'Software Engineer',
'2023-03-22', 65000);

CREATE VIEW HighValueOrders AS
SELECT
o.OrderID,
o.OrderDate,
SUM(od.Quantity * p.Price) AS TotalAmount
FROM копия_orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY o.OrderID, o.OrderDate
HAVING SUM(od.Quantity * p.Price) > 10000;


-- Удаление данных
DELETE FROM EmployeeDetails WHERE Salary < 50000;
-- Удаление таблицы
DROP TABLE EmployeeDetails;

/*
Используя JOIN’s и ShopDB получить имена покупателей и имена сотрудников у которых 
TotalPrice товара больше 1000
*/

USE ShopDB;

/* Если речь идет о TotalPrice каждого наименования в заказе, то выборка записей будет пустая,
т.к. ни одна позиция в заказе в не имеет TotalPrice > 1000 */
SELECT
	customers.LName AS Customer_LName, 
	customers.FName AS Customer_FName,
	customers.MName AS Customer_MName,
	employees.LName AS Employee_LName, 
	employees.FName AS Employee_FName,
	employees.MName AS Employee_MName
FROM orders
INNER JOIN customers
ON orders.CustomerNo = customers.CustomerNo
INNER JOIN employees
ON orders.EmployeeID = employees.EmployeeID
INNER JOIN orderdetails
ON orders.OrderID = orderdetails.OrderID
WHERE TotalPrice>1000
GROUP BY Customer_LName, Customer_FName, Customer_MName, Employee_LName, Employee_FName, Employee_MName;

/* Если речь идет о TotalPrice каждого заказа, то в выборке будет присутствовать только
одна запись - заказа с id 6, т.к. общая сумма заказа равна 1096*/
SELECT 
	customers.LName AS Customer_LName, 
	customers.FName AS Customer_FName,
	customers.MName AS Customer_MName,
	employees.LName AS Employee_LName, 
	employees.FName AS Employee_FName,
	employees.MName AS Employee_MName,
	SUM(TotalPrice) AS Order_Sum
FROM orders
INNER JOIN customers
ON orders.CustomerNo = customers.CustomerNo
INNER JOIN employees
ON orders.EmployeeID = employees.EmployeeID
INNER JOIN orderdetails
ON orders.OrderID = orderdetails.OrderID
GROUP BY Customer_LName, Customer_FName, Customer_MName, Employee_LName, Employee_FName, Employee_MName
HAVING SUM(TotalPrice) > 1000;




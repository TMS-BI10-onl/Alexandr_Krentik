--Task 4
--How many orders received in 2013
SELECT COUNT(SalesOrderID) AS Number_of_orders_2013
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = '2013';

--How many orders received in 2013 shipped in 2014
SELECT COUNT(SalesOrderID) AS Number_of_shipped_orders_in_2014_from_2013
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = '2013' AND YEAR(ShipDate) = '2014';

--How many shipments are made on Sundays
SELECT COUNT(SalesOrderID) AS Number_of_ships_on_Sunday
FROM Sales.SalesOrderHeader
WHERE DATEPART(dw, ShipDate ) = 7;

--List the number of orders by day in May 2013
SELECT COUNT(SalesOrderID) AS Number_of_orders_by_day
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = '2013' AND MONTH(OrderDate) = '05'
GROUP BY DAY(OrderDate);

--Merge two columns with the first and last names so that the last name is written in capital letters. Set three spaces between words
SELECT FirstName + SPACE(3) + UPPER(LastName) AS Full_Name
FROM Person.Person;

--Display a table with the length of each first name sorted by ascending number of symbols in the name
SELECT FirstName
	, LEN(FirstName) AS Number_of_symbols
FROM Person.Person
ORDER BY LEN(FirstName);

-- Change the time format in the ModifiedDate column of the Person.Person table to "Wednesday, January XX, XXXX"
SELECT FORMAT(ModifiedDate, 'D', 'en-US') AS 'US English Date'
FROM Person.Person;

--Remove all spaces in first name column of Person.Person table
SELECT TRIM(FirstName)
FROM Person.Person;

--In the Product Name column from the Production.Product table, display the name limited to 10 characters and written in lowercase
SELECT SUBSTRING(LOWER(Name), 1, 10)
FROM Production.Product;

--Determine the average time to shipment from the order date
SELECT AVG(DATEDIFF(day, OrderDate, ShipDate)) AS 'AVG shipment time'
FROM Sales.SalesOrderHeader;

--Determine if there are invalid values in the OrderDate column of the Sales.SalesOrderHeader table
SELECT ISDATE(OrderDate) AS CHEK
FROM Sales.SalesOrderHeader
WHERE ISDATE(OrderDate) != 1;

--Display the price from the Production.Product table with the values of the ListPrice column rounded to the second decimal place
SELECT Name, ROUND(ListPrice, 2) AS 'Rounded price'
FROM Production.Product;
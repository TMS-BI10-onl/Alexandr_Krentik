--Task 1
--Retrieve all columns from the Sales.SalesTerritory table
SELECT *
FROM Sales.SalesTerritory;

--Retrieve the TerritoryID and Name columns from the Sales.SalesTerritory table
SELECT TerritoryID
	, Name
FROM Sales.SalesTerritory;

--Find all data that exists for people from Person.Person with LastName = 'Norman'
SELECT *
FROM Person.Person
WHERE LastName = 'Norman';

--Find all lines from Person.Person where EmailPromotion isn't equal to 2
SELECT *
FROM Person.Person
WHERE EmailPromotion != 2;



--Task 3
--STDEV - standard deviation of all values
SELECT STDEV(DiscountPct) AS 'Standard deviation'
FROM Sales.SpecialOffer;

--STDEVP - standard deviation for the population for all values
SELECT STDEVP(DiscountPct) AS 'Standard deviation'
FROM Sales.SpecialOffer;

-- VAR - statistical variance of all values
SELECT VAR(DiscountPct) AS 'Statistical variance'
FROM Sales.SpecialOffer;

-- VARP - statistical variance for the population for all values
SELECT VARP(DiscountPct) AS 'Statistical variance'
FROM Sales.SpecialOffer;



--Task 4
--How many unique PersonTypes exist for people from Person.Person with LastName starting with letter M or not containing 1 in EmailPromotion
SELECT COUNT(DISTINCT PersonType) AS 'Number of unique PersonTypes'
FROM Person.Person
WHERE LastName LIKE 'M%'
	OR EmailPromotion != 1;

--Display the first 3 special offers from Sales.SpecialOffer with the highest DiscountPct that were valid from 2013-01-01 to 2014-01-01
SELECT TOP 3 * 
FROM Sales.SpecialOffer
WHERE StartDate BETWEEN '2013-01-01' AND '2014-01-01'
ORDER BY DiscountPct DESC;

--Find the smallest weight and the largest size of a product from Production.Product
SELECT MIN(Weight) AS 'Smallest weight'
	, MAX(Size) 'Largest size'
FROM Production.Product;

--Find the smallest weight and the largest size of a product for each ProductSubcategoryID from Production.Product
SELECT ProductSubcategoryID
	, MIN(Weight) AS 'Smallest weight'
	, MAX(Size) 'Largest size'
FROM Production.Product
GROUP BY ProductSubcategoryID;

--Find the smallest weight and the largest size of a product for each ProductSubcategoryID subcategory of Production.Product where the color of the product is specified (Color)
SELECT ProductSubcategoryID
	, MIN(Weight) AS 'Smallest weight'
	, MAX(Size) 'Largest size'
FROM Production.Product
WHERE Color IS NOT NULL
GROUP BY ProductSubcategoryID;
--Task 2

/*a) List prices as a text comment based on the price range for the product:
a. StandardCost is 0 or not defined - 'Not for sale'
b. StandardCost greater than 0 but less than 100 - '<$100'
c. StandardCost greater than or equal to 100 but less than 500 - '<$500'
d. Else - '>= $500'
List the product name and a new field, PriceRange.*/
SELECT Name,
	CASE WHEN StandardCost = 0 OR StandardCost IS NULL THEN 'Not for sale'
		WHEN StandardCost < 100 THEN '<$100'
		WHEN StandardCost < 500 THEN '<$500'
	ELSE '>= $500'
	END PriceRange
FROM Production.Product;

/*b) Find the ProductID, BusinessEntityID, and Product Vendor Name from Purchasing.ProductVendor
and Purchasing.Vendor where StandardPrice is greater than $10.
Also, the vendor name must contain (regardless of position) the letter X or the name must begin with the letter N.*/
SELECT pv.ProductID
	, pv.BusinessEntityID
	, v.Name AS ProductVendorName
FROM Purchasing.ProductVendor pv
	JOIN Purchasing.Vendor v
	ON pv.BusinessEntityID = v.BusinessEntityID
WHERE pv.StandardPrice > 10 
	AND (v.Name LIKE '%X%' OR v.Name LIKE 'N%');


/*c) Find the names of all vendors whose products have not been sold all the time.
You must use the following schema to join the Purchasing.ProductVendor and Purchasing.Vendor tables*/
SELECT v.Name AS ProductVendorName
FROM Purchasing.Vendor v
	LEFT JOIN Purchasing.ProductVendor pv
	ON v.BusinessEntityID = pv.BusinessEntityID
WHERE pv.BusinessEntityID IS NULL;



--Task 3

--Solve the following tasks for the test database (diagram below):
--a) Find manufacturers whose drugs were not sold in 2019 (hint: to extract the year from a date, use one of the date functions).
SELECT DISTINCT m.Name_Manufacturers 
FROM Sales s
	JOIN Cash_Receipts cr
	ON s.ID_Cash_Receipts = cr.ID_Cash_Receipts
	JOIN Drugs d
	ON s.ID_Drugs = d.ID_Drugs
	JOIN Manufacturers m
	ON d.ID_Name_Manufacturers = m.ID_Name_Manufacturers
WHERE m.Name_Manufacturers !=
	(SELECT m.Name_Manufacturers 
	FROM Sales s
		JOIN Cash_Receipts cr
		ON s.ID_Cash_Receipts = cr.ID_Cash_Receipts
		JOIN Drugs d
		ON s.ID_Drugs = d.ID_Drugs
		JOIN Manufacturers m
		ON d.ID_Name_Manufacturers = m.ID_Name_Manufacturers
	WHERE YEAR(cr.Date) = '2019');

--b) Print the doubled price of drugs of type A.
SELECT d.Name_Drugs, d.Price*2 AS Doubled_Price
FROM Drugs d
	JOIN Type_Drugs td
	ON d.ID_Type_Drugs = td.ID_Type_Drugs
WHERE td.Type_Drugs = 'A';

--c) Find the manufacturers and number of drugs for each of them where the drug is not type A.
SELECT m.Name_Manufacturers
	, COUNT(d.ID_Drugs) AS Number_of_drugs
FROM Drugs d
	JOIN Manufacturers m
	ON d.ID_Name_Manufacturers = m.ID_Name_Manufacturers
	JOIN Type_Drugs td
	ON d.ID_Type_Drugs = td.ID_Type_Drugs
WHERE td.Type_Drugs != 'A'
GROUP BY m.Name_Manufacturers;

--d) Print the name of the pharmacy and the names of drugs that were sold there on Saturdays.
SELECT p.Name_Pharmacies, d.Name_Drugs 
FROM Sales s
	JOIN Cash_Receipts cr
	ON s.ID_Cash_Receipts = cr.ID_Cash_Receipts
	JOIN Pharmacies p
	ON s.ID_Pharmacies = p.ID_Pharmacies
	JOIN Drugs d
	ON s.ID_Drugs = d.ID_Drugs
WHERE DATEPART(dw,cr.Date) = 6 --if Monday is the first day of the week
ORDER BY p.Name_Pharmacies;
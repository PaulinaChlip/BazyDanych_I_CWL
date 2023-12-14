/*
ZADANIE 1
USE AdventureWorks2022
GO
WITH PersonData_CTE
AS
(
	SELECT p.FirstName, p.LastName, eph.Rate
	FROM  Person.Person p LEFT JOIN HumanResources.EmployeePayHistory eph
	ON p.BusinessEntityID = eph.BusinessEntityID 
	WHERE eph.Rate IS NOT NULL 
)
SELECT * INTO #TempEmployeeInfo
FROM PersonData_CTE 
 
ZADANIE 2
USE AdventureWorksLT2022
GO
WITH CompanyContact_CTE
AS
(
	SELECT sc.CustomerID,  CONCAT(sc.CompanyName, ' (' , sc.FirstName, ' ', sc.LastName, ')') AS CompanyContact
	FROM SalesLT.Customer sc
)
SELECT cte.CompanyContact, soh.TotalDue
FROM CompanyContact_CTE cte LEFT JOIN SalesLT.SalesOrderHeader soh 
	ON cte.CustomerID=soh.CustomerID
	WHERE soh.TotalDue IS NOT NULL
	ORDER BY CompanyContact


ZADANIE 3
USE AdventureWorksLT2022
GO
WITH Product_Categories_CTE
AS
(
	SELECT p.ProductCategoryID, sod.LineTotal
	FROM SalesLT.Product p LEFT JOIN  SalesLT.SalesOrderDetail sod
	ON p.ProductID=sod.ProductID
)
SELECT pc.Name AS ProductName, SUM(pcte.LineTotal) AS SalesValue
FROM Product_Categories_CTE pcte LEFT JOIN SalesLT.ProductCategory pc
ON pcte.ProductCategoryID=pc.ProductCategoryID
WHERE pcte.LineTotal IS NOT NULL
GROUP BY pc.Name
*/  

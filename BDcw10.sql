USE AdventureWorks2022
GO
/* Zadanie 1 */
BEGIN TRANSACTION;
UPDATE Production.Product
SET ListPrice=ListPrice*1.1
WHERE ProductID=680;

SELECT ProductID,ListPrice FROM Production.Product WHERE  ProductID=680;
COMMIT;


/* Zadanie 2 */
BEGIN TRANSACTION;
INSERT INTO Production.Product (Name,ProductNumber,MakeFlag, FinishedGoodsFlag, Color,SafetyStockLevel,ReorderPoint,StandardCost,
ListPrice,Size,SizeUnitMeasureCode,WeightUnitMeasureCode, Weight,DaysToManufacture,ProductLine,Class,Style,ProductSubcategoryID,
ProductModelID,SellStartDate,SellEndDate,DiscontinuedDate,ModifiedDate)
VALUES
('Skarpetki merino', 547839,0,1,'Yellow',100,100,24.73,39.99,38,NULL,NULL,NULL,1,'R','L','U',2,97,2013-05-30,NULL,NULL,2023-20-12);
SELECT * FROM Production.Product WHERE Name='Skarpetki merino';
COMMIT;


/* Zadanie 3 */
BEGIN TRANSACTION;
DELETE FROM  Production.Product
WHERE ProductID=1011;
ROLLBACK;


/* Zadanie 4 */
BEGIN TRANSACTION;
DECLARE @koszt DECIMAL(8,2);
SELECT @koszt=SUM(StandardCost*1.1) FROM Production.Product;
IF(@koszt<50000)
BEGIN
	UPDATE Production.Product
	SET StandardCost=StandardCost*1.1;
	COMMIT;
END
ELSE ROLLBACK;


/* Zadanie 5 */
BEGIN TRANSACTION;
INSERT INTO Production.Product(Name,ProductNumber,MakeFlag, FinishedGoodsFlag, Color,SafetyStockLevel,ReorderPoint,StandardCost,
ListPrice,Size,SizeUnitMeasureCode,WeightUnitMeasureCode, Weight,DaysToManufacture,ProductLine,Class,Style,ProductSubcategoryID,
ProductModelID,SellStartDate,SellEndDate,DiscontinuedDate,ModifiedDate) 
VALUES ('Skarpetki merino', 547839,0,1,'Yellow',100,100,24.73,39.99,38,NULL,NULL,NULL,1,'R','L','U',2,97,2013-05-30,NULL,NULL,2023-20-12);
IF(EXISTS(SELECT * FROM Production.Product WHERE ProductNumber=CAST(547839 AS VARCHAR(25)))) ROLLBACK;
ELSE COMMIT;


/*Zadanie 6 */
BEGIN TRANSACTION;

UPDATE Sales.SalesOrderDetail
SET OrderQty=2*OrderQty;
SELECT * FROM Sales.SalesOrderDetail WHERE OrderQty=0;

DECLARE @OrderQtyCount INTEGER;
SELECT @OrderQtyCount=COUNT(*) FROM Sales.SalesOrderDetail WHERE OrderQty=0;
IF(@OrderQtyCount>0)
ROLLBACK;
ELSE COMMIT;


/* Zadanie 7 */

BEGIN TRANSACTION;

DECLARE @Average DECIMAL(10,2); DECLARE @Licznik INTEGER=0;
SELECT @Average = AVG( StandardCost) FROM Production.Product;
--PRINT @Average;
UPDATE Production.Product
SET StandardCost=@Average WHERE StandardCost > @Average 
SET @Licznik=@Licznik+1;
IF(@Licznik>200) ROLLBACK;
ELSE COMMIT;


/* Zadanie 1 */
USE AdventureWorks2022
GO
CREATE PROCEDURE FiboSeq @Variable integer
AS
BEGIN
	DECLARE	@Variable1 integer SET @Variable1= 1
	DECLARE @Variable2 integer SET @Variable2= 1
	DECLARE @Counter_N integer SET @Counter_N=3
	DECLARE @Curr_Result integer SET @Curr_Result= 0
	IF @Counter_N = 1
	BEGIN
		PRINT(@Variable1);
	END
	ELSE
	BEGIN
		PRINT(@Variable1);
		PRINT(@Variable2);
		WHILE @Counter_N <= @Variable
		BEGIN
			SET @Curr_Result=@Variable1+@Variable2
			PRINT(@Curr_Result)
			SET @Variable1=@Variable2
			SET @Variable2=@Curr_Result
			SET @Counter_N= @Counter_N+1
		END
	END
END;

USE AdventureWorks2022
GO
EXEC FiboSeq @Variable = 4;


/* Zadanie 2 */
CREATE TRIGGER LastNameToUpper ON Person.Person
AFTER INSERT AS
BEGIN
	UPDATE Person.Person
	SET LastName=UPPER(LastName);
END;


/* Zadanie 3 */
CREATE TRIGGER taxRateMonitoring ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
	DECLARE @OldTaxRate DECIMAL (10,2)
    DECLARE @NewTaxRate DECIMAL (10,2) 

	SELECT @OldTaxRate = TaxRate FROM deleted;
    SELECT @NewTaxRate = TaxRate FROM inserted;

    IF (ABS(@NewTaxRate - @OldTaxRate) / @OldTaxRate) > 0.30
    BEGIN
        RAISERROR ('Zbyt du¿a zmiana wartoœci w polu TaxRate',16, 1)
    END
END;

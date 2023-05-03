USE [TaxesBD]
GO
/****** Object:  StoredProcedure [dbo].[calculate_deductions_by_employee]    Script Date: 2/5/2023 19:34:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[calculate_deductions_by_employee]
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL
	READ COMMITTED
	
	BEGIN TRY
		DECLARE @max_amount1 DECIMAL(10,2)
		DECLARE @max_amount2 DECIMAL(10,2)
		DECLARE @max_amount3 DECIMAL(10,2)
		DECLARE @max_amount4 DECIMAL(10,2)

		DECLARE @start INT, @end INT

		SET @start = 1
		SET @end = 100000

		SET @max_amount1 = (SELECT end_range FROM dbo.Tax_deduction AS T WHERE T.percentage = 0)
		SET @max_amount2 = (SELECT end_range FROM dbo.Tax_deduction AS T WHERE T.percentage = 0.1)
		SET @max_amount3 = (SELECT end_range FROM dbo.Tax_deduction AS T WHERE T.percentage = 0.15)
		SET @max_amount4 = (SELECT end_range FROM dbo.Tax_deduction AS T WHERE T.percentage = 0.20)

		DROP table IF EXISTS #lote

		CREATE TABLE #Lote(
			idn int,
			gross_salary money,
			kids_number int,
			is_maried bit,
			impuesto money,
			credito_conyuge money,
			credito_hijos money,
			deduccion_obrero_ccss money,
			deduccion_obrero_LPT money,
			deduccion_patrono_ccss money,
			deduccion_patrono_otras_instituciones money,
			deduccion_patrono_LPT money
		)

		BEGIN TRANSACTION Calculo

		DECLARE @all_employees int

		SET @all_employees = (SELECT COUNT(*) FROM dbo.Employee)

		WHILE @start <= @all_employees
		BEGIN

			INSERT INTO #Lote 
			SELECT idn,gross_salary,kids_number,is_married,
			(CASE WHEN gross_salary <= @max_amount1 THEN 0
			WHEN gross_salary <= @max_amount2 THEN (gross_salary - @max_amount1) * 0.1
			WHEN gross_salary <= @max_amount3 THEN (@max_amount2 - @max_amount1) * 0.1 + (gross_salary - @max_amount2) * 0.15
			WHEN gross_salary <= @max_amount4 THEN (@max_amount2 - @max_amount1) * 0.1 + (@max_amount3 - @max_amount2) * 0.15 + (gross_salary - @max_amount3) * 0.2
			ELSE (@max_amount2 - @max_amount1) * 0.1 + (@max_amount3 - @max_amount2) * 0.15 + (@max_amount4 - @max_amount3) * 0.2 + (gross_salary - @max_amount4) * 0.25 END) AS impuesto,
			(CASE WHEN is_married = 1 THEN (SELECT F.amount FROM dbo.Family_credit AS F WHERE F.id_regulation = 1 and F.id_type = 1)
			ELSE 0 END) AS Credito_conyugue, (CASE WHEN kids_number >= 1 AND kids_number <= 2 THEN kids_number * (SELECT F.amount FROM dbo.Family_credit AS F WHERE F.id_regulation = 1 and F.id_type = 2)
			ELSE 0 END) AS Credito_hijos, gross_salary*(SELECT S.percentage FROM dbo.Social_charges_deduction AS S WHERE S.id_type = 1) AS deduccion_obrero_ccss,
			gross_salary * (SELECT S.percentage FROM dbo.Social_charges_deduction AS S WHERE S.id_type = 2) AS deducciones_obrero_LPT,
			gross_salary * (SELECT S.percentage FROM dbo.Social_charges_deduction AS S WHERE S.id_type = 3) AS deducciones_patrono_ccss,
			gross_salary * (SELECT S.percentage FROM dbo.Social_charges_deduction AS S WHERE S.id_type = 4) AS deducciones_patrono_otras_instituciones,
			gross_salary * (SELECT S.percentage FROM dbo.Social_charges_deduction AS S WHERE S.id_type = 5) AS deducciones_patrono_LPT
			FROM dbo.Employee
			WHERE id_employee BETWEEN @start AND @end
			SELECT * FROM #Lote
			INSERT INTO dbo.Payroll_detail (id_payroll, id_employee,net_salary,employer_deduction)
			SELECT IDENT_CURRENT('Payroll'),E.id_employee,
			L.gross_salary - L.impuesto + L.credito_conyuge + L.credito_hijos - L.deduccion_obrero_ccss - L.deduccion_obrero_LPT,
			L.deduccion_patrono_ccss + L.deduccion_patrono_otras_instituciones + L.deduccion_patrono_LPT
			FROM #Lote AS L INNER JOIN Employee AS E ON L.idn = E.idn AND E.id_employee BETWEEN @start AND @end
			
			
			SET @start = @end + 1
			SET @end = @start + 99999
		END

		UPDATE Payroll
		SET total_employees = @all_employees,
		employer_deductions = (SELECT SUM(employer_deduction) FROM dbo.Payroll_detail)
		WHERE id_payroll = IDENT_CURRENT('Payroll');
		

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		/*Brinda informacion del error*/
		SELECT
			ERROR_NUMBER() AS NumeroError,
			ERROR_STATE() AS EstadoError,
			ERROR_SEVERITY() AS SeveridadError,
			ERROR_PROCEDURE() AS ErrorDeProcedimiento,
			ERROR_LINE() AS LineaError,
			ERROR_MESSAGE() AS MensajeError
		/*Si la transaccion no se puede hacer commit*/
		IF (XACT_STATE()) = -1
			ROLLBACK TRANSACTION Calculo
		/*Si la transaccion puede hacer commit*/
		IF (XACT_STATE()) = 1
			COMMIT TRANSACTION Calculo
	END CATCH
END




EXEC calculate_deductions_by_employee
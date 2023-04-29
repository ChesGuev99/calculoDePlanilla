CREATE PROCEDURE calculate_deductions_by_employee(
	@cedula INT,
	@salario_bruto MONEY,
	@cantidad_hijos INT,
	@casado BIT,
	@id_regulation INT
) AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL
	READ COMMITTED
	
	DECLARE @impuesto DECIMAL(10, 2)
    DECLARE @deduccion_obrero_ccss DECIMAL(10, 2)
    DECLARE @deduccion_obrero_proteccion DECIMAL(10, 2)
    DECLARE @deduccion_patrono_ccss DECIMAL(10, 2)
    DECLARE @deduccion_patrono_otras_instituciones DECIMAL(10, 2)
    DECLARE @deduccion_patrono_proteccion DECIMAL(10, 2)
    DECLARE @credito_familiar DECIMAL(10, 2)
	DECLARE @salario_neto MONEY
	DECLARE @deduccion_patrono MONEY

	
	BEGIN TRY
		DECLARE @max_amount1 DECIMAL(10,2)
		DECLARE @max_amount2 DECIMAL(10,2)
		DECLARE @max_amount3 DECIMAL(10,2)
		DECLARE @max_amount4 DECIMAL(10,2)

		SET @max_amount1 = (SELECT end_range FROM dbo.Tax_deduction AS T WHERE T.id_regulation = @id_regulation and T.percentage = 0)
		SET @max_amount2 = (SELECT end_range FROM dbo.Tax_deduction AS T WHERE T.id_regulation = @id_regulation and T.percentage = 0.1)
		SET @max_amount3 = (SELECT end_range FROM dbo.Tax_deduction AS T WHERE T.id_regulation = @id_regulation and T.percentage = 0.15)
		SET @max_amount4 = (SELECT end_range FROM dbo.Tax_deduction AS T WHERE T.id_regulation = @id_regulation and T.percentage = 0.20)

		BEGIN TRANSACTION Calculo
		--Calcular impuestos de renta
		IF @salario_bruto <= @max_amount1
            SET @impuesto = 0
        ELSE IF @salario_bruto <= @max_amount2
            SET @impuesto = (@salario_bruto - @max_amount1) * 0.1
        ELSE IF @salario_bruto <= @max_amount3
            SET @impuesto = (@max_amount2 - @max_amount1) * 0.1 + (@salario_bruto - @max_amount2) * 0.15
        ELSE IF @salario_bruto <= @max_amount4
            SET @impuesto = (@max_amount2 - @max_amount1) * 0.1 + (@max_amount3 - @max_amount2) * 0.15 + (@salario_bruto - @max_amount3) * 0.2
        ELSE
            SET @impuesto = (@max_amount2 - @max_amount1) * 0.1 + (@max_amount3 - @max_amount2) * 0.15 + (@max_amount4 - @max_amount3) * 0.2 + (@salario_bruto - @max_amount4) * 0.25
		
		-- Calcular creditos familiares
		IF @casado = 1
            SET @credito_familiar = (SELECT F.amount FROM dbo.Family_credit AS F WHERE F.id_regulation = @id_regulation and F.id_type = 1)
        ELSE
            SET @credito_familiar = 0

        IF @cantidad_hijos >= 1 AND @cantidad_hijos <= 2
            SET @credito_familiar = @credito_familiar + @cantidad_hijos * (SELECT F.amount FROM dbo.Family_credit AS F WHERE F.id_regulation = @id_regulation and F.id_type = 2)

		-- Calcular deducciones de cargas sociales
        SET @deduccion_obrero_ccss = @salario_bruto * (SELECT S.percentage FROM dbo.Social_charges_deduction AS S WHERE S.id_type = 1)
        SET @deduccion_obrero_proteccion = @salario_bruto * (SELECT S.percentage FROM dbo.Social_charges_deduction AS S WHERE S.id_type = 2)
        SET @deduccion_patrono_ccss = @salario_bruto * (SELECT S.percentage FROM dbo.Social_charges_deduction AS S WHERE S.id_type = 3)
        SET @deduccion_patrono_otras_instituciones = @salario_bruto * (SELECT S.percentage FROM dbo.Social_charges_deduction AS S WHERE S.id_type = 4)
        SET @deduccion_patrono_proteccion = @salario_bruto * (SELECT S.percentage FROM dbo.Social_charges_deduction AS S WHERE S.id_type = 5)

		

		SET @salario_neto = @salario_bruto - @impuesto + @credito_familiar - @deduccion_obrero_ccss - @deduccion_obrero_proteccion
		SET @deduccion_patrono = @deduccion_patrono_ccss + @deduccion_patrono_otras_instituciones + @deduccion_patrono_proteccion

		INSERT INTO dbo.Payroll_detail (id_payroll, id_employee,net_salary,employer_deduction)
		VALUES ((SELECT IDENT_CURRENT('Payroll')),(SELECT E.id_employee FROM dbo.Employee AS E WHERE E.idn = @cedula),@salario_neto,@deduccion_patrono)

		UPDATE Payroll
		SET total_employees = (SELECT COUNT(*) FROM dbo.Payroll_detail WHERE id_payroll = IDENT_CURRENT('Payroll')),
			employer_deductions = employer_deductions + @deduccion_patrono
		WHERE id_payroll = IDENT_CURRENT('Payroll');

		PRINT 'Impuesto al salario: ' + CONVERT(VARCHAR(50), @impuesto)
        PRINT 'Crédito familiar: ' + CONVERT(VARCHAR(50), @credito_familiar)
        PRINT 'Deducción obrero CCSS: ' + CONVERT(VARCHAR(50), @deduccion_obrero_ccss)
		PRINT 'Deducción obrero Protección: ' + CONVERT(VARCHAR(50), @deduccion_obrero_proteccion)
		PRINT 'Deducción patrono CCSS: ' + CONVERT(VARCHAR(50), @deduccion_patrono_ccss)
		PRINT 'Deducción patrono Otras instituciones: ' + CONVERT(VARCHAR(50), @deduccion_patrono_otras_instituciones)
		PRINT 'Deducción patrono Protección: ' + CONVERT(VARCHAR(50), @deduccion_patrono_proteccion)
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

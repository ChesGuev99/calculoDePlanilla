-- get detail by id
ALTER PROCEDURE [dbo].[getDetailByID](
    @idn int
) AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED

BEGIN TRY
        DECLARE @id_employee INT
        DECLARE @id_payroll INT

SELECT @id_employee = id_employee FROM Employee WHERE idn = @idn

    IF @id_employee IS NOT NULL
BEGIN
SELECT @id_payroll = MAX(id_payroll) FROM Payroll

SELECT e.idn, e.name, e.lastname1, e.lastname2, e.gross_salary, pd.net_salary, pd.employer_deduction, pd.family_credit, pd.social_charges, pd.rent_taxes
FROM [dbo].[Payroll_detail] pd
    INNER JOIN Employee e ON e.id_employee = pd.id_employee
WHERE pd.id_payroll = @id_payroll AND pd.id_employee = @id_employee
END
ELSE
BEGIN
            RAISERROR('Invalid employee id',16,1)
            RETURN
END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH
END
-- get detail by id

CREATE PROCEDURE [dbo].[getDetailByID](
    @idn int
) AS
    BEGIN

    SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL
	READ COMMITTED
    BEGIN TRY

    DECLARE @id_employee INT
    DECLARE @id_payroll INT

        IF EXISTS (SELECT * FROM Employee WHERE idn = @idn)
            BEGIN
                SET @id_employee = (SELECT id_employee FROM Employee WHERE idn = @idn)
                BEGIN
                    SET @id_payroll = (SELECT MAX(id_payroll) FROM Payroll)
                    SELECT * FROM [dbo].[Payroll_detail] WHERE id_payroll = @id_payroll AND id_employee = @id_employee
                END
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
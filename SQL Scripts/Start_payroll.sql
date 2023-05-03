ALTER PROCEDURE start_payroll(
	@start_date datetime,
	@end_date datetime)
AS
BEGIN
	INSERT INTO  dbo.Payroll (id_regulation,start_date,end_date,total_employees,employer_deductions)
	VALUES(1,@start_date,@end_date,0,0)
END

go
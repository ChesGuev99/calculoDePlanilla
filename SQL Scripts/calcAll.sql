DROP TABLE if exists dbo.A

-- E J E C U C I O N   M A S I V A   D E   C A L C U L O S   :D

--para meterlo en un stored procedure se puede colocar los id de payroll y las fechas como parametros y hacer el insert en payroll_detail y payroll de una vez

--Se buscan las constantes determinadas en la base de datos
DECLARE @max_amount1 DECIMAL(10,2)
DECLARE @max_amount2 DECIMAL(10,2)
DECLARE @max_amount3 DECIMAL(10,2)
DECLARE @max_amount4 DECIMAL(10,2)

DECLARE @per1 DECIMAL(10,2)
DECLARE @per2 DECIMAL(10,2)
DECLARE @per3 DECIMAL(10,2)
DECLARE @per4 DECIMAL(10,2)
DECLARE @per5 DECIMAL(10,2)

SET @per1 = (SELECT percentage FROM dbo.Tax_deduction AS T WHERE T.id_tax = 1)
SET @per2 = (SELECT percentage FROM dbo.Tax_deduction AS T WHERE T.id_tax = 2)
SET @per3 = (SELECT percentage FROM dbo.Tax_deduction AS T WHERE T.id_tax = 3)
SET @per4 = (SELECT percentage FROM dbo.Tax_deduction AS T WHERE T.id_tax = 4)
SET @per5 = (SELECT percentage FROM dbo.Tax_deduction AS T WHERE T.id_tax = 5)

SET @max_amount1 = (SELECT end_range FROM dbo.Tax_deduction AS T WHERE T.id_tax = 1)
SET @max_amount2 = (SELECT end_range FROM dbo.Tax_deduction AS T WHERE T.id_tax = 2)
SET @max_amount3 = (SELECT end_range FROM dbo.Tax_deduction AS T WHERE T.id_tax = 3)
SET @max_amount4 = (SELECT end_range FROM dbo.Tax_deduction AS T WHERE T.id_tax = 4)


DECLARE @credito_hijos DECIMAL(10, 2)
DECLARE @credito_conyuge DECIMAL(10, 2)
SET @credito_conyuge = (SELECT F.amount FROM dbo.Family_credit AS F WHERE F.id_type = 1)
SET @credito_hijos = (SELECT F.amount FROM dbo.Family_credit AS F WHERE F.id_type = 1)


DECLARE @ccss DECIMAL(10, 2)
DECLARE @proteccion DECIMAL(10, 2)
DECLARE @patrono_ccss DECIMAL(10, 2)
DECLARE @dpatrono_otras_instituciones DECIMAL(10, 2)
DECLARE @patrono_proteccion DECIMAL(10, 2)

SET @ccss = (SELECT S.percentage FROM dbo.Social_charges_deduction AS S WHERE S.id_type = 1)
SET @proteccion = (SELECT S.percentage FROM dbo.Social_charges_deduction AS S WHERE S.id_type = 2)
SET @patrono_ccss =  (SELECT S.percentage FROM dbo.Social_charges_deduction AS S WHERE S.id_type = 3)
SET @dpatrono_otras_instituciones = (SELECT S.percentage FROM dbo.Social_charges_deduction AS S WHERE S.id_type = 4)
SET @patrono_proteccion =(SELECT S.percentage FROM dbo.Social_charges_deduction AS S WHERE S.id_type = 5)


--Se calcula los salarios netos y deduciones de patrono para cada categoria
SELECT id_employee, (gross_salary - gross_salary*@per1 + is_married*@credito_conyuge + kids_number*@credito_hijos - gross_salary*(@ccss + @proteccion)) as net_sal, (gross_salary*(@patrono_ccss+@dpatrono_otras_instituciones-@patrono_proteccion)) as employer_deduction INTO dbo.A FROM dbo.Employee WHERE gross_salary < @max_amount1;

SET IDENTITY_INSERT dbo.A ON;  

INSERT INTO dbo.A (id_employee, net_sal, employer_deduction)
SELECT id_employee, (gross_salary - gross_salary*@per2 + is_married*@credito_conyuge + kids_number*@credito_hijos - gross_salary*(@ccss + @proteccion)),(gross_salary*(@patrono_ccss+@dpatrono_otras_instituciones-@patrono_proteccion)) FROM dbo.Employee WHERE gross_salary < @max_amount2 AND gross_salary > @max_amount1;

INSERT INTO dbo.A (id_employee, net_sal, employer_deduction)
SELECT id_employee, (gross_salary - gross_salary*@per3 + is_married*@credito_conyuge + kids_number*@credito_hijos - gross_salary*(@ccss + @proteccion)),(gross_salary*(@patrono_ccss+@dpatrono_otras_instituciones-@patrono_proteccion)) FROM dbo.Employee WHERE gross_salary < @max_amount3 AND gross_salary > @max_amount2;

INSERT INTO dbo.A (id_employee, net_sal, employer_deduction)
SELECT id_employee, (gross_salary - gross_salary*@per4 + is_married*@credito_conyuge + kids_number*@credito_hijos - gross_salary*(@ccss + @proteccion)),(gross_salary*(@patrono_ccss+@dpatrono_otras_instituciones-@patrono_proteccion)) FROM dbo.Employee WHERE gross_salary < @max_amount4 AND gross_salary > @max_amount3;

INSERT INTO dbo.A (id_employee, net_sal, employer_deduction)
SELECT id_employee, (gross_salary - gross_salary*@per5 + is_married*@credito_conyuge + kids_number*@credito_hijos - gross_salary*(@ccss + @proteccion)),(gross_salary*(@patrono_ccss+@dpatrono_otras_instituciones-@patrono_proteccion)) FROM dbo.Employee WHERE gross_salary > @max_amount4;

-- SE CALCULA LA INFO DE payroll

DECLARE @total DECIMAL(10, 2)
DECLARE @total_deduction DECIMAL(10, 2)
SET @total = (SELECT COUNT(id_employee) FROM dbo.A);
SET @total_deduction = (SELECT SUM(employer_deduction) FROM dbo.A);
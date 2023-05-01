-- ORGANIZATION CRUD

-- Create Organization
CREATE PROCEDURE [dbo].[CreateOrganization]
@name varchar(50)
AS
BEGIN
    -- Check if organization name is not null and not already in the table
    IF(@name IS NULL OR EXISTS(SELECT * FROM Organization WHERE name = @name))
        BEGIN
            RAISERROR('Invalid organization name or organization already exists',16,1)
            RETURN
        END

    -- Insert the new organization
    INSERT INTO Organization(name)
    VALUES(@name)
END

-- Read All Organizations
CREATE PROCEDURE [dbo].[GetOrganizations]
AS
BEGIN
    SELECT * FROM Organization
END
-- Get Organization by Id
CREATE PROCEDURE [dbo].[GetOrganizationById]
@Id INT
AS
BEGIN
    IF NOT EXISTS(SELECT * FROM Organization WHERE id_organization = @Id)
        BEGIN
            RAISERROR('Invalid organization id',16,1)
            RETURN
        END
    SELECT * FROM Organization WHERE id_organization = @Id
END

-- Update Organization by Id
CREATE PROCEDURE [dbo].[UpdateOrganization]
@Id INT,
@name varchar(50)
AS
BEGIN
    -- Check if organization name is not null and not already in the table
    IF(@name IS NULL OR EXISTS(SELECT * FROM Organization WHERE name = @name))
        BEGIN
            RAISERROR('Invalid organization name or organization already exists',16,1)
            RETURN
        END

    -- Update the organization
    UPDATE Organization
    SET name = @name
    WHERE id_organization = @Id
END

-- Delete Organization by Id
CREATE PROCEDURE [dbo].[DeleteOrganization]
@Id INT
AS
BEGIN
    -- Check if organization exists
    IF NOT EXISTS(SELECT * FROM Organization WHERE id_organization = @Id)
        BEGIN
            RAISERROR('Invalid organization id',16,1)
            RETURN
        END

    -- "Delete" the organization, status changes to inactive = 0
    UPDATE Organization
    SET status = 0
    WHERE id_organization = @Id

    -- Delete all users from the organization
    DELETE FROM [Employee]
    WHERE id_organization = @Id

END

-- Delete all Organizations
CREATE PROCEDURE [dbo].[DeleteAllOrganizations]
AS
BEGIN
    -- "Delete" all organizations, status changes to inactive = 0
    UPDATE Organization
    SET status = 0

    -- Delete all users from all organizations
    UPDATE [Employee]
    SET status = 0
END


-- DEPARTMENT CRUD

-- Create Department
CREATE PROCEDURE [dbo].[CreateDepartment]
@name varchar(50)
AS
BEGIN
    -- Check if department name is not null and not already in the table
    IF(@name IS NULL OR EXISTS(SELECT * FROM Department WHERE name = @name))
        BEGIN
            RAISERROR('Invalid department name or department already exists',16,1)
            RETURN
        END

    -- Insert the new department
    INSERT INTO Department(name)
    VALUES(@name)
END

-- Read All Departments
CREATE PROCEDURE [dbo].[GetDepartments]
AS
BEGIN
    SELECT * FROM Department
END

-- Get Department by Id
CREATE PROCEDURE [dbo].[GetDepartmentById]
@Id INT
AS
BEGIN
    IF NOT EXISTS(SELECT * FROM Department WHERE id_department = @Id)
        BEGIN
            RAISERROR('Invalid department id',16,1)
            RETURN
        END
    SELECT * FROM Department WHERE id_department = @Id
END

-- Update Department by Id
CREATE PROCEDURE [dbo].[UpdateDepartment]
@Id INT,
@name varchar(50)
AS
BEGIN
    -- Check if department name is not null and not already in the table
    IF(@name IS NULL OR EXISTS(SELECT * FROM Department WHERE name = @name))
        BEGIN
            RAISERROR('Invalid department name or department already exists',16,1)
            RETURN
        END

    -- Update the department
    UPDATE Department
    SET name = @name
    WHERE id_department = @Id
END

-- Delete Department by Id
CREATE PROCEDURE [dbo].[DeleteDepartment]
@Id INT
AS
BEGIN
    -- Check if department exists
    IF NOT EXISTS(SELECT * FROM Department WHERE id_department = @Id)
        BEGIN
            RAISERROR('Invalid department id',16,1)
            RETURN
        END

    -- "Delete" the department, status changes to inactive = 0
    UPDATE Department
    SET status = 0
    WHERE id_department = @Id

    -- Delete all users from the department
    DELETE FROM [Employee]
    WHERE id_department = @Id

END

-- Delete all Departments
CREATE PROCEDURE [dbo].[DeleteAllDepartments]
AS
BEGIN
    -- "Delete" all departments, status changes to inactive = 0
    UPDATE Department
    SET status = 0

    -- Delete all users from all departments
    UPDATE [Employee]
    SET status = 0
END


-- EMPLOYEE CRUD

-- Create Employee
CREATE PROCEDURE [dbo].[CreateEmployee]
@name varchar(50),
@dni int,
@lastname1 varchar(50),
@lastname2 varchar(50),
@gross_salary int,
@birthdate datetime,
@id_organization int,
@id_department int,
@kids_number int,
@is_married bit,
@status int
AS
BEGIN
    -- Check if employee name is not null and not already in the table
    IF(@name IS NULL OR @dni IS NULL OR @lastname1 IS NULL OR @lastname2 IS NULL
           OR @gross_salary IS NULL OR @birthdate IS NULL OR @id_organization IS NULL
           OR @id_department IS NULL OR @kids_number IS NULL OR @is_married IS NULL OR @status IS NULL)
        BEGIN
            RAISERROR('Invalid data, all spaces must be filled',16,1)
            RETURN
        END

    -- Check if organization exists
    IF NOT EXISTS(SELECT * FROM Organization WHERE id_organization = @id_organization)
        BEGIN
            RAISERROR('Invalid organization id',16,1)
            RETURN
        END

    -- Check if department exists
    IF NOT EXISTS(SELECT * FROM Department WHERE id_department = @id_department)
        BEGIN
            RAISERROR('Invalid department id',16,1)
            RETURN
        END

    -- Insert the new employee
    INSERT INTO Employee(name,idn,lastname1,lastname2,gross_salary,birthdate,id_organization,id_department,kids_number,is_married,status)
    VALUES(@name,@dni,@lastname1,@lastname2,@gross_salary,@birthdate,@id_organization,@id_department,@kids_number,@is_married,@status)
END

-- Read All Employees
CREATE PROCEDURE [dbo].[GetEmployees]
AS
BEGIN
    SELECT * FROM Employee
END

-- Get Employee by Id
CREATE PROCEDURE [dbo].[GetEmployeeById]
@Id INT
AS
BEGIN
    IF NOT EXISTS(SELECT * FROM Employee WHERE id_employee = @Id)
        BEGIN
            RAISERROR('Invalid employee id',16,1)
            RETURN
        END
    SELECT * FROM Employee WHERE id_employee = @Id
END

-- Get all employees from an organization
CREATE PROCEDURE [dbo].[GetUsersFromOrganization]
@Id INT
AS
BEGIN
    -- Check if organization exists
    IF NOT EXISTS(SELECT * FROM Organization WHERE id_organization = @Id)
        BEGIN
            RAISERROR('Invalid organization id',16,1)
            RETURN
        END

    -- Get all users from the organization
    SELECT * FROM [Employee]
    WHERE id_organization = @Id
END

-- Get all employees from a department
CREATE PROCEDURE [dbo].[GetUsersFromDepartment]
@Id INT
AS
BEGIN
    -- Check if department exists
    IF NOT EXISTS(SELECT * FROM Department WHERE id_department = @Id)
        BEGIN
            RAISERROR('Invalid department id',16,1)
            RETURN
        END

    -- Get all users from the department
    SELECT * FROM [Employee]
    WHERE id_department = @Id
END

-- Update Employee by Id
CREATE PROCEDURE [dbo].[UpdateEmployee]
@Id INT,
@name varchar(50),
@dni int,
@lastname1 varchar(50),
@lastname2 varchar(50),
@gross_salary int,
@birthdate datetime,
@id_organization int,
@id_department int,
@kids_number int,
@is_married bit,
@status int
AS
    BEGIN

    -- Check if employee exists
    IF NOT EXISTS(SELECT * FROM Employee WHERE id_employee = @Id)
        BEGIN
            RAISERROR('Invalid employee id',16,1)
            RETURN
        END

    -- Check if organization exists
    IF @id_organization IS NOT NULL AND (NOT EXISTS(SELECT * FROM Organization WHERE id_organization = @id_organization))
        BEGIN
            RAISERROR('Invalid organization id',16,1)
            RETURN
        END

    -- Check if department exists
    IF @id_department IS NOT NULL AND (NOT EXISTS(SELECT * FROM Department WHERE id_department = @id_department))
        BEGIN
            RAISERROR('Invalid department id',16,1)
            RETURN
        END

    -- Update the employee if the parameter is not null
    UPDATE Employee
    SET name = ISNULL(@name,name),
        idn = ISNULL(@dni,idn),
        lastname1 = ISNULL(@lastname1,lastname1),
        lastname2 = ISNULL(@lastname2,lastname2),
        gross_salary = ISNULL(@gross_salary,gross_salary),
        birthdate = ISNULL(@birthdate,birthdate),
        id_organization = ISNULL(@id_organization,id_organization),
        id_department = ISNULL(@id_department,id_department),
        kids_number = ISNULL(@kids_number,kids_number),
        is_married = ISNULL(@is_married,is_married),
        status = ISNULL(@status,status)
    WHERE id_employee = @Id

END

-- Delete Employee by Id
CREATE PROCEDURE [dbo].[DeleteEmployee]
@Id INT
AS
BEGIN
    -- Check if employee exists
    IF NOT EXISTS(SELECT * FROM Employee WHERE id_employee = @Id)
        BEGIN
            RAISERROR('Invalid employee id',16,1)
            RETURN
        END

    -- "Delete" the employee, status changes to inactive = 0
    UPDATE Employee
    SET status = 0
    WHERE id_employee = @Id
END

-- Delete all Employees
CREATE PROCEDURE [dbo].[DeleteAllEmployees]
AS
BEGIN
    -- "Delete" all employees, status changes to inactive = 0
    UPDATE Employee
    SET status = 0
END







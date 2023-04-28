create table Organization
(
    id_organization int identity
        primary key,
    name            varchar(50) not null,
    status          bit         not null
)
go


create table Department
(
    id_department int         not null
        primary key,
    name          varchar(50) not null,
    status          bit         not null
)
go


create table Employee
(
    id_employee     int identity
        primary key,
    idn             int         not null
        unique,
    name            varchar(50) not null,
    lastname1       varchar(50) not null,
    lastname2       varchar(50) not null,
    gross_salary    money       not null,
    birthdate       datetime    not null,
    id_organization int         not null
        constraint Employee_Organization_id_fk
            references Organization,
    id_department   int         not null
        constraint Employee_Department_id_fk
            references Department,
    kids_number     int         not null,
    is_married      bit         not null,
    status          bit         not null
)
go


create table Regulation
(
    id_regulation int identity
        primary key,
    update_date   date not null,
    status          bit         not null
)
go


create table Payroll
(
    id_payroll          int identity
        primary key,
    id_regulation       int      not null
        constraint Payroll_Regulation_id_regulation_fk
            references Regulation,
    start_date          datetime not null,
    end_date            datetime not null,
    total_employees     int      not null,
    employer_deductions money    not null,
    status          bit         not null
)
go


create table Payroll_detail
(
    id_payroll_detail  int identity
        primary key,
    id_payroll         int   not null
        constraint Payroll_detail_Payroll_id_payroll_fk
            references Payroll (id_payroll),
    id_employee        int   not null
        constraint Payroll_detail_Employee_id_employee_fk
            references Employee,
    net_salary         money not null,
    employer_deduction money not null,
    status          bit         not null

)
go


create table Social_charges_type
(
    id_type int identity
        primary key,
    type     varchar(50) not null,
    status          bit         not null

)
go


create table Social_charges_deduction
(
    id_social_charges int identity
        primary key,
    id_regulation     int   not null
        constraint Social_charges_deduction_Regulation_id_regulation_fk
            references Regulation,
    id_type           int   not null
        constraint Social_charges_deduction_Social_charges_type_id_type_fk
            references Social_charges_type,
    percentage        float not null,
    status          bit         not null
)
go


create table Credit_type
(
    id_credit_type int identity
        primary key,
    type           varchar(50) not null,
    status          bit         not null
)
go


create table Family_credit
(
    id_family_credit int identity
        primary key,
    id_type          int   not null
        constraint Family_credit_Regulation_id_regulation_fk
            references Credit_type,
    amount           money not null,
    status          bit         not null
)
go


create table Tax_deduction
(
    id_tax        int identity
        primary key,
    id_regulation int   not null
        constraint Tax_deduction_Regulation_id_regulation_fk
            references Regulation,
    start_range   money not null,
    end_range     money not null,
    percentage    float not null,
    status          bit         not null
)
go
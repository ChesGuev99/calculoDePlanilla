--Datos Tipos Creditos Familiares
INSERT INTO dbo.Credit_type(type)
VALUES ('Conyuge')
INSERT INTO dbo.Credit_type(type)
VALUES ('Hijos')

-- Datos Tipos Cargas Sociales
INSERT INTO dbo.Social_charges_type(type)
VALUES ('Obrero CCSS')
INSERT INTO dbo.Social_charges_type(type)
VALUES ('Obrero LPT')
INSERT INTO dbo.Social_charges_type(type)
VALUES ('Patrono CCSS')
INSERT INTO dbo.Social_charges_type(type)
VALUES ('Patrono Otras Instituciones')
INSERT INTO dbo.Social_charges_type(type)
VALUES ('Patrono LPT')

--Datos Departamento
insert into Department (name, status) values ('Recursos Humanos',1);
insert into Department (name, status) values ('Marketing',1);
insert into Department (name, status) values ('Ventas',1);
insert into Department (name, status) values ('Contabilidad',1);
insert into Department (name, status) values ('Tecnología de la Información',1);
insert into Department (name, status) values ('Investigación y Desarrollo',1);
insert into Department (name, status) values ('Legal',1);
insert into Department (name) values ('Servicio al Cliente');
insert into Department (name) values ('Desarrollo de Negocios');
insert into Department (name) values ('Finanzas');
insert into Department (name) values ('Operaciones');
insert into Department (name) values ('Producción');
insert into Department (name) values ('Administración');
insert into Department (name) values ('Relaciones Públicas');
insert into Department (name) values ('Aseguramiento de Calidad');
insert into Department (name) values ('Compras');
insert into Department (name) values ('Logística');
insert into Department (name) values ('Cadena de Suministro');
insert into Department (name) values ('Gestión de Instalaciones');
insert into Department (name) values ('Gestión de Proyectos');
insert into Department (name) values ('Comunicaciones');
insert into Department (name) values ('Entrenamiento y Desarrollo');
insert into Department (name) values ('Innovación');
insert into Department (name) values ('Gestión de Riesgos');

-- Datos Organización
INSERT INTO dbo.Organization (name,status) VALUES('Google',1);
INSERT INTO dbo.Organization (name,status) VALUES('Apple'   ,1);
INSERT INTO dbo.Organization (name,status) VALUES('Microsoft',1);
INSERT INTO dbo.Organization (name,status) VALUES('Amazon',1);
INSERT INTO dbo.Organization (name,status) VALUES('Facebook',1);
INSERT INTO dbo.Organization (name,status) VALUES('IBM',1);
INSERT INTO dbo.Organization (name,status) VALUES('Cisco Systems',1);
INSERT INTO dbo.Organization (name,status) VALUES('Intel',1);
INSERT INTO dbo.Organization (name,status) VALUES('Oracle',1);
INSERT INTO dbo.Organization (name,status) VALUES('Dell',1);
INSERT INTO dbo.Organization (name,status) VALUES('HP Inc.',1);
INSERT INTO dbo.Organization (name,status) VALUES('Samsung',1);
INSERT INTO dbo.Organization (name,status) VALUES('Sony',1);
INSERT INTO dbo.Organization (name,status) VALUES('LG',1);
INSERT INTO dbo.Organization (name,status) VALUES('Panasonic',1);
INSERT INTO dbo.Organization (name,status) VALUES('Philips',1);
INSERT INTO dbo.Organization (name,status) VALUES('Siemens',1);
INSERT INTO dbo.Organization (name,status) VALUES('Volkswagen',1);
INSERT INTO dbo.Organization (name,status) VALUES('Toyota',1);
INSERT INTO dbo.Organization (name,status) VALUES('General Motors',1);
INSERT INTO dbo.Organization (name,status) VALUES('Ford',1);
INSERT INTO dbo.Organization (name,status) VALUES('BMW',1);
INSERT INTO dbo.Organization (name,status) VALUES('Audi',1);
INSERT INTO dbo.Organization (name,status) VALUES('Mercedes-Benz',1);
INSERT INTO dbo.Organization (name,status) VALUES('Porsche',1);
INSERT INTO dbo.Organization (name,status) VALUES('Boeing',1);
INSERT INTO dbo.Organization (name,status) VALUES('Airbus',1);
INSERT INTO dbo.Organization (name,status) VALUES('Lockheed Martin',1);
INSERT INTO dbo.Organization (name,status) VALUES('Raytheon Technologies',1);
INSERT INTO dbo.Organization (name,status) VALUES('Northrop Grumman',1);
INSERT INTO dbo.Organization (name,status) VALUES('General Electric',1);
INSERT INTO dbo.Organization (name,status) VALUES('Honeywell',1);
INSERT INTO dbo.Organization (name,status) VALUES('Procter & Gamble',1);
INSERT INTO dbo.Organization (name,status) VALUES('Unilever',1);
INSERT INTO dbo.Organization (name,status) VALUES('Nestle',1);
INSERT INTO dbo.Organization (name,status) VALUES('PepsiCo',1);
INSERT INTO dbo.Organization (name,status) VALUES('Coca-Cola',1);
INSERT INTO dbo.Organization (name,status) VALUES('Johnson & Johnson',1);
INSERT INTO dbo.Organization (name,status) VALUES('Pfizer',1);
INSERT INTO dbo.Organization (name,status) VALUES('Novartis',1);
INSERT INTO dbo.Organization (name,status) VALUES('Merck',1);
INSERT INTO dbo.Organization (name,status) VALUES('Roche',1);
INSERT INTO dbo.Organization (name,status) VALUES('Bristol Myers Squibb',1);
INSERT INTO dbo.Organization (name,status) VALUES('AstraZeneca',1);
INSERT INTO dbo.Organization (name,status) VALUES('GlaxoSmithKline',1);
INSERT INTO dbo.Organization (name,status) VALUES('ExxonMobil',1);
INSERT INTO dbo.Organization (name,status) VALUES('Royal Dutch Shell',1);
INSERT INTO dbo.Organization (name,status) VALUES('BP',1);
INSERT INTO dbo.Organization (name,status) VALUES('Chevron',1);
INSERT INTO dbo.Organization (name,status) VALUES('Total',1);
INSERT INTO dbo.Organization (name,status) VALUES('Eni',1);
INSERT INTO dbo.Organization (name,status) VALUES('Gazprom',1);
INSERT INTO dbo.Organization (name,status) VALUES('Rosneft',1);
INSERT INTO dbo.Organization (name,status) VALUES('PetroChina',1);
INSERT INTO dbo.Organization (name,status) VALUES('Sinopec',1);
INSERT INTO dbo.Organization (name,status) VALUES('Alibaba Group',1);
INSERT INTO dbo.Organization (name,status) VALUES('Tencent Holdings',1);
INSERT INTO dbo.Organization (name,status) VALUES('Baidu',1);
INSERT INTO dbo.Organization (name,status) VALUES('JD.com',1);
INSERT INTO dbo.Organization (name,status) VALUES('ByteDance',1);
INSERT INTO dbo.Organization (name,status) VALUES('Huawei',1);
INSERT INTO dbo.Organization (name,status) VALUES('Xiaomi',1);
INSERT INTO dbo.Organization (name,status) VALUES('Nokia',1);
INSERT INTO dbo.Organization (name,status) VALUES('AT&T',1);
INSERT INTO dbo.Organization (name,status) VALUES('Verizon Communications',1);
INSERT INTO dbo.Organization (name,status) VALUES('Comcast',1);
INSERT INTO dbo.Organization (name,status) VALUES('Charter Communications',1);
INSERT INTO dbo.Organization (name,status) VALUES('T-Mobile US',1);
INSERT INTO dbo.Organization (name,status) VALUES('Sprint Corporation',1);
INSERT INTO dbo.Organization (name,status) VALUES('Deutsche Telekom',1);
INSERT INTO dbo.Organization (name,status) VALUES('Vodafone Group',1);
INSERT INTO dbo.Organization (name,status) VALUES('Orange S.A.',1);
INSERT INTO dbo.Organization (name,status) VALUES('Telefonica',1);
INSERT INTO dbo.Organization (name,status) VALUES('American Express',1);
INSERT INTO dbo.Organization (name,status) VALUES('Visa Inc.',1);
INSERT INTO dbo.Organization (name,status) VALUES('Mastercard',1);
INSERT INTO dbo.Organization (name,status) VALUES('PayPal',1);
INSERT INTO dbo.Organization (name,status) VALUES('Goldman Sachs',1);
INSERT INTO dbo.Organization (name,status) VALUES('JPMorgan Chase',1);
INSERT INTO dbo.Organization (name,status) VALUES('Bank of America',1);
INSERT INTO dbo.Organization (name,status) VALUES('Wells Fargo',1);
INSERT INTO dbo.Organization (name,status) VALUES('Citigroup',1);
INSERT INTO dbo.Organization (name,status) VALUES('Morgan Stanley',1);
INSERT INTO dbo.Organization (name,status) VALUES('Barclays',1);
INSERT INTO dbo.Organization (name,status) VALUES('HSBC',1);
INSERT INTO dbo.Organization (name,status) VALUES('Deutsche Bank',1);
INSERT INTO dbo.Organization (name,status) VALUES('Credit Suisse',1);
INSERT INTO dbo.Organization (name,status) VALUES('UBS Group',1);
INSERT INTO dbo.Organization (name,status) VALUES('AXA',1);
INSERT INTO dbo.Organization (name,status) VALUES('Allianz',1);
INSERT INTO dbo.Organization (name,status) VALUES('Prudential',1);
INSERT INTO dbo.Organization (name,status) VALUES('MetLife',1);
INSERT INTO dbo.Organization (name,status) VALUES('AIG',1);
INSERT INTO dbo.Organization (name,status) VALUES('Berkshire Hathaway',1);
INSERT INTO dbo.Organization (name,status) VALUES('Warren Buffett',1);
INSERT INTO dbo.Organization (name,status) VALUES('BlackRock',1);
INSERT INTO dbo.Organization (name,status) VALUES('Vanguard Group',1);
INSERT INTO dbo.Organization (name,status) VALUES('Fidelity Investments',1);
INSERT INTO dbo.Organization (name,status) VALUES('TELSTAR',1);

-- Datos regulaciones
INSERT INTO dbo.Regulation (update_date,status) VALUES('2022/12/31',1)

-- Datos Impuestos
INSERT INTO dbo.Tax_deduction (id_regulation,start_range,end_range,percentage,status) VALUES(1,0,941000,0           ,1)
INSERT INTO dbo.Tax_deduction (id_regulation,start_range,end_range,percentage,status) VALUES(1,941000,1381000,0.1   ,1)
INSERT INTO dbo.Tax_deduction (id_regulation,start_range,end_range,percentage,status) VALUES(1,1381000,2243000,0.15 ,1)
INSERT INTO dbo.Tax_deduction (id_regulation,start_range,end_range,percentage,status) VALUES(1,2243000,4845000,0.2  ,1)
INSERT INTO dbo.Tax_deduction (id_regulation,start_range,end_range,percentage,status) VALUES(1,4845000,50000000,0.25,1)

-- Datos Cargas Sociales
INSERT INTO dbo.Social_charges_deduction(id_regulation,id_type,percentage,status) VALUES(1,1,0.0967,1)
INSERT INTO dbo.Social_charges_deduction(id_regulation,id_type,percentage,status) VALUES(1,2,0.01  ,1 )
INSERT INTO dbo.Social_charges_deduction(id_regulation,id_type,percentage,status) VALUES(1,3,0.1467,1)
INSERT INTO dbo.Social_charges_deduction(id_regulation,id_type,percentage,status) VALUES(1,4,0.0725,1)
INSERT INTO dbo.Social_charges_deduction(id_regulation,id_type,percentage,status) VALUES(1,5,0.0475,1)

-- Datos Creditos Familiares
INSERT INTO dbo.Family_credit(id_type,amount,status) VALUES(1,2650,1)
INSERT INTO dbo.Family_credit(id_type,amount,status) VALUES(2,1750,1)

  insert into dbo.Employee (idn, name, lastname1, lastname2, gross_salary, birthdate, id_organization,
                            id_department, kids_number, is_married, status)
                    VALUES (100010209,"SARA","CHACON","PAUT",11658757.0,8/12/2005 01:13,6.0,7.0,1,true,1)
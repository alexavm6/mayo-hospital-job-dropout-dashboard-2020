--create the database
CREATE DATABASE mayoHospital;


--use the database
USE mayoHospital;


--create an schema for the tables and more
create schema humanResources;



--we import the csv file into a new table in the database
--show the table
SELECT * FROM humanResources.employees;



--adding a new columns
BEGIN TRAN

ALTER TABLE humanResources.employees
ADD
	edad INT NULL,
	intervalo NVARCHAR(10) NULL,
	icono NVARCHAR(1) NULL

SELECT * FROM humanResources.employees

COMMIT TRAN





--set administracion instead of admin in the area column
BEGIN TRAN

UPDATE
	humanResources.employees
SET
	area =
		CASE
			WHEN area = 'Admin' THEN 'Administracion'
			ELSE area
		END

SELECT
	DISTINCT area
FROM 
	humanResources.employees

SELECT * FROM humanResources.employees

COMMIT TRAN





--filling the edad column
BEGIN TRAN

UPDATE
	humanResources.employees
SET
	edad = 
		FLOOR(
			   DATEDIFF(
					  DAY,
					  fechaNacimiento,
					  GETDATE()
			   )
			   / 365.0
			 )


SELECT * FROM humanResources.employees

COMMIT TRAN




--filling the intervalo column with the ranges
--there are ages from 19 to 61
--use the follow intervals
--18-25
--26-35
--36-45
--46-55
--56 o Más

BEGIN TRAN

UPDATE
	humanResources.employees
SET
	intervalo = 
		CASE
			WHEN edad <= 25 THEN '18-25'
			WHEN edad <= 35 THEN '26-35'
			WHEN edad <= 45 THEN '36-45'
			WHEN edad <= 55 THEN '46-55'
			ELSE '56 o Mas'
		END


SELECT * FROM humanResources.employees

COMMIT TRAN





--filling the icono column
BEGIN TRAN

UPDATE
	humanResources.employees
SET
	icono = 
		CASE
			WHEN genero = 'Masculino' THEN 'M'
			WHEN genero = 'Femenino' THEN 'F'
		END


SELECT * FROM humanResources.employees

COMMIT TRAN




--analysis of the column estado
DECLARE @totalCount FLOAT = (SELECT COUNT(*) FROM humanResources.employees)

SELECT @totalCount AS totalCountOfEmployees

SELECT
	estado,
	COUNT(*) AS SumOfEmployees,
	CAST((COUNT(*) / @totalCount * 100) AS DECIMAL(10,2)) AS PercentageOfTotal
FROM
	humanResources.employees
GROUP BY
	estado






--analysis of the column intervalo and genero
SELECT
	intervalo,
	genero,
	COUNT(*) AS SumOfEmployees
FROM
	humanResources.employees
WHERE
	estado = 'Retirado'
GROUP BY
	intervalo,
	genero
ORDER BY
	intervalo ASC












--analysis of job dropout in column genero
DECLARE @totalCount FLOAT = (SELECT COUNT(*) FROM humanResources.employees WHERE estado = 'Retirado')

SELECT @totalCount AS totalCountOfEmployeesRetired

SELECT
	genero,
	COUNT(*) AS SumOfEmployees,
	CAST((COUNT(*) / @totalCount * 100) AS DECIMAL(10,2)) AS PercentageOfTotal
FROM
	humanResources.employees
WHERE
	estado = 'Retirado'
GROUP BY
	genero






--analysis of job dropout in the column estudios
SELECT
	estudios,
	COUNT(*) AS SumOfEmployees
FROM
	humanResources.employees
WHERE
	estado = 'Retirado'
GROUP BY
	estudios










--analysis of job dropout in the column area
SELECT
	area,
	COUNT(*) AS SumOfEmployees
FROM
	humanResources.employees
WHERE
	estado = 'Retirado'
GROUP BY
	area







--analysis of the column cargo
SELECT
	TOP 10 cargo,
	COUNT(*) AS SumOfEmployees
FROM
	humanResources.employees
WHERE
	estado = 'Retirado'
GROUP BY
	cargo
ORDER BY
	SumOfEmployees DESC







--analysis of the column capacitado
SELECT
	capacitado,
	COUNT(*) AS SumOfEmployees
FROM
	humanResources.employees
WHERE
	estado = 'Retirado'
GROUP BY
	capacitado










--analysis of the column edad
SELECT
	AVG(edad) AS AverageAge
FROM
	humanResources.employees













--analysis of the column motivo
SELECT
	motivo,
	COUNT(*) AS SumOfEmployees
FROM
	humanResources.employees
WHERE
	estado = 'Retirado'
GROUP BY
	motivo




--analysis of the column distancia trabajo
DECLARE @totalCount FLOAT = (SELECT COUNT(*) FROM humanResources.employees WHERE estado = 'Retirado')

SELECT @totalCount AS totalCountOfEmployeesRetired

SELECT
	distanciaTrabajo,
	COUNT(*) AS SumOfEmployees,
	CAST((COUNT(*) / @totalCount * 100) AS DECIMAL(10,2)) AS PercentageOfTotal,
	CAST((100 - (COUNT(*) / @totalCount * 100)) AS DECIMAL(10,2)) AS TheRestOfPorcentage
FROM
	humanResources.employees
WHERE
	estado = 'Retirado'
GROUP BY
	distanciaTrabajo

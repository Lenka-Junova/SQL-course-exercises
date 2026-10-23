-- Exercises and data from https://skoleni-sql.vercel.app/ Thank you very much for workshop.
SELECT * FROM ODDEL
SELECT * FROM ZAM
SELECT * FROM UKOLY

-- Annual salary if there is 13th salary (5000)
SELECT JMENO,
	PLAT,
	(PLAT*12)+5000 AS [TŘINÁCTÝ PLAT]
	FROM ZAM

--Salaries of employees with academic title
SELECT JMENO, 
	PLAT, 
	TITUL
FROM ZAM
WHERE TITUL IS NOT NULL

-- Employees in dpt 3 with salary over 6000
SELECT JMENO
FROM ZAM
WHERE CIS_ODD = 3  AND PLAT > 6000;

-- Employees with academic title 'Ing' in dpt 2 and 6
SELECT JMENO
FROM ZAM
WHERE TITUL = 'ING' AND CIS_ODD IN (2, 6)

-- Show tasks for each employee who has assigned any
SELECT ZAM.OS_CIS,
	ZAM.JMENO, 
	U.POPIS
FROM ZAM
JOIN UKOLY U ON ZAM.OS_CIS = U.OS_CIS

-- List employees who have any task
SELECT DISTINCT ZAM.JMENO
FROM ZAM
JOIN UKOLY U ON ZAM.OS_CIS = U.OS_CIS
WHERE CIS_UK IS NOT NULL

-- List tasks for each dpt
SELECT U.POPIS, 
	O.NAZEV
FROM ODDEL O
JOIN ZAM Z ON O.CIS_ODD = Z.CIS_ODD
JOIN UKOLY U ON Z.OS_CIS = U.OS_CIS

-- List dpts with tasks
SELECT DISTINCT O.CIS_ODD,
	O.NAZEV
FROM ODDEL O
JOIN ZAM Z ON Z.CIS_ODD = O.CIS_ODD
JOIN UKOLY U ON Z.OS_CIS = U.OS_CIS

-- List employees with tasks from 'Programovani' dpt
SELECT Z.JMENO
FROM ZAM Z
JOIN ODDEL O ON Z.CIS_ODD = O.CIS_ODD
JOIN UKOLY U ON Z.OS_CIS = U.OS_CIS
WHERE O.NAZEV = 'PROGRAMOVANI'

-- List employees by dpt (ascending) and salary (descending)
SELECT JMENO, 
	PLAT, 
	CIS_ODD
FROM ZAM
ORDER BY CIS_ODD ASC, PLAT DESC

-- List tasks by dpt and employee
SELECT U.CIS_UK, 
	U.POPIS, 
	Z.JMENO, 
	O.NAZEV
FROM UKOLY U
JOIN ZAM Z ON Z.OS_CIS = U.OS_CIS
JOIN ODDEL O ON O.CIS_ODD = Z.CIS_ODD
ORDER BY O.NAZEV

-- Employees with name beginning on K 
SELECT COUNT(*)
FROM ZAM
WHERE JMENO LIKE 'K%'

-- Average salary per position
SELECT FCE, 
	AVG(PLAT) AS 'AVERAGE SALARY'
FROM ZAM
GROUP BY FCE
ORDER BY AVG(PLAT)

-- List how many employees have no title and earn less than 12000 per dpt
SELECT CIS_ODD, 
	COUNT(*) AS 'EMPLOYEES'
FROM ZAM
WHERE TITUL IS NOT NULL AND PLAT < 12000
GROUP BY CIS_ODD
ORDER BY COUNT(*) DESC

-- Number of tasks per employee (alphabetically)
SELECT Z.JMENO, COUNT(DISTINCT U.CIS_UK)
FROM ZAM Z
LEFT JOIN UKOLY U ON Z.OS_CIS = U.OS_CIS
GROUP BY Z.JMENO, Z.OS_CIS
ORDER BY Z.JMENO ASC

-- Names of dpts where max salary is under 12000
SELECT O.CIS_ODD, 
	O.NAZEV, 
	MAX(PLAT) AS 'MAX PLAT'
FROM ODDEL O
JOIN ZAM Z ON O.CIS_ODD = Z.CIS_ODD
GROUP BY O.NAZEV,  O.CIS_ODD
HAVING MAX(Z.PLAT) < 12000

-- What positions have at least 2 engineers
SELECT FCE
FROM ZAM
WHERE TITUL = 'ING'
GROUP BY FCE
HAVING COUNT(TITUL) >= 2;

-- Employees with academic title, displayed as a sentence
SELECT CONCAT_WS(' ', JMENO, 'JE', TITUL, '.') AS 'Věta'
FROM ZAM 
WHERE TITUL IS NOT NULL




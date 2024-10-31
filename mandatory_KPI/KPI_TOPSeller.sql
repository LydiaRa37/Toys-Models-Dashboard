-- CA DEUX MEILLEURS VENDEURS MENSUEL AVEC CLASSEMENT (colonne nom prenom reunie)
CREATE VIEW CA_topratedsellers_vw AS
(WITH MonthlySales AS (
    SELECT 
        e.employeeNumber, 
        e.lastName AS lastname_employe,
        e.firstName AS firstname_employe,
        YEAR(o.orderDate) AS year, 
        MONTH(o.orderDate) AS mois, 
        SUM(od.quantityOrdered * od.priceEach) AS CA
    FROM employees e
    JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    GROUP BY e.employeeNumber, e.lastName, e.firstName, YEAR(o.orderDate), MONTH(o.orderDate)
),

RankedSales AS (
    SELECT 
        ms.employeeNumber, 
        CONCAT(ms.firstname_employe, ' ', ms.lastname_employe) AS fullname_employe,
        ms.year, 
        ms.mois, 
        ms.CA,
        RANK() OVER (PARTITION BY ms.year, ms.mois ORDER BY ms.CA DESC) AS classement
    FROM MonthlySales ms
)

SELECT 
    rs.employeeNumber AS salesRepEmployeeNumber, 
    CONCAT(rs.year, '-', LPAD(rs.mois, 2, '0')) AS mois, 
    rs.fullname_employe,
    rs.CA, 
    rs.classement
FROM RankedSales rs
WHERE rs.classement <= 2
ORDER BY rs.year DESC, rs.mois DESC, rs.classement);

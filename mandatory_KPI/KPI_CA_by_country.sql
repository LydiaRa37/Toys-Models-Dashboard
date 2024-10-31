-- CA des 5 derniers mois/pays 

CREATE VIEW ca_month_country_vw AS
(SELECT 
    c.country,
    YEAR(o.orderDate) AS orderYear,
    MONTH(o.orderDate) AS orderMonth,
    SUM(od.quantityOrdered * od.priceEach) AS totalRevenue
FROM 
    customers c
JOIN 
    orders o ON c.customerNumber = o.customerNumber
JOIN 
    orderdetails od ON o.orderNumber = od.orderNumber
WHERE 
    (YEAR(o.orderDate) = 2024) OR (YEAR(o.orderDate) = 2023 AND MONTH(o.orderDate) >= 10) 
GROUP BY 
    c.country, YEAR(o.orderDate), MONTH(o.orderDate)
ORDER BY 
    c.country, orderYear, orderMonth);
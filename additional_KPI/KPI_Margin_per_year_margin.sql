-- Marge BRUTE/par an

CREATE VIEW year_margin_vw AS
(SELECT YEAR(o.orderDate) AS year,
SUM((od.priceEach - p.buyPrice) * od.quantityOrdered) AS grossMargin
FROM 
orderdetails od
JOIN 
orders o ON od.orderNumber = o.orderNumber
JOIN 
products p ON od.productCode = p.productCode
GROUP
BY YEAR(o.orderDate)
ORDER BY 
year);

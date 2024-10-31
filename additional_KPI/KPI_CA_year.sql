-- CA global/ année
CREATE VIEW ca_year_vw AS
(SELECT YEAR(o.orderDate) AS year,
SUM(od.priceEach * od.quantityOrdered) AS globalRevenue
FROM orders o
JOIN 
orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY 
YEAR(o.orderDate)
ORDER BY 
year);

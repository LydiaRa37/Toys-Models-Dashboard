-- Les % clients qui font le plus de CA 

CREATE VIEW top_client_vw AS
(SELECT c.customerNumber, c.customerName, 
    SUM(od.quantityOrdered * od.priceEach) AS total_revenue,
    ROUND(SUM(od.quantityOrdered * od.priceEach) / (SELECT SUM(od.quantityOrdered * od.priceEach) FROM orders o JOIN orderdetails od ON o.orderNumber = od.orderNumber) * 100,0) AS revenue_percentage
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerNumber, c.customerName
ORDER BY total_revenue DESC
LIMIT 10);

-- CA global 
CREATE VIEW ca_tot_vw AS
(SELECT SUM(od.quantityOrdered * od.priceEach) AS total_revenue
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber);
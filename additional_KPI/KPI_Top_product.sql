-- les 5 produits avec la plus grosse marge brut
CREATE VIEW top_product_cw AS
(SELECT p.productCode, p.productName, 
    SUM(od.quantityOrdered * (od.priceEach - pr.buyPrice)) AS gross_margin
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
JOIN productlines pl ON p.productLine = pl.productLine
JOIN (SELECT productCode, buyPrice FROM products) pr ON p.productCode = pr.productCode
WHERE o.status = 'Shipped'
GROUP BY p.productCode, p.productName
ORDER BY SUM(od.quantityOrdered) DESC
LIMIT 5);

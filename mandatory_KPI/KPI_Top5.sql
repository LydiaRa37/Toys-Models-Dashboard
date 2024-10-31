-- top 5 Produit toutes années confondues +  stock en cumulés

CREATE VIEW top_product_vw AS
(SELECT p.productCode, p.productName, p.productLine, p.quantityInStock, SUM(od.quantityOrdered) AS total_ventes
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName, p.productLine, p.quantityInStock
ORDER BY total_ventes DESC
LIMIT 5);
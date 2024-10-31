-- Evolution Ventes Gamme n vs n-1 
CREATE VIEW sales_productline_year_vw AS
(SELECT 
    p.productLine,
    MONTH(o.orderDate) AS month,
    SUM(CASE WHEN YEAR(o.orderDate) = 2022 THEN od.quantityOrdered ELSE 0 END) AS totalQuantityOrdered_2022,
    SUM(CASE WHEN YEAR(o.orderDate) = 2023 THEN od.quantityOrdered ELSE 0 END) AS totalQuantityOrdered_2023,
    SUM(CASE WHEN YEAR(o.orderDate) = 2024 THEN od.quantityOrdered ELSE 0 END) AS totalQuantityOrdered_2024,
    CASE 
        WHEN COALESCE(SUM(CASE WHEN YEAR(o.orderDate) = 2022 THEN od.quantityOrdered ELSE 0 END), 0) > 0 
        THEN ROUND(
            ((SUM(CASE WHEN YEAR(o.orderDate) = 2023 THEN od.quantityOrdered ELSE 0 END) - 
              SUM(CASE WHEN YEAR(o.orderDate) = 2022 THEN od.quantityOrdered ELSE 0 END)) / 
              SUM(CASE WHEN YEAR(o.orderDate) = 2022 THEN od.quantityOrdered ELSE 0 END)) * 100, 0)
        ELSE 0 
    END AS tauxEvolution_2023,
    CASE 
        WHEN COALESCE(SUM(CASE WHEN YEAR(o.orderDate) = 2023 THEN od.quantityOrdered ELSE 0 END), 0) > 0 
        THEN ROUND(
            ((SUM(CASE WHEN YEAR(o.orderDate) = 2024 THEN od.quantityOrdered ELSE 0 END) - 
              SUM(CASE WHEN YEAR(o.orderDate) = 2023 THEN od.quantityOrdered ELSE 0 END)) / 
              SUM(CASE WHEN YEAR(o.orderDate) = 2023 THEN od.quantityOrdered ELSE 0 END)) * 100, 0)
        ELSE 0 
    END AS tauxEvolution_2024
FROM 
    orderdetails od
JOIN 
    products p ON od.productCode = p.productCode
JOIN 
    orders o ON od.orderNumber = o.orderNumber
GROUP BY 
    p.productLine, MONTH(o.orderDate)
ORDER BY 
    p.productLine, month);
-- Unpaid customer
CREATE VIEW unpaid_customer_vw AS
(SELECT
    c.customerNumber,
    c.customerName,
    COALESCE(totalOrdersData.totalOrders, 0) AS totalOrders,
    COALESCE(totalOrdersData.totalOrderAmount, 0) AS totalOrderAmount,
    COALESCE(paymentsData.totalPaymentAmount, 0) AS totalPaymentAmount,
    COALESCE(totalOrdersData.totalOrderAmount, 0) - COALESCE(paymentsData.totalPaymentAmount, 0) AS etatDesPaiements,
    c.creditLimit,
    ROUND ((COALESCE(totalOrdersData.totalOrderAmount, 0) - COALESCE(paymentsData.totalPaymentAmount, 0)) / c.creditLimit * 100, 2) AS etatParRapportALimite
FROM
    customers c
LEFT JOIN (
    SELECT
        c.customerNumber,
        COUNT(o.orderNumber) AS totalOrders,
        SUM(od.quantityOrdered * od.priceEach) AS totalOrderAmount
    FROM
        customers c
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    GROUP BY
        c.customerNumber
) AS totalOrdersData ON c.customerNumber = totalOrdersData.customerNumber
LEFT JOIN (
    SELECT
        p.customerNumber,
        SUM(p.amount) AS totalPaymentAmount
    FROM
        payments p
    GROUP BY
        p.customerNumber
) AS paymentsData ON c.customerNumber = paymentsData.customerNumber
ORDER BY
    c.customerNumber);
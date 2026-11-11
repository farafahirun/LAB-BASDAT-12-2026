SET search_path to classicmodels, public;

-- soal 1
SELECT 
	c.contactfirstname,
	c.customername,
	o.city AS "Office City",
	CONCAT(e.firstname, ' ', e.lastname) AS sales_rep_name
FROM customers AS c
JOIN employees AS e 
ON c.salesrepemployeenumber = e.employeenumber
JOIN offices AS o
USING(officecode)
WHERE LOWER(c.contactfirstname) LIKE 'a%' AND o.city != 'NYC'
ORDER BY c.customername ASC;

-- soal 2
SELECT 
	c.customername,
	SUM(p.amount) AS total_payment,
	MAX(p.amount) AS max_single_payment
FROM customers AS c
JOIN payments AS p
ON c.customernumber = p.customernumber
GROUP BY c.customernumber, c.customername
HAVING SUM(p.amount) > 50000
ORDER BY total_payment DESC;

-- soal 3
SELECT 
	c.customername,
	COUNT(DISTINCT ord.ordernumber) AS total_order,
	ROUND(AVG(od.quantityordered), 2) AS avg_quantity_per_order
FROM customers AS c
JOIN orders AS ord
ON c.customernumber = ord.customernumber
JOIN orderdetails AS od
ON ord.ordernumber = od.ordernumber
GROUP BY c.customernumber, c.customername
HAVING COUNT(DISTINCT ord.ordernumber) > 3 AND AVG(od.quantityordered) > 35
ORDER BY total_order DESC, avg_quantity_per_order DESC;

-- soal 4
SELECT 
	p.productline,
	SUM(od.quantityOrdered) AS total_terjual,
    ROUND(AVG(od.priceEach), 2) AS rata_rata_harga,
    ROUND(AVG((p.MSRP - od.priceEach) / p.MSRP * 100), 2) AS avg_discount_percentage
FROM products AS p
JOIN orderdetails AS od 
ON p.productCode = od.productCode
GROUP BY p.productLine
HAVING SUM(od.quantityOrdered) > 3000 AND AVG(od.priceEach) > 80
ORDER BY total_terjual DESC;

-- soal 5
SELECT 
	c.customerName,
    SUM(od.quantityOrdered * od.priceEach) AS total_transaksi,
	COUNT(DISTINCT ord.orderNumber) FILTER (WHERE ord.status = 'Shipped') AS total_shipped_orders,
    ROUND(SUM(od.quantityOrdered * od.priceEach) 
    / COUNT(DISTINCT ord.orderNumber), 2) AS avg_transaction_per_order
FROM customers c
JOIN orders ord ON c.customerNumber = ord.customerNumber
JOIN orderdetails od ON ord.orderNumber = od.orderNumber
GROUP BY c.customerNumber, c.customerName
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM ord.orderDate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

-- soal 6
SELECT c.customerName, c.city AS customer_city, o.city AS office_city,
    SUM(od.quantityOrdered) AS total_unit_terjual,
    ROUND(SUM(od.quantityOrdered * od.priceEach) 
    / COUNT(DISTINCT ord.orderNumber), 2) AS avg_nilai_per_order
FROM customers AS c
JOIN employees AS e 
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices AS o 
ON e.officeCode = o.officeCode
JOIN orders AS ord 
ON c.customerNumber = ord.customerNumber
JOIN orderdetails AS od 
ON ord.orderNumber = od.orderNumber
WHERE o.territory = 'EMEA'
GROUP BY c.customerNumber, c.customerName, c.city, o.city
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM ord.orderdate)) > 2
   AND SUM(od.quantityOrdered) > 1000
   AND SUM(od.quantityOrdered * od.priceEach) 
   / COUNT(DISTINCT ord.orderNumber) > 10000
ORDER BY avg_nilai_per_order DESC;






-- study case

-- SOAL 1
SELECT
    c.customerName,
    o.orderNumber,
    p.productName,
    od.quantityOrdered,
    od.priceEach
FROM customers AS c
JOIN orders AS o 
USING (customerNumber)
JOIN orderdetails AS od 
USING (orderNumber)
JOIN products AS p 
USING (productCode)
WHERE p.productLine = 'Classic Cars'
  AND od.quantityOrdered > 30
  AND o.status = 'Shipped'
ORDER BY o.orderNumber;



-- SOAL 2
SELECT
    o.orderNumber,
    o.orderDate,
    p.productName,
    p.productLine,
    od.quantityOrdered,
    od.priceEach
FROM orders AS o
JOIN orderdetails AS od 
USING (orderNumber)
JOIN products AS p 
USING (productCode)
WHERE od.quantityOrdered >= 40
  AND p.productLine IN ('Motorcycles', 'Planes')
ORDER BY o.orderNumber;














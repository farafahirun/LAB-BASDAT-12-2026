SET search_path TO classicmodels, public;

-- PRAKTIKUM 5
-- RELASI
--one to one
SELECT 
	c.customerNumber,
	o.orderNumber,
	o.orderDate
FROM customers c
JOIN orders o
	ON c.customerNumber = o.customerNumber
ORDER BY customerNumber;

--one to many 
--many to many



-- OPERASI JOIN
--INNER JOIN (outpunya yg punya pasangan saja)
--inner join dengan alias
SELECT
	c.customerNumber,
	c.contactFirstName,
	p.amount
FROM customers c
INNER JOIN payments p
	ON c.customerNumber = p.customerNumber;

-- inner join dengan WHERE
SELECT
	c.customerNumber,
	c.contactFirstName,
	p.amount
FROM customers c
INNER JOIN payments p
	ON c.customerNumber = p.customerNumber
WHERE p.amount > 6000 AND p.amount > 15000;

--inner join dengan n-Tabel
SELECT
	c.customerNumber,
	c.contactFirstName,
	p.amount,
	o.orderDate
FROM customers c
INNER JOIN payments p
	ON c.customerNumber = p.customerNumber
INNER JOIN orders o
	ON c.customerNumber = o.customerNumber;


--LEFT JOIN
SELECT
	c.customerNumber,
	c.contactFirstName,
	o.orderNumber,
	od.quantityOrdered
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
LEFT JOIN orderdetails od ON c.customerNumber = od.orderNumber;


-- RIGHT JOIN
SELECT
	c.customerNumber,
	c.contactFirstName,
	o.orderNumber
FROM customers c
RIGHT JOIN orders o ON c.customerNumber = o.customerNumber;


-- FULL OUTER JOIN
SELECT
	c.customerNumber,
	c.contactFirstName,
	o.orderDate
FROM customers c
FULL OUTER JOIN orders o ON c.customerNumber = o.customerNumber;




-- STUDI CASE PRAKTIKUM
--no.1 (tak dapat)
SELECT
	c.customerNumber,
	c.customerName,
	c.country,
	o.orderNumber
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber;

--no.2 (tak dapat)
SELECT
	c.customerName,
	o.orderNumber,
	pd.productName,
	COUNT(p.productLine),
	pd.buyPrice,
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN products pd ON c.customerNumber = 
WHERE p.productLine = 'Classic Car' AND p.productLine IN ('Classic Cars') > 30 AND 

--no.3 (dpt)
SELECT
	c.customerNumber,
	c.customerName,
	o.orderNumber,
	o.status
FROM customers c
FULL OUTER JOIN orders o ON c.customerNumber = o.customerNumber;

--no.4 (tak dpt)
SELECT
	od.orderNumber,
	o.orderDate,
	pd.productName,
	pd.productLine,
	COUNT(orderNumber),
	pd.msrp
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products pd ON 

--no.5 (tak dpt)
SELECT
	c.customerName,
	od.orderNumber,
	pd.productLine,
	od.quantityOrdered,
FROM customers c
JOIN orderdetails od ON c.customerNumber = 




-- TUGAS PRAKTIKUM 5
--no.1
SELECT
	c.contactFirstName,
	c.customerName,
	ofc.city,
	CONCAT(e.firstName, ' ', e.lastName) AS sales_rep_name
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices ofc ON e.officeCode = ofc.officeCode
WHERE c.contactFirstName ILIKE('A%') AND ofc.city != 'NYC'
ORDER BY c.customerName ASC;

--no.2
SELECT
	c.customerName,
	SUM(p.amount) AS total_payment,
	MAX(p.amount) AS max_single_payment
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerName
HAVING SUM(p.amount) > 50000
ORDER BY total_payment DESC;

--no.3
SELECT
	c.customerName,
	COUNT(DISTINCT o.orderNumber) AS total_order,
	ROUND(AVG(od.quantityOrdered), 2) AS avg_quantity_per_order
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerName
HAVING COUNT(DISTINCT o.orderNumber) > 3 AND ROUND(AVG(od.quantityOrdered), 2) > 35
ORDER BY total_order, avg_quantity_per_order DESC;

--no.4
SELECT 
    p.productLine,
    SUM(od.quantityOrdered) AS total_terjual,
    ROUND(AVG(od.priceEach), 2) AS rata_rata_harga,
    ROUND(AVG((p.MSRP - od.priceEach) / p.MSRP * 100), 2) AS avg_discount_percentage
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productLine
HAVING SUM(od.quantityOrdered) > 3000 
   AND AVG(od.priceEach) > 80
ORDER BY total_terjual DESC;

--no.5
SELECT 
    c.customerName,
    SUM(od.quantityOrdered * od.priceEach) AS total_transaksi,
    COUNT(DISTINCT (o.orderNumber, o.status = 'Shipped')) AS total_shipped_orders,
    ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber), 2) AS avg_transaction_per_order
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerNumber, c.customerName
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderDate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

--no.6
SELECT
	c.customerName,
	c.city AS customer_city,
	ofc.city AS office_city,
	SUM(od.quantityOrdered) AS total_unit_terjual,
	ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber), 2) AS avg_nilai_per_order
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices ofc ON e.officeCode = ofc.officeCode
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
WHERE ofc.territory = 'EMEA'
GROUP BY c.customerName, c.city, ofc.city
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderDate)) > 2
		AND SUM(od.quantityOrdered) > 1000
		AND ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber), 2) > 10000
ORDER BY avg_nilai_per_order DESC;




-- STUDI CASE ASISTENSI
--no.1
SELECT
	c.customerName,
	o.orderNumber,
	pd.productName,
	od.quantityOrdered,
	od.priceEach
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products pd USING (productCode)
WHERE pd.productLine = 'Classic Cars'
		AND od.quantityOrdered > 30
		AND o.status = 'Shipped';
--no.2
SELECT
	o.orderNumber,
	o.orderDate,
	pd.productName,
	pd.productLine,
	od.quantityOrdered,
	od.priceEach
FROM orders o
JOIN orderdetails od USING (orderNumber)
JOIN products pd USING (productCode)
WHERE od.quantityOrdered >= 40
		AND pd.productLine IN ('Motorcycles', 'Planes');
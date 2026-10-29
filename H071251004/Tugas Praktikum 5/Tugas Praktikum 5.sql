SET search_path to classicmodels, public;

-- soal 1
SELECT c.contactfirstname, c.customername, o.city,
	CONCAT(e.firstname, ' ', e.lastname) AS sales_rep_name
FROM customers AS c
JOIN employees AS e 
ON c.salesrepemployeenumber = e.employeenumber
JOIN offices AS o
ON e.officecode = o.officecode
WHERE c.contactfirstname ILIKE 'A%' AND o.city <> 'NYC'
ORDER BY c.customername ASC;

-- soal 2
SELECT c.customername,
	SUM(p.amount) AS total_payment,
	MAX(p.amount) AS max_single_payment
FROM customers AS c
JOIN payments AS p
ON c.customernumber = p.customernumber
GROUP BY c.customernumber, c.customername
HAVING SUM(p.amount) > 50000
ORDER BY total_payment DESC;

-- soal 3
SELECT c.customername,
	COUNT(DISTINCT o.ordernumber) AS total_order,
	ROUND(AVG(od.quantityordered), 2) AS avg_quantity_per_order
FROM customers AS c
JOIN orders AS o
ON c.customernumber = o.customernumber
JOIN orderdetails AS od
ON o.ordernumber = od.ordernumber
GROUP BY c.customernumber, c.customername
HAVING COUNT(DISTINCT o.ordernumber) > 3 AND AVG(od.quantityordered) > 35
ORDER BY total_order DESC, avg_quantity_per_order DESC;

-- soal 4
SELECT p.productline,
	SUM(od.quantityordered) AS total_terjual,
    ROUND(AVG(od.priceeach), 2) AS rata_rata_harga,
    ROUND(AVG((p.msrp - od.priceeach) / p.msrp * 100), 2) AS avg_discount_percentage
FROM products AS p
JOIN orderdetails AS od 
ON p.productcode = od.productcode
GROUP BY p.productline
HAVING SUM(od.quantityordered) > 3000 AND AVG(od.priceeach) > 80
ORDER BY total_terjual DESC;

-- soal 5
SELECT c.customername,
    SUM(od.quantityordered * od.priceeach) AS total_transaksi,
	COUNT(DISTINCT (o.ordernumber, o.status = 'Shipped')) AS total_shipped_orders,
    ROUND(SUM(od.quantityordered * od.priceeach) 
    / COUNT(DISTINCT o.orderNumber), 2) AS avg_transaction_per_order
FROM customers AS c
JOIN orders AS o
ON c.customernumber = o.customernumber
JOIN orderdetails AS od 
ON o.ordernumber = od.ordernumber
GROUP BY c.customernumber, c.customername
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

-- soal 6
SELECT c.customerName, c.city AS customer_city, o.city AS office_city,
    SUM(od.quantityordered) AS total_unit_terjual,
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

-- Study Case 1
SELECT c.customername, ord.ordernumber, p.productname, 
	od.quantityordered, od.priceeach
FROM customers AS c
JOIN orders AS ord
USING(customernumber)
JOIN orderdetails AS od
USING(ordernumber)
JOIN products AS p
USING (productcode)
WHERE p.productline = 'Classic Cars' 
	AND od.quantityordered > 30 
	AND ord.status = 'Shipped';

-- Study Case 2
SELECT ord.ordernumber, ord.orderdate, 
	p.productname, p.productline, 
	od.quantityordered, od.priceeach
FROM orders AS ord
JOIN orderdetails AS od
USING(ordernumber)
JOIN products AS p
USING(productcode)
WHERE od.quantityordered >= 40 
	AND (p.productline = 'Motorcycles' OR p.productline = 'Planes');









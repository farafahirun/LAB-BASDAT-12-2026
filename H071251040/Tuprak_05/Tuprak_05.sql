SET search_path TO classicmodels, public;

-- no 1
SELECT
	c.contactfirstname,
	c.customername,
	o.city as office_city,
	CONCAT(e.firstname, ' ', e.lastname) as "sales_rep_name"
FROM customers as c
JOIN employees as e
ON c.salesrepemployeenumber = e.employeenumber
JOIN offices as o
USING (officecode)
WHERE 
	c.contactfirstname ILIKE 'a%'
	AND o.city != 'NYC'
ORDER BY  c.customername ASC;

-- no 2
SELECT
	c.customername,
	SUM(p.amount) as "total_payment",
	MAX(P.amount) as "max_single_payment"
FROM customers as c
JOIN payments as p
ON c.customernumber = p.customernumber
GROUP BY 
	c.customername,
	c.customernumber
HAVING 
	SUM(p.amount) > 50000
ORDER BY
	"total_payment" DESC;


-- no 3
SELECT 
	c.customername,
	COUNT(DISTINCT o.ordernumber) as "total_order",
	ROUND(AVG(od.quantityordered), 2) as "avg_quantity_per_order"
FROM customers as c
JOIN orders as o
ON c.customernumber = o.customernumber
JOIN orderdetails as od
ON o.ordernumber = od.ordernumber
GROUP BY 
	c.customername
HAVING
	COUNT(DISTINCT o.ordernumber) > 3
	AND AVG(od.quantityordered) > 35
ORDER BY
	"total_order" DESC,
	"avg_quantity_per_order" DESC;


-- no 4
SELECT 
	pl.productline,
	SUM(od.quantityordered) as "total_terjual",
	ROUND(AVG(od.priceeach), 2) as "rata_rata_harga",
	ROUND(AVG(((p.msrp - od.priceeach)/ p.msrp) * 100 ), 2) as "avg_discount_percentage"
FROM productlines as pl
JOIN  products as p 
ON pl.productline = p.productline
JOIN orderdetails as od
ON p.productcode = od.productcode
GROUP BY
	pl.productline
HAVING 
	SUM(od.quantityordered) > 3000
	AND AVG(od.priceeach) > 80
ORDER BY
	"total_terjual" DESC;


-- no 5
SELECT 
    c.customerName,
    SUM(od.quantityOrdered * od.priceEach) AS total_transaksi,
    COUNT(DISTINCT CASE WHEN o.status = 'Shipped' THEN o.orderNumber END) AS total_shipped_orders,
    ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber), 2) AS avg_transaction_per_order
FROM customers c
JOIN orders o 
ON c.customerNumber = o.customerNumber
JOIN orderdetails od 
ON o.orderNumber = od.orderNumber
GROUP BY 
    c.customerNumber, 
    c.customerName
HAVING 
    COUNT(DISTINCT EXTRACT(YEAR FROM o.orderDate)) > 1
ORDER BY 
    total_transaksi DESC
LIMIT 5;


-- no 6
SELECT 
    c.customerName,
    c.city AS customer_city,
    off.city AS office_city,
    SUM(od.quantityOrdered) AS total_unit_terjual,
    ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber), 2) AS avg_nilai_per_order
FROM customers c
JOIN employees e 
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices off 
ON e.officeCode = off.officeCode
JOIN orders o 
ON c.customerNumber = o.customerNumber
JOIN orderdetails od 
ON o.orderNumber = od.orderNumber
WHERE 
    off.territory = 'EMEA'
GROUP BY 
    c.customerNumber, 
    c.customerName, 
    c.city, 
    off.city
HAVING 
    COUNT(DISTINCT EXTRACT(YEAR FROM o.orderDate)) > 2
    AND SUM(od.quantityOrdered) > 1000
    AND SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber) > 10000
ORDER BY 
    avg_nilai_per_order DESC;


-- study CASE
SELECT
	c.customername,
	o.ordernumber,
	p.productline,
	p.productname,
	od.quantityordered
FROM customers as c
JOIN orders as o
	USING(customernumber)
JOIN orderdetails as od
	USING(ordernumber)
JOIN products as p
	USING(productcode)
WHERE
	o.status IN ('Shipped', 'Resolved')
	AND od.quantityordered BETWEEN 20 AND 50;
	
	

	

	




	
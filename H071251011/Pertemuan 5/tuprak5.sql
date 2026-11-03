SET search_path TO classicmodels, public;

-- no1
SELECT
	c.contactfirstname,
	c.customername,
	of.city,
	CONCAT(e.firstname, ' ', e.lastname) AS sales_rep_name
FROM customers AS c
JOIN employees AS e
	ON e.employeenumber = c.salesrepemployeenumber
JOIN offices AS of
	ON of.officecode = e.officecode
WHERE
	c.contactfirstname ILIKE 'A%' AND
	c.city != 'NYC'
ORDER BY c.customername;

-- no2
SELECT
	c.customername,
	SUM(p.amount) AS total_payment,
	MAX(p.amount) AS max_single_payment
FROM customers AS c
JOIN payments AS p
	ON c.customernumber = p.customernumber
GROUP BY c.customername
HAVING SUM(p.amount) > 50000
ORDER BY SUM(p.amount) DESC;

-- no3
SELECT
	c.customername,
	COUNT(DISTINCT o.ordernumber) AS total_order,
	ROUND(AVG(od.quantityordered), 2) AS avg_quantity_per_order
FROM customers AS c
JOIN orders AS o
	ON c.customernumber = o.customernumber
JOIN orderdetails AS od
	ON o.ordernumber = od.ordernumber
GROUP BY c.customername
HAVING
	COUNT(DISTINCT o.ordernumber) > 3 AND
	ROUND(AVG(od.quantityordered), 2) > 35
ORDER BY 
	total_order DESC, 
	avg_quantity_per_order DESC;

-- no4
SELECT 
	pr.productline,
	SUM(od.quantityordered) AS total_terjual,
	ROUND(AVG(od.priceeach), 2) AS rata_rata_harga,
	ROUND(AVG((pr.MSRP - od.priceeach) / pr.msrp * 100), 2) AS avg_discount_percentage
FROM products AS pr
JOIN orderdetails AS od
	ON pr.productcode = od.productcode
GROUP BY pr.productline
HAVING 
	SUM(od.quantityordered) > 3000 AND
	ROUND(AVG(od.priceeach), 2) > 80
ORDER BY total_terjual DESC;

-- 5
SELECT
    c.customername,
    SUM(od.quantityordered * od.priceeach) AS total_transaksi,
    COUNT(DISTINCT (o.ordernumber, o.status = 'Shipped')) AS total_shipped_orders,
    ROUND(SUM(od.quantityordered * od.priceeach)/ COUNT(DISTINCT o.ordernumber), 2) AS avg_transaction_per_order
FROM customers AS c
JOIN orders AS o
    ON c.customernumber = o.customernumber
JOIN orderdetails AS od
    ON o.ordernumber = od.ordernumber
GROUP BY c.customername
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

-- 6
SELECT
    c.customername,
    c.city AS customer_city,
    of.city AS office_city,
    SUM(od.quantityordered) AS total_unit_terjual,
    ROUND(SUM(od.quantityordered * od.priceeach)/ COUNT(DISTINCT o.ordernumber), 2) AS avg_nilai_per_order
FROM customers AS c
JOIN employees AS e
    ON c.salesrepemployeenumber = e.employeenumber
JOIN offices AS of
    ON e.officecode = of.officecode
JOIN orders AS o
    ON c.customernumber = o.customernumber
JOIN orderdetails AS od
    ON o.ordernumber = od.ordernumber
WHERE of.territory = 'EMEA'
GROUP BY
    c.customernumber,
    c.customername,
    c.city,
    of.city
HAVING
    COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 2 AND SUM(od.quantityordered) > 1000 AND SUM(od.quantityordered * od.priceeach)/ COUNT(DISTINCT o.ordernumber) > 10000
ORDER BY avg_nilai_per_order DESC;

-- sc
-- no1
SELECT 
	c.customername,
	o.ordernumber,
	p.productname, 
	od.quantityordered,
	od.priceeach
FROM customers AS c
JOIN orders AS o
	ON c.customernumber = o.customernumber
JOIN orderdetails AS od
	ON o.ordernumber = od.ordernumber
JOIN products AS p
	ON od.productcode = p.productcode
WHERE  p.productline = 'Classic Cars' AND od.quantityordered > 30 AND o.status = 'Shipped';

-- no2
SELECT 
	o.ordernumber,
	o.orderdate, 
	p.productname, 
	p.productline,
	od.quantityordered,
	od.priceeach
FROM orders AS o
JOIN orderdetails AS od
	ON o.ordernumber = od.ordernumber
JOIN products AS p
	ON od.productcode = p.productcode
WHERE od.quantityordered >= 40 AND (p.productline = 'Motorcycles' OR p.productline = 'Planes');
	
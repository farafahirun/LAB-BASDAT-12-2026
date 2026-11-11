SET search_path TO classicmodels, public;


-- SOAL 1
SELECT
	customerNumber,
	SUM(amount) AS total_setoran, 
	COUNT(DISTINCT checkNumber) AS frekuensi_setoran,
	MAX(amount) AS setoran_terbesar
FROM payments
GROUP BY customerNumber
HAVING COUNT(DISTINCT checkNumber) > 4
	AND AVG(amount) > 20000;


-- SOAL 2
SELECT
	customerNumber,
	SUM(amount) AS total_setoran
FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 80000
ORDER BY total_setoran DESC;


-- SOAL 3
SELECT
	productLine AS kategori,
	COUNT(DISTINCT productCode) AS jumlah_produk,
	ROUND (AVG(MSRP),2),
	STRING_AGG (productName, ' , ' ) AS daftar_produk
FROM products
GROUP BY productLine
HAVING COUNT(DISTINCT productCode) > 10;


-- SOAL 4
SELECT
	DISTINCT reportsTo AS employeeNumber
FROM employees
WHERE reportsTo IS NOT NULL

EXCEPT

SELECT employeeNumber
FROM employees
WHERE jobTitle LIKE '%VP%'
	OR jobTitle LIKE '%President%';


-- SOAL 5
SELECT
	productCode,
	SUM(quantityOrdered) AS total_unit_terjual,
	ROUND(AVG(priceEach),2) AS rata_rata_harga
FROM orderdetails
WHERE priceEach > 100
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50
ORDER BY SUM(quantityOrdered) DESC;


-- Soal 6
SELECT
	productCode,
	SUM(quantityOrdered) AS total_unit_dipesan,
	SUM(quantityOrdered * priceEach) AS pendapatan_kotor,
	ROUND(AVG(priceEach),2) AS rata_rata_harga,
	MAX(priceEach) - MIN(priceEach) AS rentang_harga	
FROM orderdetails
WHERE quantityOrdered > 20
GROUP BY productCode
HAVING SUM (quantityOrdered * priceEach) > 50000
ORDER BY pendapatan_kotor DESC;


-- SOAL 7
SELECT customerNumber
FROM customers
WHERE creditLimit > 80000

INTERSECT 

SELECT customerNumber
FROM orders
WHERE status IN ('Cancelled', 'On Hold')

EXCEPT 

SELECT customerNumber
FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 100000;




-- Study Case

-- SOAl 1
SELECT
    customerNumber,
    SUM(amount) AS total_pembayaran,
    AVG(amount) AS rata_rata_pembayaran,
    COUNT (*) AS jumlah_transaksi
FROM payments
GROUP BY customerNumber
HAVING AVG(amount) > 3000
ORDER BY total_pembayaran DESC;



-- SOAL 2
SELECT
	customerNumber,
	customerNAme,
	country,
	creditLimit
FROM customers
WHERE country = 'USA' AND creditLimit > 50000
UNION
SELECT 
	customerNumber,
	customerName,
	country,
	creditLimit
FROM customers
WHERE country = 'UK' AND creditLimit > 50000

ORDER BY creditlimit DESC;













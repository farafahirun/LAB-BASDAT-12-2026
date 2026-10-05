CREATE DATABASE tp2_no3hingga5;
SET search_path TO classicmodels,public;

-- no.3
SELECT
	customernumber AS "Nomor Pelanggan",
	customername AS "Nama Pelanggan",
	phone AS "Telepon",
	country AS "Negara"
FROM customers;

-- no.4 
SELECT 
	productcode, productname, buyprice 
FROM products
WHERE buyprice > 50 
ORDER BY buyprice DESC
LIMIT 7;

-- no.5 
SELECT DISTINCT country AS "Negara Pelanggan"
FROM customers 
ORDER BY country ASC
LIMIT 5 OFFSET 5;


-- STUDI CASE
SELECT DISTINCT status AS "Status Pesanan"
FROM orders
WHERE status != 'Cancelled'
ORDER BY status DESC
OFFSET 1 LIMIT 3;

SELECT 
	productname,
	buyprice,
	msrp,
	(msrp - buyprice) AS "selisih"
FROM products
WHERE msrp < buyprice * 1.5 
ORDER BY selisih ASC;

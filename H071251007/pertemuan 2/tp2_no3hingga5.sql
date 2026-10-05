CREATE DATABASE tp2_no3hingga5;
SET search_path TO classicmodels,public;

SELECT
	customernumber AS "Nomor Pelanggan",
	customername AS "Nama Pelanggan",
	phone AS "Telepon",
	country AS "Negara"
FROM customers;

SELECT 
	productcode, productname, buyprice 
FROM products
WHERE buyprice > 50 
ORDER BY buyprice DESC
LIMIT 7;

SELECT DISTINCT country AS "Negara Pelanggan"
FROM customers 
ORDER BY country ASC
LIMIT 5 OFFSET 5;

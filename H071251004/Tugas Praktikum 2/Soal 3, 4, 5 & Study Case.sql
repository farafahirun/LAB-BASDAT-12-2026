-- Soal 3
SELECT customernumber AS "Nomor Pelanggan",
       customername   AS "Nama Pelanggan",
       phone          AS "Telepon",
       country        AS "Negara"
FROM customers;

-- Soal 4
SELECT productcode, productname, buyprice
FROM products
WHERE buyprice > 50
ORDER BY buyprice DESC
LIMIT 7;

--Soal 5
SELECT DISTINCT country AS "Negara Pelanggan"
FROM customers
ORDER BY country ASC
LIMIT 5 OFFSET 5;

SET search_path TO "classicmodels", public;

-- Study Case 1
SELECT DISTINCT status AS "Status Pesanan" FROM orders
WHERE status != 'Cancelled'
ORDER BY status DESC
LIMIT 3 OFFSET 1;

-- Study Case 2
SELECT productname, buyprice, msrp, 
	(msrp - buyprice) AS selisih 
FROM products
WHERE msrp <= buyprice * 1.5
ORDER BY selisih ASC
LIMIT 10;


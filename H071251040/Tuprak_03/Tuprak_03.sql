-- Tuprak

SET search_path TO classicmodels, public;

-- No 1
SELECT ordernumber, UPPER (productcode) AS "Kode Produk", quantityordered, priceEach FROM orderdetails
WHERE (quantityOrdered BETWEEN 20 AND 50 OR priceEach < 30)
AND productCode ILIKE 'S18%'
ORDER BY quantityOrdered DESC;

-- No 2
SELECT customerNumber, customerName, country, CONCAT (contactFirstName, ' ', contactLastName) AS "Nama Kontak", 
creditLimit, creditLimit - 10000 AS "Selisih Kredit"
FROM customers
WHERE country IN ('USA', 'Canada', 'France')
AND creditLimit > 30000
ORDER BY creditLimit DESC;

-- NO 3
SELECT productCode, productName, buyPrice, MSRP, GREATEST(buyPrice, MSRP) AS "Harga Tertinggi", LEAST(buyPrice, MSRP) AS "Harga Terendah"
FROM products
WHERE productName ILIKE '%car%';

-- NO 4
SELECT orderNumber, orderDate, shippedDate, EXTRACT (YEARS FROM orderDate) AS "Tahun", 
EXTRACT(MONTHS FROM orderDate) AS "Bulan", 
AGE (shippedDate, orderDate) AS "Lama Pengiriman", AGE (shippedDate,orderDate) AS "Interval Pengiriman", 
CURRENT_DATE AS "Tanggal Laporan", CURRENT_TIME AS "Waktu Laporan"
FROM orders
WHERE shippedDate IS NOT NULL;

-- NO 5
SELECT orderNumber, orderDate, shippedDate, orderDate + INTERVAL '10 days' AS "Estimasi Kirim", 
COALESCE(shippedDate, orderDate + INTERVAL '10 days' ) AS "Tanggal Aktual", AGE (shippedDate, orderDate) AS "Selisih Waktu"
FROM orders
WHERE comments ILIKE('%customer%')
AND  EXTRACT (MONTHS FROM orderDate) BETWEEN 10 AND  12 
AND orderNumber % 2 = 1
ORDER BY orderDate DESC;



-- Study CASE

SELECT 
	orderdate, 
	shippedDate, 
	orderDate + INTERVAL '10 days' AS "Estimasi Kirim", 
	AGE(shippedDate, orderDate ) AS "Lama Pengiriman", 
	AGE(shippedDate, orderDate ) AS "Durasi Pengiriman"
FROM orders
WHERE 
	shippedDate IS NOT NULL
	AND status = 'Shipped'
	AND EXTRACT (MONTHS FROM orderDate) = 1 OR  EXTRACT (MONTHS FROM orderDate) = 9
ORDER BY orderdate DESC;
	


	

SET search_path TO classicmodels, public;

-- no1
SELECT ordernumber, UPPER (productcode) AS "kode produk", quantityordered, priceeach FROM orderdetails
WHERE (quantityordered BETWEEN 20 AND 50 OR priceeach < 30) AND LEFT (productcode, 3) = 'S18' 
ORDER BY quantityordered DESC;

-- no2
SELECT customernumber, customername, country, CONCAT(contactfirstname, ' ', contactlastname) AS "Nama Kontak", creditlimit, (creditlimit - 10000) AS "Selisih Kredit" FROM customers
WHERE (country = 'USA' OR country = 'Canada' OR country = 'France') AND creditlimit > 30000
ORDER BY creditlimit DESC;

-- no3
SELECT productcode, productname, buyprice, msrp, GREATEST(buyprice, msrp) AS "Harga Tertinggi", LEAST(buyprice, msrp) AS "Harga Terendah" FROM products
WHERE productname ILIKE '%car%';

-- no4
SELECT ordernumber, orderdate, shippeddate, EXTRACT (YEAR FROM orderdate) AS "Tahun", EXTRACT (MONTH FROM orderdate) AS "Bulan", AGE(shippeddate, orderdate) AS "Lama Pengiriman", AGE(shippeddate, orderdate) AS "Interval Pengiriman", CURRENT_DATE AS "Tanggal Laporan", CURRENT_TIME AS "Waktu Laporan" FROM orders
WHERE shippeddate IS NOT NULL;

-- no5
SELECT ordernumber, orderdate, shippeddate, orderdate + INTERVAL '10 days' AS "Estimasi Kirim", COALESCE(shippeddate, orderdate) AS "Tanggal Aktual", AGE(shippeddate, orderdate) AS "Selisih Waktu" FROM orders
WHERE comments ILIKE '%customer%' AND ((EXTRACT (MONTH FROM orderdate)) BETWEEN 10 AND 12) AND ordernumber %2=1 
ORDER BY orderdate DESC;

SET search_path TO classicmodels;

-- Soal 1
SELECT ordernumber, UPPER(productcode) AS "Kode Produk", quantityordered, priceeach FROM orderdetails
WHERE (quantityordered BETWEEN 20 AND 50 OR priceeach < 30) AND LEFT(productcode, 3) = 'S18'
ORDER BY quantityordered DESC;


-- Soal 2
SELECT customernumber, customername, country, creditlimit, CONCAT(contactfirstname, ' ', contactlastname) AS "Nama Kontak", creditlimit - 10000 AS "Selisih Kredit"
FROM customers
WHERE country IN ('USA', 'Canada', 'France') AND creditlimit > 30000
ORDER BY creditlimit DESC;	


-- Soal 3
SELECT productcode, productname, buyprice, msrp, GREATEST(buyprice, msrp) AS "Harga Tertinggi", LEAST(buyprice, msrp) AS "Harga Terendah" 
FROM products
WHERE LOWER(productname) LIKE '%car%';

-- Soal 4
SELECT ordernumber, orderdate, shippeddate, EXTRACT(YEAR FROM orderdate) AS "Tahun",
EXTRACT(MONTH FROM orderdate) AS "Bulan", shippeddate - orderdate AS "Jumlah Hari", shippeddate - orderdate AS "Interval",
CURRENT_DATE AS "Tanggal Laporan", CURRENT_TIME AS "Waktu Laporan" FROM orders
WHERE shippeddate IS NOT NULL;

-- Soal 5
SELECT ordernumber, orderdate, shippeddate, orderdate + INTERVAL '10 days' AS "Estimasi Kirim",
COALESCE(shippeddate, orderdate + INTERVAL '10 days') AS "Tanggal Aktual",
COALESCE( shippeddate, orderdate + INTERVAL '10 days') - orderdate AS "Selisih Waktu" FROM orders	
WHERE LOWER(comments) LIKE '%customer%' AND EXTRACT(MONTH FROM orderdate) BETWEEN 10 AND 12 AND MOD(ordernumber, 2) = 1
ORDER BY orderdate DESC;


-- Study Case
SELECT ordernumber, orderdate, shippeddate,
orderdate + INTERVAL '10 days' AS "Estimasi Kirim ", shippeddate - orderdate AS "Lama Pengiriman",
AGE(shippeddate, orderdate) AS "Durasi Pengiriman" FROM orders
WHERE shippeddate is not null and  status = 'Shipped' and EXTRACT(MONTH FROM orderdate) in(1, 9)
ORDER BY (shippeddate - orderdate) DESC;


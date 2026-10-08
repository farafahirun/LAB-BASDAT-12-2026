-- nomor 1
SELECT 
    orderNumber, 
    UPPER(productCode) AS "Kode Produk", 
    quantityOrdered, 
    priceEach
FROM orderdetails
WHERE (quantityOrdered BETWEEN 20 AND 50 OR priceEach < 30)
AND LEFT(productCode, 3) = 'S18'
ORDER BY quantityOrdered DESC;

-- nomor 2
SELECT 
    customerNumber, 
    customerName, 
    country,
    CONCAT(contactFirstName, ' ', contactLastName) AS "Nama Kontak",
    creditLimit,
    (creditLimit - 10000) AS "Selisih Kredit"
FROM customers
WHERE (country = 'USA' OR country = 'Canada' OR country = 'France')
AND creditLimit > 30000
ORDER BY creditLimit DESC;

-- nomor 3
SELECT 
    productCode, 
    productName, 
    buyPrice, 
    MSRP,
    GREATEST(buyPrice, MSRP) AS "Harga Tertinggi",
    LEAST(buyPrice, MSRP) AS "Harga Terendah"
FROM products
WHERE productName ILIKE '%car%';

-- nomor 4
SELECT 
    orderNumber, 
    orderDate, 
    shippedDate,
    EXTRACT(YEAR FROM orderDate) AS "Tahun",
    EXTRACT(MONTH FROM orderDate) AS "Bulan",
    (shippedDate - orderDate) AS "Lama Pengiriman",
    AGE(shippedDate, orderDate) AS "Interval Pengiriman",
    CURRENT_DATE AS "Tanggal Laporan",
    CURRENT_TIME AS "Waktu Laporan"
FROM orders
WHERE shippedDate IS NOT NULL;

-- nomor 5
SELECT 
    orderNumber, 
    orderDate, 
    shippedDate,
    (orderDate + INTERVAL '10 days') AS "Estimasi Kirim",
    COALESCE(shippedDate, orderDate + INTERVAL '10 days') AS "Tanggal Aktual",
    AGE(shippedDate, orderDate) AS "Selisih Waktu"
FROM orders
WHERE comments ILIKE '%customer%'
AND EXTRACT(MONTH FROM orderDate) BETWEEN 10 AND 12
AND orderNumber % 2 = 1
ORDER BY orderDate DESC;

-- studycase
SELECT
	orderNumber,
	orderDate,
	shippedDate,
	(orderDate + INTERVAL '10 days') AS "estimasi pengiriman",
	(shippedDate - orderDate) AS "jumlah hari",
	AGE(shippedDate, orderDate) AS "lama proses pengiriman"
FROM orders
WHERE shippedDate IS NOT NULL
AND status = 'Shipped'
AND EXTRACT(MONTH FROM orderDate) IN (1, 9)
ORDER BY "jumlah hari" DESC;






















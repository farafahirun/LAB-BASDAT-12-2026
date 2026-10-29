SET search_path TO classicmodels;

-- SUBQUERY
-- di select (menampilkan nilai tambahan)
--contoh soal:
--total pesanan yg dilakukan setiap pelanggan
SELECT
    customerNumber,
    customerName,
    (SELECT COUNT(*)
        FROM orders
        WHERE customers.customerNumber = orders.customerNumber) AS jumlah_pesanan
FROM customers;

--menampilkan pelanggan yg kredit limit > rata2 semua pelanggan
SELECT
	customerName,
	creditLimit
FROM customers
WHERE creditLimit > (SELECT AVG(creditLimit) FROM customers);


-- di where (menentukan nilai yg akan dikelola)


-- di from (membuat tabel sementara yg akan dikelola oleh outer query)
--contoh soal:
--mengambil data total produk yg terjual, tapi kelompokkan terlebih dahulu
SELECT
	productCode,
	jumlah_terjual
FROM (
	SELECT
		productCode,
		SUM(quantityOrdered) AS jumlah_terjual
	FROM orderdetails
	GROUP BY productCode
	) AS penjualan_produk;
WHERE jumlah_terjual > 1000
ORDER BY jumlah_terjual DESC
LIMIT 5;

-- ‼️subquery nya harus outputnya harus 1 baris untuk perbandingan





-- OPERATOR KUANTIFIKASI
-- IN / NOT IN (‼️semisal ada nilai NULL maka NOT IN akan tidak mengembalikan apa2 sehingga lebib disarankan memakai NOT EXISTS)
-- EXIST / NOT EXIST
-- ANY / SOME
--contoh soal:
--mencari produk yg memiliki harga lebih tinggi dari setidanya satu produk yg ada dikategori 'TRUCKS and Buses'
SELECT 
	productName,
	buyPrice
FROM products
WHERE buyPrice > ALL (
	SELECT buyPrice 
	FROM products 
	WHERE productLine = 'Trucks and Buses'
	ORDER BY buyPrice
)
ORDER BY buyPrice DESC
-- ALL




-- CORRELATED SUBQUERY
--contoh soal:
--menampilkan nama pelanggan yg belum pernah melakukan melakukan transaksi atau pembayaran
SELECT
	customerNumber 
FROM customers 
WHERE NOT EXISTS (
	SELECT 1
	FROM payments
	WHERE payments.customerNumber = customers.customerNumber
)




-- CONDITIONAL LOGIC / CONTROL FLOW
--contoh soal:
--kelompokkan status kredit limit menjadi 4 kategori dari miskin - tinggi
SELECT
	customerName,
	creditLimit,
	CASE
		WHEN creditLimit > 100000 THEN 'Tinggi'
		WHEN creditLimit > 70000 THEN 'Sedang'
		WHEN creditLimit > 50000 THEN 'Rendah'
		ELSE 'MISKIN CIH'
	END AS kredit_limit_orang
FROM customers




-- KONSEP TRANSAKSI
-- BEGIN -> titik awal
-- COMMIT -> menyetorkan perubahan
-- ROLLBACK -> undo atau ctrl z nya database
-- SAVEPOINT -> kek checkpoint




-- INDEXING 
--contoh soal:
-- percepat pencaharian dari data pelanggan berdasarkan negaranya
CREATE INDEX index_customers_country ON customers(country);
SELECT
	customerName
FROM customers
WHERE country = 'USA';




-- STUDI CASE PRAKTIKUM
--no.1 (tak dpt)
SELECT
	customerNumber,
	customerName,
	creditLimit
FROM (
	SELECT
		customerNumber,
		customerName,
		AVG(creditLimit) AS rata2_kredit
	FROM customers
	GROUP BY customerNumber, customerName
)

--no.2 (tak dpt)
SELECT 
	customerNumber, 
	customerName,
	(
		
	)

--no.3 (tak dpt)
SELECT 
	productNumber,
	productName,
	msrp
FROM products
WHERE buyPrice > ALL (
	SELECT buyPrice 
	FROM products 
	WHERE productLine = 'Trucks and Buses'
	ORDER BY buyPrice
)
ORDER BY buyPrice DESC




-- TUGAS PRAKTIKUM 6
--no.1
SELECT
	productCode,
	productName,
	msrp,
	quantityInStock,
	productLine,
	CASE
		WHEN msrp < 50 AND quantityInStock > 500 THEN 'Ekonomis - Stok Tertinggi'
		WHEN msrp < 50 AND quantityInStock <= 500 THEN 'Ekonomis - Stok Rendah'
		WHEN msrp BETWEEN 50 AND 100 THEN 'Harga Menengah'
		WHEN msrp > 100 THEN 'Harga Premium'
	END AS karakteristik_produk
FROM products
ORDER BY msrp DESC;

--no.2
SELECT
	productCode,
	SUM(quantityOrdered) AS total_unit_terjual,
	COUNT(DISTINCT orderNumber) AS jumlah_pesanan
FROM orderdetails
GROUP BY productCode
HAVING 
	SUM(quantityOrdered) > (
		SELECT AVG(quantityOrdered) 
		FROM orderdetails
	)
	AND COUNT(DISTINCT orderNumber) > 10
ORDER BY total_unit_terjual DESC;

--no.3
SELECT
	productCode,
	productName,
	quantityInStock,
	msrp
FROM products
WHERE 
	quantityInStock > (
	SELECT AVG(quantityInStock)
	FROM products
	) 
	AND msrp > (
	SELECT AVG(msrp)
	FROM products
	)
ORDER BY quantityInStock DESC;

--no.4
SELECT orderNumber, status
FROM orders
WHERE orderNumber = '10100';
BEGIN;
UPDATE orders
SET status = 'Pengiriman'
WHERE orderNumber = '10100'; -- Perubahan status 1
SAVEPOINT status_pengiriman; -- Savepoint
UPDATE orders
SET status = 'Batal'
WHERE orderNumber = '10100'; -- Perubahan status 2
ROLLBACK TO SAVEPOINT status_pengiriman; -- status 2 dibatalkan
COMMIT; -- Simpan perubahan

--no.5 ada di database/file lain

-- STUDI CASE ASISTENSI (kak ago/ananta)
SELECT
	c.customerNumber,
	c.customerName,
	c.city,
	(
	SELECT COUNT(o.orderNumber)
	FROM orders o
	WHERE o.customerNumber = c.customerNumber
	) AS total_pesanan,
	CASE
		WHEN (
			SELECT COUNT(o.orderNumber)
			FROM orders o
			WHERE o.customerNumber = c.customerNumber
			) > 5 THEN 'Pelanggan Loyal'
		WHEN (
			SELECT COUNT(o.orderNumber)
			FROM orders o
			WHERE o.customerNumber = c.customerNumber
			) BETWEEN 2 AND 5 THEN 'Pelanggan Aktif'
		WHEN (
			SELECT COUNT(o.orderNumber)
			FROM orders o
			WHERE o.customerNumber = c.customerNumber
			) = 1 THEN 'Pelanggan Baru'
		ELSE 'Pelanggan Pasif'
	END AS status_loyalitas
FROM customers c
ORDER BY total_pesanan DESC, c.customerName ASC;
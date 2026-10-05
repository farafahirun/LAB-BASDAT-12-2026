SET search_path TO classicmodels,public;

-- PRAKTIKUM 3
-- A. OPERASI ARITMATIKA
--penjumlahan
SELECT 10 + 5 AS hasil_penjumlahan;
SELECT quantityordered AS destimasi_stok_baru FROM orderdetails;
--pengurangan
SELECT 10 - 5 AS hasil_pengurangan;
SELECT msrp - buyprice AS profit_kotor FROM products;
--perkalian
SELECT 
	quantityordered, 
	priceEach, 
	quantityordered * priceEach 
AS total FROM orderdetails;
--pembagian
SELECT buyprice / 2 
AS harga_diskon_50persen
FROM products;
--modulo (sisa bagi)
SELECT quantityinstock % 12 AS sisa_stok_lusin FROM products;
--prioritas operator
SELECT 2 + 3 * 4 AS hasil;
SELECT (2 + 3) * 4 AS hasil;
SELECT (msrp * buyprice) + quantityinstock 
AS potensi_pendapatan FROM products;

-- B. OPERATOR LOGIKA
--AND
SELECT * FROM orderdetails
WHERE quantityordered > 20 AND priceEach > 50;
--OR
SELECT * FROM orderdetails
WHERE quantityordered > 20 OR priceEach > 50;
--NOT
SELECT * FROM orderdetails
WHERE NOT quantityordered = 50;
--BETWEEN
SELECT * FROM orderdetails
WHERE quantityordered BETWEEN 20 AND 50;

-- C. PREDICATE
--IS NULL
SELECT * FROM orders WHERE comments IS NULL;
--IS NOT NULL
SELECT * FROM orders WHERE shippeddate IS NOT NULL;

-- D. OPERATOR BITWISE
-- AND (&)
SELECT 2 & 3 AS hasil_bitwise_and; --output 2
--OR (|)
SELECT 2 | 3 AS hasil_bitwise_or; --output 3
--XOR (#)
SELECT 2 # 3 AS hasil_bitwise_xor; --output 1

-- E. OPERATOR LIKE
SELECT * FROM customers WHERE customerName LIKE 'A%';
SELECT * FROM customers WHERE customerName LIKE '%US%';
SELECT * FROM customers WHERE customerName LIKE '_N%';

-- F. OPERATOR ILIKE (tidak peduli besar/kecil huruf)

-- G. COMPARATION FUNCTION
--COALESCE(mengganti data yg bernilai NULL jadi NON-NULL)
SELECT COALESCE (state, country) AS daerah FROM offices;
SELECT COALESCE (state, 'kosong') AS daerah FROM offices; --kosong sebagai alt bila semua data bernilai NULL
--GREATEST (bandingkan nilai kolom tiap baris dan tampilkan nilai tertinggi)
SELECT GREATEST (23, 40, 45, 98, 101) AS nilai_tertinggi;
--LEAST (bandingkan nilai kolom tiap baris dan tampilkan nilai terendah)
SELECT LEAST (23, 40, 45, 98, 101) AS nilai_terendah;

-- H.STRING FUNCTION
--UPPER (teks jdi kapital) & LOWER (teks jdi kecil semua)
SELECT UPPER(customerName) AS nama FROM customers;
--LEFT (ambil teks sebelah kiri) & RIGHT (ambil teks sebelah kanan)
SELECT LEFT (customerName, 3) AS nama_kiri FROM customers;
SELECT RIGHT (customerName, 3) AS nama_kanan FROM customers;
--CONCAT (gabung nilai jadi satu dan jdi string)
SELECT CONCAT (FirstName, ' ', LastName) AS nama_lengkap FROM employees;
--SUBSTRING (ambil sebagian karakter dari string)
SELECT SUBSTRING (FirstName, 1, 4) AS bagian FROM employees;
--penggabungan string (||)
SELECT FirstName || ' ' || LastName AS nama_lengkap FROM employees;

-- I. DATE FUNCTION
--NOW
SELECT NOW();
--CURRENT_DATE
SELECT orderDate + INTERVAL '10 days' AS tanggal_baru FROM orders;
--CURRENT_TIME
SELECT CURRENT_TIME;
SELECT


-- STUDI CASE LAB (GK BERHASIL)
SELECT UPPER *
AS "Nama Pelanggan Dalam Kapital" 
FROM customers;
WHERE customerName ILIKE 'Gifts%'

SELECT GREATEST (productcode, buyprice, msrp)
FROM products
WHERE products LIKE 'S18%';


-- TUGAS PRAKTIKUM 3
--No.1
SELECT 
	ordernumber,
	UPPER (productcode) AS "Kode Produk",
	quantityordered,
	priceeach
FROM orderdetails
WHERE 
	(quantityordered BETWEEN 20 AND 50 OR priceeach < 30) 
	AND LEFT (productcode, 3) = 'S18'
	ORDER BY quantityordered DESC;

--No.2
SELECT
	customernumber,
	customername,
	country,
	creditlimit,
	CONCAT(contactFirstName, ' ', contactLastName) AS "Nama Kontak",
	(creditlimit - 10000) AS "Selisih Kredit"
FROM customers
WHERE country IN ('USA', 'Canada', 'France') 
	AND creditlimit > 30000
	ORDER BY creditlimit DESC;

--No.3
SELECT 
	productcode,
	productname,
	buyprice,
	msrp,
	GREATEST(buyprice, msrp) AS "Harga Tertinggi",
	LEAST(buyprice, msrp) AS "Harga Terendah"
FROM products
WHERE
	productname ILIKE '%car%';

--No.4
SELECT 
	ordernumber,
	orderdate,
	shippeddate,
	EXTRACT(YEAR FROM orderdate) AS "Tahun",
	EXTRACT(MONTH FROM orderdate) AS "Bulan",
	shippeddate - orderdate AS "Lama Pengiriman",
	AGE (shippeddate, orderdate) AS "Interval Pengiriman",
	CURRENT_DATE AS "Tanggal Laporan",
	CURRENT_TIME AS "Waktu laporan"
FROM orders
WHERE shippeddate IS NOT NULL;

--No.5
SELECT
	ordernumber,
	orderdate,
	shippeddate,
	(orderdate + INTERVAL '10 days') AS "Estimasi Kirim",
	COALESCE(shippeddate, orderdate + INTERVAL '10 days') AS "Tanggal Aktual",
	COALESCE(shippeddate, orderdate + INTERVAL '10 days') - orderdate AS "Selisih Waktu"
FROM orders
WHERE 
	comments ILIKE '%customer%' AND
	EXTRACT(MONTH FROM orderdate) BETWEEN 10 AND 12
	AND ordernumber % 2 = 1
	ORDER BY orderdate DESC;


-- STUDICASE ASISTENSI
SELECT 
	productcode,
	productname,
	buyprice,
	msrp,
	GREATEST(buyprice, msrp) AS "Harga Tertinggi",
	LEAST(buyprice, msrp) AS "Harga Terendah",
	COALESCE(buyprice, msrp) AS "Harga Dasar"
FROM products
WHERE 
	GREATEST(buyprice, msrp) > 100
	ORDER BY GREATEST(buyprice, msrp) DESC;



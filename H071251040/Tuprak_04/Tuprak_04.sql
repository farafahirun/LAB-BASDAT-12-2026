SET search_path TO classicmodels, public;

-- no 1
SELECT 
	customerNumber as "ID Pelanggan",
	SUM(amount) as "Akumulasi Dana Rill",
	COUNT(DISTINCT paymentDate) as "Frekuensi Transaksi",
	MAX(amount) as "Setoran Terbesar"
FROM payments
GROUP BY customerNumber
HAVING
	COUNT(paymentDate) > 4
	AND AVG(amount) > 20000;

-- no 2

SELECT
	customerNumber as "ID Pelanggan",
	SUM(amount) as "Total Setoran"
FROM payments
GROUP BY customernumber
HAVING
	SUM(amount) > 80000
ORDER BY
	"Total Setoran" DESC;

-- no 3
SELECT
	productline as "Kategori Produk",
	COUNT(productcode) as "Jumlah Produk",
	ROUND(AVG(MSRP), 2) as "Rata-rata Harga Rek",
	STRING_AGG(productname, ',' ORDER BY productname) as "Daftar Nama Produk"
FROM products
GROUP BY productline
HAVING
	COUNT(productcode) >10;

-- no 4
SELECT 
	DISTINCT reportsto as " ID Staf Internal"
FROM employees
WHERE
	reportsto IS NOT NULL
EXCEPT
SELECT
	DISTINCT employeenumber
FROM employees
WHERE 
	jobtitle ILIKE '%VP%' 
	OR jobtitle ILIKE '%President%';



-- no 5
SELECT
	productcode as "ID produk",
	SUM(quantityordered) as "Total Produk Terjual",
	ROUND(AVG(priceeach), 2) as "Rata-rata Harga Penjualan"
FROM orderdetails
WHERE
	priceeach > 100
GROUP BY productcode
HAVING 
	SUM(quantityordered) > 50
ORDER BY 
	"Total Produk Terjual" DESC;

-- no 6
SELECT 
    productCode AS "ID Barang",
    SUM(quantityOrdered) AS "Total Barang Terjual",
    SUM(quantityOrdered * priceEach) AS "Estimasi Pendapatan Kotor",
    ROUND(AVG(priceEach), 2) AS "Rata-rata Harga Satuan",
    MAX(priceEach) - MIN(priceEach) AS "Selisih Harga"
FROM 
    orderdetails
WHERE 
    quantityOrdered > 20
GROUP BY 
    productCode
HAVING
	SUM(quantityOrdered * priceEach) > 50000
ORDER BY 
	"Estimasi Pendapatan Kotor" DESC;


-- NO 7
SELECT 
	customernumber
FROM customers
WHERE
	creditLimit > 80000

INTERSECT

SELECT
	customernumber
FROM orders
WHERE
	status IN ('Cancelled', 'On Hold')

EXCEPT

SELECT
	customernumber
FROM 
	payments
GROUP BY 
	customernumber
HAVING
	SUM(amount) > 100000;

-- Study CASE
-- no 1
SELECT
	customernumber,
	SUM(amount) as "Total_pembayaran",
	COUNT(paymentdate) as "jumlah_transasksi"
FROM payments
GROUP BY 
	customernumber
HAVING
	AVG(amount) > 3000
ORDER BY
	"Total_pembayaran" DESC;

-- NO 2

SELECT 
	customernumber,
	customername,
	country,
	creditlimit
FROM customers
WHERE
	creditlimit > 50000
	AND country IN ('UK')
UNION
SELECT 
	customernumber,
	customername,
	country,
	creditlimit
FROM customers
WHERE
	creditlimit > 50000
	AND country IN ('USA')
ORDER BY 
	creditlimit DESC;



	

	
	
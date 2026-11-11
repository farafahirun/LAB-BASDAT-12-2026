SET search_path TO classicmodels, public;

-- no1
SELECT 
	productcode,
	productname,
	msrp,
	quantityinstock,
	CASE 
		WHEN msrp < 50 AND quantityinstock > 500 THEN 'Ekonomis-Stok Tinggi'
		WHEN msrp < 50 AND quantityinstock <= 500 THEN 'Ekonomis-Stok Rendah'
		WHEN msrp BETWEEN 50 AND 100 THEN 'Harga Menengah'
		WHEN msrp > 100 THEN 'Harga Premium'
	END AS karakteristik_produk
FROM products
ORDER BY msrp DESC;

-- no2
SELECT 
	productcode AS kode_produk,
	SUM(quantityordered) AS total_unit_terjual,
	COUNT(DISTINCT ordernumber) AS jumlah_pesanan
FROM orderdetails
GROUP BY productcode
HAVING SUM(quantityordered) > (
	SELECT AVG(quantityordered)
	FROM orderdetails
	) AND 
	COUNT (DISTINCT ordernumber) > 10
ORDER BY total_unit_terjual DESC;

-- no3
SELECT
	productcode AS kode_produk,
	productname AS nama_produk,
	quantityinstock AS jumlah_stok,
	msrp
FROM products
WHERE quantityinstock > (
	SELECT AVG(quantityinstock)
	FROM products
	) AND
	msrp > (
	SELECT AVG(msrp)
	FROM products
	)
ORDER BY jumlah_stok DESC;

-- no4
SELECT ordernumber, status
FROM orders
WHERE ordernumber = 10100;

BEGIN;

UPDATE orders
SET status = 'Pengiriman'
WHERE ordernumber = 10100;

SAVEPOINT status_pengiriman;

UPDATE orders
SET status = 'Batal'
WHERE ordernumber = 10100;

ROLLBACK TO SAVEPOINT status_pengiriman;

COMMIT;

SELECT ordernumber, status
FROM orders
WHERE ordernumber = 10100;

-- no5 beda file sebab buat file baru


-- Study Case 1
select productcode, productname, productline, buyprice from products
where productline = 'Classic Cars'
and buyprice > ALL (
select buyprice from products
where productline = 'Vintage Cars'
)
order by buyprice desc;









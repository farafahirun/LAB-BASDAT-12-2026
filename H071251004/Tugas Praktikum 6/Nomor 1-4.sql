SET search_path to classicmodels, public;

-- Soal 1
SELECT productcode, productname, msrp, quantityinstock,
CASE
	WHEN msrp < 50 AND quantityinstock > 500 THEN 'Ekonomis - Stok Tinggi'
	WHEN msrp < 50 AND quantityinstock <= 500 THEN 'Ekonomis - Stok Rendah'
	WHEN msrp BETWEEN 50 AND 100 THEN 'Harga Menengah'
	ELSE 'Harga Premium'
END AS kategori
FROM products
ORDER BY msrp DESC;

-- Soal 2
SELECT productcode,
       SUM(quantityordered) AS total_unit_terjual,
       COUNT(DISTINCT ordernumber) AS jumlah_pesanan
FROM orderdetails
GROUP BY productcode
HAVING SUM(quantityordered) > (SELECT AVG(quantityordered) FROM orderdetails)
   AND COUNT(DISTINCT ordernumber) > 10
ORDER BY total_unit_terjual DESC;

-- Soal 3
SELECT productcode, productname, quantityinstock, msrp
FROM products
WHERE quantityinstock > (
	SELECT AVG(quantityinstock) 
	FROM products
) AND msrp > (
  	SELECT AVG(msrp) 
 	FROM products
)
ORDER BY quantityinstock DESC;

-- Soal 4
BEGIN;

UPDATE orders
SET status = 'Pengiriman'
WHERE orderNumber = 10100;

SAVEPOINT status_pengiriman;

UPDATE orders
SET status = 'Batal'
WHERE orderNumber = 10100;

ROLLBACK TO SAVEPOINT status_pengiriman;

COMMIT;

-- SC nomor 1
SELECT c.customernumber, c.customername,
	(
		SELECT COUNT(*)
		FROM orders o
		WHERE o.customernumber = c.customernumber
),
CASE
	WHEN (SELECT COUNT(*)
		FROM orders o
		WHERE o.customernumber = c.customernumber) > 5 THEN 'Pelanggan Loyal'
	WHEN (SELECT COUNT(*)
		FROM orders o
		WHERE o.customernumber = c.customernumber) >= 2 AND (SELECT COUNT(*)
		FROM orders o
		WHERE o.customernumber = c.customernumber) <= 5 THEN 'Pelanggan Aktif'
	WHEN (SELECT COUNT(*)
		FROM orders o
		WHERE o.customernumber = c.customernumber) = 1 THEN 'Pelanggan Baru'
	ELSE 'Pelanggan Pasif'
END AS kategori_loyalitas
FROM customers c
ORDER BY kategori_loyalitas DESC;

-- SC nomor 3
SELECT productcode, productname, productline, buyprice
FROM products
WHERE productline = 'Classic Cars' AND buyprice > ALL (
	SELECT buyprice FROM products
	WHERE productline = 'Vintage Cars'
)
ORDER BY buyprice DESC;







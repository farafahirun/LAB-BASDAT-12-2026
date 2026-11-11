SET search_path TO "classicmodels", public;

-- Soal 1

SELECT
    productCode,
    productName,
    MSRP,
    quantityInStock,
    CASE
        WHEN MSRP < 50 AND quantityInStock > 500 THEN 'Ekonomis - Stok Tinggi'
        WHEN MSRP < 50 AND quantityInStock <= 500 THEN 'Ekonomis - Stok Rendah'
        WHEN MSRP >= 50 AND MSRP <= 100 THEN 'Harga Menengah'
        WHEN MSRP > 100 THEN 'Harga Premium'
    END AS kategori
FROM products
ORDER BY MSRP DESC;

-- Soal 2
SELECT
    productCode,
    SUM(quantityOrdered) AS total_unit_terjual,
    COUNT(DISTINCT orderNumber) AS jumlah_pesanan
FROM orderdetails
GROUP BY productCode
HAVING SUM(quantityOrdered) > (SELECT AVG(quantityOrdered) FROM orderdetails)
   AND COUNT(DISTINCT orderNumber) > 10
ORDER BY total_unit_terjual DESC;

-- Soal 3
SELECT
    productCode,
    productName,
    quantityInStock,
    MSRP
FROM products
WHERE quantityInStock > (SELECT AVG(quantityInStock) FROM products)
  AND MSRP > (SELECT AVG(MSRP) FROM products)
ORDER BY quantityInStock DESC;

-- Soal 4

SELECT 
	ordernumber,
	status
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

SELECT 
	ordernumber,
	status
FROM orders
WHERE ordernumber = 10100



-- study case


SELECT 
	e.employeenumber,
	CONCAT(e.firstname, ' ' , e.lastname) AS nama_lengkap,
	e.email,
	e.officecode
FROM employees e
WHERE e.jobtitle = 'Sales Rep' AND NOT EXISTS (
		SELECT 1
		FROM customers c
		JOIN orders o 
		ON c.customerNumber = o.customerNumber
		WHERE c.salesrepemployeenumber = e.employeenumber 
		AND o.status = 'Shipped'
	)
ORDER BY e.employeenumber ASC;








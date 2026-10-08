SET search_path TO "classicmodels", public;

-- Nomor 3
SELECT 
    customerNumber AS "Nomor Pelanggan",
    customerName AS "Nama Pelanggan",
    phone AS "Telepon",
    country AS "Negara"
FROM ClassicModels.Customers;

-- Nomor 4
SELECT productCode, productName, buyPrice 
FROM ClassicModels.Products
WHERE buyPrice > 50
ORDER BY buyPrice DESC
LIMIT 7;

-- Nomor 5
SELECT DISTINCT 
    country AS "Negara Pelanggan"
FROM ClassicModels.Customers
ORDER BY country ASC
LIMIT 5 OFFSET 5;


-- Studycase 1
SELECT DISTINCT status AS "Status PEsanan" FROM orders
WHERE status != 'Camcelled'
ORDER BY status DESC
LIMIT 3 OFFSET 1;

-- Studycase 2
SELECT 
	productname,
	buyprice,
	msrp,
	(msrp - buyprice) AS selisih
FROM products
WHERE msrp <= (buyprice * 1.5)
ORDER BY selisih
LIMIT 10;















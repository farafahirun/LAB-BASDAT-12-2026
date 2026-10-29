-- NO 1
-- ALTER TABLE mahasiswa
-- DROP COLUMN angkatan;

INSERT INTO mahasiswa(nim, nama, email,  id_prodi)
VALUES
	('H071251040', 'Bela', 'bel@gmail.com', 1),
	('H0712510452', 'Fayyadh', NULL, 2),
	('H071251066', 'Fharel', 'fhar@gmail.com', 3)
RETURNING *;


INSERT INTO prodi()

INSERT INTO prodi(nama_prodi)
VALUES
	('Sistem Informasi'),
	('Aktuaria'),
	('Math');
	

SELECT * FROM mahasiswa;

--NO 2
UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50;

DELETE FROM mahasiswa
WHERE email IS NULL;


-- NO 3

SELECT customerNumber AS "Nomor Pelanggan", customerName AS "Nama Pelanggan", phone AS "Telepon", country AS "Negara" FROM classicmodels.customers;

-- NO 4
SELECT productCode, productName, buyPrice FROM classicmodels.products
	WHERE buyPrice >= 50
	ORDER BY buyPrice DESC
	LIMIT 7;

-- NO 5
SELECT DISTINCT country AS "Negara Pelanggan" FROM classicmodels.customers
	ORDER BY country ASC
	LIMIT 5
	OFFSET 5;
	


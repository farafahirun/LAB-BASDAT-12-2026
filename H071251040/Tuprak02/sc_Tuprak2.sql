set search_path TO "classicmodels", public;

SELECT creditLimit AS "Batas Kredit", customerName AS "Nama Perusahaan" FROM customers
	WHERE creditLimit > 100000
	ORDER BY creditLimit DESC;
	

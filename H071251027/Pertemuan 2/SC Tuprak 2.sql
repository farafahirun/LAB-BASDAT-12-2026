SELECT customerName AS "Nama Perusahaan", creditLimit AS "Batas Kredit" FROM classicmodels.customers
WHERE creditLimit > 100000
ORDER BY creditLimit DESC;
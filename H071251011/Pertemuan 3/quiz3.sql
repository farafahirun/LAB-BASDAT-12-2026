SET search_path TO classicmodels, public;

-- no1
SELECT productcode, productname, buyprice, (buyprice - 0.10) AS "Harga Setelah Diskon" FROM products
WHERE productname ILIKE '%car%';

-- no2
SELECT productcode, productname, buyprice, msrp, GREATEST(buyprice, msrp) AS "Harga Tertinggi", LEAST(buyprice, msrp) AS "Harga Terendah", (msrp - buyprice) AS "Selisih Harga" FROM products
ORDER BY buyprice > 30;

-- no3
SELECT ordernumber, orderdate, requireddate, EXTRACT(YEAR FROM orderdate), EXTRACT(MONTH FROM orderdate) FROM orders;
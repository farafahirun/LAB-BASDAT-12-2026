SET search_path TO classicmodels, public;

SELECT productcode, productname, buyprice, msrp, GREATEST(buyprice, msrp) AS "Harga Tertinggi", LEAST(buyprice, msrp) AS "Harga Terendah", COALESCE(buyprice, msrp) AS "Harga Dasar" FROM products
WHERE GREATEST(buyprice, msrp) > 100
ORDER BY GREATEST(buyprice, msrp) DESC;

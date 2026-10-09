SET search_path TO classicmodels, public;

SELECT DISTINCT status AS "Status Pesanan" FROM orders
WHERE status != 'Cancelled'
ORDER BY status DESC
LIMIT 3 OFFSET 1;

SELECT productname, buyprice, msrp, (msrp - buyprice) AS selisih FROM products
WHERE  msrp < buyprice * 1.5
ORDER BY selisih;
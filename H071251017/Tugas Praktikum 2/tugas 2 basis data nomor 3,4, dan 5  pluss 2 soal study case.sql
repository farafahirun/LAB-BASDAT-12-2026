set search_path to 'classicmodels', public ;

-- soal 3
select customerNumber as "nomor pelanggan", 
customerName as "nama pelanggan", 
phone as "nomor" , 
country as "negara" 
from customers;

-- soal 4
select productCode, productName, buyPrice from products 
where buyPrice > 50 
order by buyPrice DESC
limit 7;

-- soal 5
select DISTINCT country as "Negara Pelanggan" from customers 
order by country ASC
limit 5 offset 5;


-- study case 1

select distinct status as "status pemesanan" from orders 
where status != 'Cancelled'
order by status DESC 
limit 3 offset 1;

-- study case 2
select productname, buyprice, msrp, (msrp-buyprice) as selisih from products where msrp <= buyprice * 1.5 order by selisih ASC;








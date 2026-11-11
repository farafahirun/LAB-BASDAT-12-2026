SET search_path to 'classicmodels';

-- Soal 1
SELECT c.contactFirstName, c.customerName, of.city, CONCAT(e.firstName, ' ', e.lastName) AS sales_rep_name
FROM customers c
INNER JOIN employees e 
ON c.salesRepEmployeeNumber = e.employeeNumber

INNER JOIN offices of
ON e.officeCode = of.officeCode

WHERE c.contactFirstName ILIKE 'A%' 
  AND of.city != 'NYC'
ORDER BY c.customerName ASC;

-- 2
SELECT c.customerName, 
    SUM(p.amount) AS total_payment, 
    MAX(p.amount) AS max_single_payment
FROM customers c
INNER JOIN payments p 
ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber, c.customerName
HAVING SUM(p.amount) > 50000
ORDER BY total_payment DESC;

-- 3
SELECT 
    c.customerName, 
    COUNT(DISTINCT o.orderNumber) AS total_order, 
    ROUND(AVG(od.quantityOrdered), 2) AS avg_quantity_per_order
FROM customers c
INNER JOIN orders o 
ON c.customerNumber = o.customerNumber

INNER JOIN orderDetails od 
ON o.orderNumber = od.orderNumber

GROUP BY c.customerNumber, c.customerName
HAVING (COUNT(DISTINCT o.orderNumber) > 3) AND (AVG(od.quantityOrdered) > 35)
ORDER BY total_order DESC, avg_quantity_per_order DESC;

-- 4
SELECT 
    pl.productLine, 
    SUM(od.quantityOrdered) AS total_terjual, 
    ROUND(AVG(od.priceEach), 2) AS rata_rata_harga, 
    ROUND(AVG((p.MSRP - od.priceEach)/p.MSRP * 100), 2) AS avg_discount_percentage
FROM productLines pl
INNER JOIN products p 
ON pl.productLine = p.productLine

INNER JOIN orderDetails od 
ON p.productCode = od.productCode

GROUP BY pl.productLine
HAVING (SUM(od.quantityOrdered) > 3000) AND (AVG(od.priceEach) > 80)
ORDER BY total_terjual DESC;

-- 5
select 
	c.customername,
	sum(od.priceeach*od.quantityordered) as total_transaksi,
	count(distinct (o.ordernumber, o.status = 'Shipped'))as total_shipped_orders,
	round(sum(od.priceeach*od.quantityordered)
	/count(distinct o.ordernumber),2) as avg_transaction_per_order
from customers as c
join orders as o
	on c.customernumber = o.customernumber
join orderdetails as od
	on o.ordernumber = od.ordernumber
group by c.customername, c.customernumber
having count(distinct extract(year from o.orderdate)) > 1
order by total_transaksi desc
limit 5;

-- 6
SELECT 
    c.customerName, 
    c.city AS customer_city, 
    o.city AS office_city, 
    SUM(od.quantityOrdered) AS total_unit_terjual, 
    ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT ord.orderNumber), 2) AS avg_nilai_per_order
FROM customers c
INNER JOIN employees e 
ON c.salesRepEmployeeNumber = e.employeeNumber

INNER JOIN offices o 
ON e.officeCode = o.officeCode

INNER JOIN orders ord 
ON c.customerNumber = ord.customerNumber

INNER JOIN orderDetails od 
ON ord.orderNumber = od.orderNumber

WHERE o.territory = 'EMEA'
GROUP BY c.customerNumber, c.customerName, c.city, o.city
HAVING (COUNT(DISTINCT EXTRACT(YEAR FROM ord.orderDate)) > 2) 
   AND (SUM(od.quantityOrdered) > 1000) 
   AND ((SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT ord.orderNumber)) > 10000)
ORDER BY avg_nilai_per_order DESC;


-- STUDY CASE
select c.customerName as customername, o.orderNumber as ordernumber, p.productName as productname, od.quantityOrdered as quantityordered,
    od.priceEach as priceeach
from customers c
join orders o
    on c.customerNumber = o.customerNumber
join orderdetails od
    on o.orderNumber = od.orderNumber
join products p
    on od.productCode = p.productCode
where p.productLine = 'Classic Cars'
    and od.quantityOrdered > 30
    and o.status = 'Shipped';



select o.orderNumber as ordernumber, o.orderDate as orderdate, p.productName as productname, p.productLine as productline,
    od.quantityOrdered as quantityordered, od.priceEach as priceeach
from orders o
join orderdetails od
   using (orderNumber)
join products p
   using (productCode)
where od.quantityOrdered >= 40
    and p.productLine in ('Motorcycles', 'Planes');


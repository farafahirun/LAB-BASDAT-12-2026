SET search_path TO classicmodels,public;

-- no 1
SELECT 
    productCode AS kode_produk,
    productName AS nama_produk,
    MSRP,
    quantityInStock AS jumlah_stok,
    CASE 
        WHEN MSRP < 50 AND quantityInStock > 500 THEN 'Ekonomis - Stok Tinggi'
        WHEN MSRP < 50 AND quantityInStock <= 500 THEN 'Ekonomis - Stok Rendah'
        WHEN MSRP BETWEEN 50 AND 100 THEN 'Harga Menengah'
        WHEN MSRP > 100 THEN 'Harga Premium'
    END AS kategori
FROM products
ORDER BY MSRP DESC;

-- no 2
SELECT 
    productCode AS kode_produk,
    SUM(quantityOrdered) AS total_unit_terjual,
    COUNT(DISTINCT orderNumber) AS jumlah_pesanan_berbeda
FROM orderdetails
GROUP BY productCode
HAVING 
    SUM(quantityOrdered) > (SELECT AVG(quantityOrdered) FROM orderdetails)
    AND COUNT(DISTINCT orderNumber) > 10
ORDER BY total_unit_terjual DESC;

-- no 3
SELECT
    productCode AS kode_produk,
    productName AS nama_produk,
    quantityInStock AS jumlah_stok,
    MSRP
FROM products
WHERE 
    quantityInStock > (SELECT AVG(quantityInStock) FROM products)
    AND MSRP > (SELECT AVG(MSRP) FROM products)
ORDER BY quantityInStock DESC;

-- no 4
BEGIN;

-- perubahan pertama
UPDATE orders SET status = 'Pengiriman' WHERE orderNumber = 10100;

SAVEPOINT status_pengiriman;

-- perubahan kedua yang salah
UPDATE orders SET status = 'Batal' WHERE orderNumber = 10100;

-- batalkan perubahan kedua saja
ROLLBACK TO SAVEPOINT status_pengiriman;

-- simpan perubahan pertama
COMMIT;

-- no 5
-- 1. Tabel anggota
CREATE TABLE anggota (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_anggota VARCHAR(50) NOT NULL,
    kota_domisili VARCHAR(20) NOT NULL
);

-- 2. Tabel buku
CREATE TABLE buku (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    judul_buku VARCHAR(100) NOT NULL,
    genre VARCHAR(20) NOT NULL,
    stok INTEGER DEFAULT 1
);

-- 3. Tabel peminjaman
CREATE TABLE peminjaman (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_anggota INTEGER REFERENCES anggota(id),
    id_buku INTEGER REFERENCES buku(id),
    tanggal_pinjam DATE NOT NULL,
    tanggal_kembali DATE,
    denda INTEGER DEFAULT 0
);

-- Index untuk pencarian lebih cepat
CREATE INDEX idx_buku_genre ON buku(genre);
CREATE INDEX idx_anggota_kota ON anggota(kota_domisili);


-- study case
SELECT
	productcode AS "Kode Produk",
	productName AS "Nama Produk",
	productline AS "Lini Produk",
	buyprice AS "Harga Beli"
FROM products
WHERE productline = 'Classic Cars' 
	AND buyPrice > ALL (
	SELECT buyPrice
	FROM products
	WHERE productLine = 'Vintage Cars'
)
ORDER BY "Harga Beli" DESC;








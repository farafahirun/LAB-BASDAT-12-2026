-- no5
CREATE TABLE anggota (
	id_anggota INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_anggota VARCHAR(50) NOT NULL,
	kota_domisili VARCHAR(20) NOT NULL
);

CREATE TABLE buku (
	id_buku INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	judul_buku VARCHAR(100) NOT NULL,
	genre VARCHAR (20) NOT NULL,
	stok INTEGER DEFAULT 1
);

CREATE TABLE peminjaman (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	id_anggota INTEGER,
	CONSTRAINT fk_peminjaman_anggota
		FOREIGN KEY(id_anggota)
		REFERENCES anggota(id_anggota),
	id_buku INTEGER,
	CONSTRAINT fk_peminjaman_buku
		FOREIGN KEY(id_buku)
		REFERENCES buku(id_buku),
	tanggal_pinjam DATE NOT NULL,
	tanggal_kembali DATE,
	denda INTEGER DEFAULT 0
);

SELECT table_name 
FROM information_schema.tables
WHERE table_schema = 'public';

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'anggota';

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'buku';

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'peminjaman';

CREATE INDEX pencarian_genre
ON buku(genre);

SELECT genre
FROM buku;

CREATE INDEX pencarian_anggota_berdasarkan_domisili
ON anggota(kota_domisili);

SELECT kota_domisili
FROM anggota;
-- soal 1
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'poliklinik';

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'pasien';

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'dokter';

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'rekam_medis';

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'resep_obat';

CREATE TABLE poliklinik (
	id_poli INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_poli VARCHAR(50) NOT NULL UNIQUE,
	gedung VARCHAR(50) NOT NULL
);

CREATE TABLE pasien (
	id_pasien INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nik VARCHAR(16) NOT NULL UNIQUE,
	nama_pasien VARCHAR(150) NOT NULL,
	jenis_kelamin VARCHAR(1)
);

CREATE TABLE dokter (
	id_dokter INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_dokter VARCHAR(150) NOT NULL,
	no_izin_praktek VARCHAR(30) UNIQUE,
	pengalaman_tahun INT DEFAULT 0.00,
	id_poli INT,
	CONSTRAINT fk_dokter_poliklinik
		FOREIGN KEY (id_poli)
		REFERENCES poliklinik(id_poli)
);

CREATE TABLE rekam_medis (
	id_rm INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	keluhan TEXT NOT NULL,
	biaya_pemeriksaan NUMERIC(12,2) DEFAULT 150000.00,
	id_pasien INT,
	CONSTRAINT fk_rm_pasien
		FOREIGN KEY(id_pasien)
		REFERENCES pasien(id_pasien)
);

CREATE TABLE resep_obat (
	id_resep INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_obat VARCHAR(100) NOT NULL,
	jumlah INT CHECK(jumlah > 0),
	id_rm INT,
	CONSTRAINT fk_resepobat_rm
		FOREIGN KEY(id_rm)
		REFERENCES rekam_medis(id_rm)	
);

-- soal 2
ALTER TABLE pasien
ADD COLUMN gol_darah VARCHAR(2);

ALTER TABLE resep_obat 
ALTER COLUMN nama_obat TYPE TEXT;

ALTER TABLE poliklinik
DROP COLUMN gedung;

-- soal 3
ALTER TABLE rekam_medis
DROP TABLE rekam_medis;

ALTER TABLE resep_obat
DROP TABLE resep_obat;

-- perbaikan 1
DROP TABLE poliklinik
DROP TABLE pasien 
DROP TABLE doktor
DROP TABLE rekam_medis
DROP TABLE resep_obat

-- perbaikan 2
ALTER TABLE pasien
DROP COLUMN gol_darah;

ALTER TABLE resep_obat
ALTER COLUMN nama_obat TYPE VARCHAR(100);

ALTER TABLE poliklinik
ADD COLUMN gedung VARCHAR(50) NOT NULL;
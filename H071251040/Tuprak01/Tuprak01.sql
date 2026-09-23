-- No. 1
-- CREATE DATABASE db_rs_sejahtera;


CREATE TABLE poliklinik(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_poli VARCHAR(50) NOT NULL UNIQUE,
	gedung VARCHAR(50) NOT NULL
);


CREATE TABLE pasien(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nik VARCHAR(16) NOT NULL UNIQUE,
	nama_pasien VARCHAR(150) NOT NULL,
	jenis_kelamin VARCHAR(1) NOT NULL
);

CREATE TABLE dokter(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_dokter VARCHAR(150) NOT NULL,
	no_izin_praktek VARCHAR(30) UNIQUE,
	pengalaman_tahun INT DEFAULT 0 CHECK(pengalaman_tahun >= 0),
	id_poli INT,
	CONSTRAINT fk_poliklinik_pk
		FOREIGN KEY (id_poli)
		REFERENCES poliklinik(id)
);

CREATE TABLE rekam_medis(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	keluhan TEXT NOT NULL,
	biaya_pemeriksaan NUMERIC DEFAULT 150000,
	id_pasien INT,
	id_dokter INT,
	
	CONSTRAINT fk_rekammedis_pasien
		FOREIGN KEY (id_pasien)
		REFERENCES pasien(id),
	CONSTRAINT fk_dokter_pk
		FOREIGN KEY (id_dokter)
		REFERENCES dokter(id)		
);

CREATE TABLE resep_obat(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_obat VARCHAR(100) NOT NULL,
	jumlah INT CHECK(jumlah > 0),
	id_rm INT,
	CONSTRAINT fk_rm_pk
		FOREIGN KEY (id_rm)
		REFERENCES rekam_medis(id)
);

No 2
ALTER TABLE pasien
ADD COLUMN gol_darah VARCHAR(2);

ALTER TABLE resep_obat
ALTER COLUMN nama_obat TYPE TEXT;

ALTER TABLE poliklinik
DROP COLUMN gedung;


-- No 3
DROP TABLE rekam_medis;
DROP TABLE resep_obat;


SELECT column_name, data_type, character_maximun_lenght, is_nullable
FROM information_schema.columns
WHERE table_name = 'poliklinik';
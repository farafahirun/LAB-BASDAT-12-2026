-- CREATE DATABASE db_rs_sejahtera

-- Nomor 1
CREATE TABLE poliklinik (
    id_poli SERIAL PRIMARY KEY,
    nama_poli VARCHAR(50) NOT NULL UNIQUE,
    gedung VARCHAR(50) NOT NULL
);

CREATE TABLE pasien (
    id_pasien SERIAL PRIMARY KEY,
    nik VARCHAR(16) NOT NULL UNIQUE,
    nama_pasien VARCHAR(150) NOT NULL,
    jenis_kelamin CHAR(1) CHECK (jenis_kelamin IN ('L', 'P'))
);

CREATE TABLE dokter (
    id_dokter SERIAL PRIMARY KEY,
    nama_dokter VARCHAR(150) NOT NULL,
    no_izin_praktek VARCHAR(30) UNIQUE,
    pengalaman_tahun INTEGER DEFAULT 0 CHECK (pengalaman_tahun >= 0),
    id_poli INTEGER,
    FOREIGN KEY (id_poli) REFERENCES poliklinik(id_poli)
);

CREATE TABLE rekam_medis (
    id_rm SERIAL PRIMARY KEY,
    keluhan TEXT NOT NULL,
    biaya_pemeriksaan NUMERIC DEFAULT 150000,
    id_pasien INTEGER,
    id_dokter INTEGER,
    FOREIGN KEY (id_pasien) REFERENCES pasien(id_pasien),
    FOREIGN KEY (id_dokter) REFERENCES dokter(id_dokter)
);

CREATE TABLE resep_obat (
    id_resep SERIAL PRIMARY KEY,
    nama_obat VARCHAR(100) NOT NULL,
    jumlah INTEGER CHECK (jumlah > 0),
    id_rm INTEGER,
    FOREIGN KEY (id_rm) REFERENCES rekam_medis(id_rm)
);



-- Nomor 2
ALTER TABLE pasien
ADD COLUMN gol_darah VARCHAR(2);

ALTER TABLE resep_obat
ALTER COLUMN nama_obat TYPE TEXT;

ALTER TABLE poliklinik
DROP COLUMN gedung;



-- Nomor 3
DROP TABLE resep_obat;

DROP TABLE rekam_medis;


SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'poliklinik';




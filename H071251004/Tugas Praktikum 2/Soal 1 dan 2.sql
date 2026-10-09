SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

--mengecek column
SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'mahasiswa';

-- Membuat tabel prodi
CREATE TABLE prodi (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_prodi VARCHAR(100) NOT NULL
);

CREATE TABLE mahasiswa (
	nim VARCHAR(10)PRIMARY KEY, 
	nama VARCHAR(100) NOT NULL,
	ipk NUMERIC(3, 2) DEFAULT 0.00,
	email VARCHAR(150) UNIQUE,
	id_prodi INT,
	CONSTRAINT fk_mahasiswa_prodi
		FOREIGN KEY (id_prodi)
		REFERENCES prodi(id)
)

--Alter Table
ALTER TABLE mahasiswa
ADD COLUMN angkatan INT NOT NULL;

--ubah tipe data
ALTER TABLE mahasiswa
ALTER COLUMN nim TYPE VARCHAR(50);

--hapus kolom
ALTER TABLE mahasiswa
DROP COLUMN angkatan;

----------------------------------------------------------------------------------------
SELECT * FROM prodi;
SELECT * FROM mahasiswa;

-- Soal 1
INSERT INTO prodi (nama_prodi)
VALUES ('Informatika'), ('Sistem Informasi'), ('Teknologi Informasi');

INSERT INTO mahasiswa (nim, nama, email, id_prodi)
VALUES
  ('D121251020', 'Alexander Danendra', 'alexdanendra@email.com', 1),
  ('H071251050', 'Kirana Larasati', 'kiranalarasati@email.com', 2),
  ('H071251011', 'Aletta Clarissa', NULL, 2)
RETURNING *;

-- Soal 2
UPDATE mahasiswa
SET ipk = 3.50
WHERE nim IN ('H071251050');

UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50
RETURNING *;

DELETE FROM mahasiswa
WHERE email IS NULL
RETURNING *;
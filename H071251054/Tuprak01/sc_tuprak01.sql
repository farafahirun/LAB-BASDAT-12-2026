CREATE TABLE mata_kuliah (
	id_mk INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	kode_mk VARCHAR(10) UNIQUE,
	nama_mk VARCHAR(100) NOT NULL,
	sks INT CHECK (sks BETWEEN 1 AND 6),
	semester INT CHECK (semester BETWEEN 1 AND 8)
);

















CREATE TABLE departemen (
	id INT  GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_departemen VARCHAR (50) NOT NULL UNIQUE
);

CREATE TABLE karyawan (
	id_karyawan SERIAL PRIMARY KEY,
	nama_karyawan VARCHAR (50) NOT NULL,
	gaji INTEGER DEFAULT 0 CHECK (gaji >= 4000000),
	id_departemen INT,
	CONSTRAINT fk_karyawan_departen
		FOREIGN KEY (id_departemen)
		REFERENCES departemen (id)
);

DROP TABLE karyawan;

DROP TABLE departemen;

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'karyawan';
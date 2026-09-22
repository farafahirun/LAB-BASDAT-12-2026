SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'departemen';

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'karyawan';

CREATE TABLE departemen (
	id_departemen INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_departemen TEXT NOT NULL UNIQUE
);

CREATE TABLE karyawan (
	id_karyawan INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_karyawan TEXT NOT NULL,
	gaji NUMERIC(12,2) DEFAULT 150000.00 CHECK (gaji > 4000000),
	id_departemen INT,
	CONSTRAINT fk_karyawan_departemen
		FOREIGN KEY (id_departemen)
		REFERENCES departemen(id_departemen)
);


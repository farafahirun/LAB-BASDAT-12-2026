CREATE TABLE departemen (
	id_departemen INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_departemen VARCHAR NOT NULL UNIQUE
);

CREATE TABLE karyawan (
	id_karyawan INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_karyawan TEXT,
	gaji NUMERIC CHECK (gaji >= 4000000),
	id_departemen INT,
	CONSTRAINT fk_karyawan_departemen
		FOREIGN KEY (id_departemen)
		REFERENCES departemen(id_departemen)
);

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'departemen';

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'karyawan';


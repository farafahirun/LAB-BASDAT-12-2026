CREATE TABLE matkul(
	id SERIAL PRIMARY KEY,
	kode_mk VARCHAR(15) UNIQUE,
	nama_mk VARCHAR(150) NOT NULL,
	sks INT CHECK(sks >= 1 AND sks <=6),
	semester INT CHECK(semester >=1 AND semester <=8)
);
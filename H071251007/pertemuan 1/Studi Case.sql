CREATE DATABASE sc_tp1;

-- tema perpustkaan
CREATE TABLE penerbit(
	id SERIAL PRIMARY KEY,
	nama_penerbit VARCHAR(150) NOT NULL
);

CREATE TABLE buku(
	id_buku SERIAL NOT NULL,
	judul VARCHAR(150) NOT NULL,
	tahun_terbit INT CHECK (tahun_terbit >= 1900),
	id_penerbit INT,
	CONSTRAINT fk_buku_penerbit
		FOREIGN KEY (id_penerbit)
		REFERENCES penerbit(id)
);
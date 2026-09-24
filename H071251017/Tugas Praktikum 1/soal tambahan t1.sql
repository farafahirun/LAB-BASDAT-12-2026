CREATE TABLE penerbit (
	id_penerbit INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_penerbit TEXT
);


CREATE TABLE buku (
	id_buku INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	judul_buku TEXT NOT NULL,
	tahun_terbit INT CHECK (tahun_terbit >=1900),
	id_penerbit INT,
	CONSTRAINT fk_buku_penerbit
		FOREIGN KEY (id_penerbit)
		REFERENCES penerbit(id_penerbit)
);



-- Soal 5
CREATE TABLE anggota (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_anggota VARCHAR(50) NOT NULL,
    kota_domisili VARCHAR(20) NOT NULL
);

CREATE TABLE buku (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    judul_buku VARCHAR(100) NOT NULL,
    genre VARCHAR(20) NOT NULL,
    stok INT DEFAULT 1
);

CREATE TABLE peminjaman (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_anggota INT,
    id_buku INT,
    tanggal_pinjam DATE NOT NULL,
    tanggal_kembali DATE,
    denda INT DEFAULT 0,
    CONSTRAINT fk_peminjaman_anggota
        FOREIGN KEY (id_anggota) REFERENCES anggota(id),
    CONSTRAINT fk_peminjaman_buku
        FOREIGN KEY (id_buku) REFERENCES buku(id)
);

CREATE INDEX index_buku_genre ON buku (genre);
CREATE INDEX index_anggota_kota_domisili ON anggota (kota_domisili);
CREATE TABLE anggota (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_anggota VARCHAR(50) NOT NULL,
    kota_domisili VARCHAR(20) NOT NULL
);

CREATE TABLE buku (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    judul_buku VARCHAR(100) NOT NULL,
    genre VARCHAR(20) NOT NULL,
    stok INTEGER DEFAULT 1
);

CREATE TABLE peminjaman (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_anggota INTEGER REFERENCES anggota(id),
    id_buku INTEGER REFERENCES buku(id),
    tanggal_pinjam DATE NOT NULL,
    tanggal_kembali DATE,
    denda INTEGER DEFAULT 0
);

CREATE INDEX idx_buku_genre ON buku(genre);
CREATE INDEX idx_anggota_kota_domisili ON anggota(kota_domisili);



-- study case 2
CREATE TABLE kurir (
    id_kurir SERIAL PRIMARY KEY,
    nama_kurir VARCHAR(50) NOT NULL,
    no_telepon VARCHAR(20) NOT NULL UNIQUE,
    status_aktif BOOLEAN DEFAULT TRUE
);

CREATE TABLE pengiriman (
    id_pengiriman SERIAL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nomor_resi VARCHAR(30) NOT NULL UNIQUE,
    id_kurir INTEGER REFERENCES kurir(id_kurir),
    tanggal_kirim TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ongkos_kirim NUMERIC(12,2) NOT NULL CHECK (ongkos_kirim > 0),
    status_pengiriman VARCHAR(20) DEFAULT 'Dalam Perjalanan'
);

CREATE INDEX idx_pengiriman_kurir
ON pengiriman(id_kurir);


CREATE INDEX idx_pengiriman_status
ON pengiriman(status_pengiriman);

DROP INDEX idx_pengiriman_status;












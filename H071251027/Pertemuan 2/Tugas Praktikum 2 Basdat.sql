

CREATE TABLE prodi (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_prodi VARCHAR(100) NOT NULL
);

CREATE TABLE mahasiswa (
    nim VARCHAR(10) PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    ipk NUMERIC(3,2) DEFAULT 0.00,
    email VARCHAR(150) UNIQUE,
    id_prodi INT,
    CONSTRAINT fk_mahasiswa_prodi
        FOREIGN KEY (id_prodi)
        REFERENCES prodi(id)
);

INSERT INTO prodi (nama_prodi)
VALUES
('Sistem Informasi'),
('Gizi');

-- Soal 1
INSERT INTO mahasiswa (nim, nama, email, id_prodi)
VALUES
('H071251035', 'Almendo', 'almenda@gmail.com', 1),
('H071251039', 'Ayu', NULL, 2),
('H071251032', 'Reyhan', 'genting@gmail.com', 1)
RETURNING *;

-- Soal 2
UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50;

DELETE FROM mahasiswa
WHERE email IS NULL;

SELECT *
FROM mahasiswa;
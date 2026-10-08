-- CREATE TABLE prodi (
--     id_prodi SERIAL PRIMARY KEY,
--     nama_prodi VARCHAR(50) NOT NULL
-- );

-- INSERT INTO prodi (nama_prodi) 
-- VALUES ('Sistem Informasi'), ('Informatika'), ('Ilmu Komputer');

-- CREATE TABLE mahasiswa (
--     nim VARCHAR(15) PRIMARY KEY,
--     nama VARCHAR(100) NOT NULL,
--     email VARCHAR(100),
--     ipk NUMERIC(3,2),
--     id_prodi INTEGER,
--     CONSTRAINT fk_prodi FOREIGN KEY (id_prodi) REFERENCES prodi(id_prodi)
-- );



-- Nomor 1
INSERT INTO mahasiswa (nim, nama, email, id_prodi)
VALUES ('H071251054', 'M. Taqwin Yunus', NULL , 1), 
		('H061251090', 'Aceron', 'aceron@gmail.com', 2), 
		('H011251001', 'Lemon RRQ', 'LemonRRQ@gmail.com', 3)
RETURNING * ;

-- Nomor 2
UPDATE mahasiswa
SET ipk = 3.50
WHERE nim = 'H061251090';

UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50
RETURNING * ;

DELETE FROM mahasiswa
WHERE email IS NULL
RETURNING * ;







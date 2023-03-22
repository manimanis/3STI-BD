DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
USE hospital;

CREATE TABLE service (
    NumServ INT NOT NULL PRIMARY KEY,
    LibServ VARCHAR(32) NOT NULL
);

CREATE TABLE patient (
    CodePat VARCHAR(6) NOT NULL PRIMARY KEY CHECK (LEFT(CodePat, 1) = 'P'),
    Nom VARCHAR(64) NOT NULL,
    Prenom VARCHAR(64) NOT NULL,
    DateNaiss DATE,
    Genre CHAR(1) NOT NULL DEFAULT 'M' CHECK(Genre IN ('M', 'F')),
    Mutuelle BOOLEAN DEFAULT 0
);

CREATE TABLE hospitalisation (
    NumServ INT NOT NULL,
    CodePat VARCHAR(6) NOT NULL,
    DateEntree DATE NOT NULL DEFAULT NOW(),
    DateSortie DATE CHECK(DateSortie >= DateEntree OR DateSortie IS NULL),
    Frais DOUBLE PRECISION NOT NULL DEFAULT 0 CHECK(Frais >= 0),
    PRIMARY KEY (NumServ, CodePat, DateEntree),
    FOREIGN KEY (NumServ) 
        REFERENCES service (NumServ)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (CodePat)
        REFERENCES patient (CodePat)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO service (NumServ, LibServ)
VALUES ('10','Urgences'),
	('20','Cardiologie'),
	('30','Chirurgie'),
	('40','Radiologie'),
	('50','Laboratoire');

INSERT INTO patient (CodePat, Nom, Prenom, Genre, DateNaiss, Mutuelle)
VALUES ('P13','Dhieb','Hamed','M','1965-07-21','1'),
    ('P16','Karrout','Hedia','F','2004-02-09','1'),
    ('P19','Feki','Hichem','M','1950-07-23','0'),
    ('P22','Ben Salem','Souha','F','2007-06-29','1'),
    ('P25','Mejri','Sami','M','1985-06-16','0'),
    ('P28','Badii','Mayssa','F','1991-10-16','1'),
    ('P31','Ketari','Nabil','M','1984-04-11','1'),
    ('P34','Hamdi','Radhia','F','2004-09-04','0'),
    ('P37','Béji','Mejdi','M','1996-09-08','1'),
    ('P40','Khalil','Bochra','F','1956-03-21','1');

INSERT INTO hospitalisation (NumServ, CodePat, DateEntree, DateSortie, Frais)
VALUES ('10','P13','2021-06-28','2021-06-28','241.0'),
	('30','P13','2021-06-29','2021-06-30','350.0'),
	('40','P13','2021-06-29','2021-06-29','60.0'),
	('50','P13','2021-06-29','2021-06-29','60.0'),
	('30','P13','2021-08-21','2021-08-28','680.0'),
	('40','P13','2021-08-21','2021-08-21','60.0'),
	('50','P13','2021-08-21','2021-08-21','60.0'),
	('40','P13','2021-08-23','2021-08-23','60.0'),
	('50','P13','2021-08-23','2021-08-23','60.0'),
	('40','P13','2021-08-24','2021-08-24','60.0'),
	('50','P13','2021-08-24','2021-08-24','60.0'),
	('40','P13','2021-08-25','2021-08-25','60.0'),
	('50','P13','2021-08-25','2021-08-25','60.0'),
	('40','P13','2021-08-27','2021-08-27','60.0'),
	('50','P13','2021-08-27','2021-08-27','60.0'),
	('30','P13','2021-08-29','2021-09-08','4290.0'),
	('40','P13','2021-08-29','2021-08-29','60.0'),
	('50','P13','2021-08-29','2021-08-29','60.0'),
	('40','P13','2021-08-30','2021-08-30','60.0'),
	('50','P13','2021-08-30','2021-08-30','60.0'),
	('40','P13','2021-08-31','2021-08-31','60.0'),
	('50','P13','2021-08-31','2021-08-31','60.0'),
	('40','P13','2021-09-01','2021-09-01','60.0'),
	('50','P13','2021-09-01','2021-09-01','60.0'),
	('40','P13','2021-09-02','2021-09-02','60.0'),
	('50','P13','2021-09-02','2021-09-02','60.0'),
	('40','P13','2021-09-03','2021-09-03','60.0'),
	('50','P13','2021-09-03','2021-09-03','60.0'),
	('40','P13','2021-09-04','2021-09-04','60.0'),
	('50','P13','2021-09-04','2021-09-04','60.0'),
	('40','P13','2021-09-06','2021-09-06','60.0'),
	('50','P13','2021-09-06','2021-09-06','60.0'),
	('40','P13','2021-09-07','2021-09-07','60.0'),
	('50','P13','2021-09-07','2021-09-07','60.0'),
	('10','P16','2021-06-12','2021-06-12','894.0'),
	('20','P16','2021-06-13','2021-06-17','1075.0'),
	('40','P16','2021-06-13','2021-06-13','60.0'),
	('50','P16','2021-06-13','2021-06-13','60.0'),
	('40','P16','2021-06-14','2021-06-14','60.0'),
	('50','P16','2021-06-14','2021-06-14','60.0'),
	('20','P16','2021-06-24','2021-06-27','800.0'),
	('40','P16','2021-06-26','2021-06-26','60.0'),
	('50','P16','2021-06-26','2021-06-26','60.0'),
	('10','P19','2021-03-18','2021-03-18','575.0'),
	('10','P22','2021-02-10','2021-02-10','113.0'),
	('20','P22','2021-02-11','2021-02-13','375.0'),
	('40','P22','2021-02-11','2021-02-11','60.0'),
	('50','P22','2021-02-11','2021-02-11','60.0'),
	('40','P22','2021-02-12','2021-02-12','60.0'),
	('50','P22','2021-02-12','2021-02-12','60.0'),
	('20','P22','2021-03-05','2021-03-10','360.0'),
	('40','P22','2021-03-05','2021-03-05','60.0'),
	('50','P22','2021-03-05','2021-03-05','60.0'),
	('40','P22','2021-03-06','2021-03-06','60.0'),
	('50','P22','2021-03-06','2021-03-06','60.0'),
	('40','P22','2021-03-09','2021-03-09','60.0'),
	('50','P22','2021-03-09','2021-03-09','60.0'),
	('10','P25','2021-01-06','2021-01-06','125.0'),
	('10','P28','2021-01-01','2021-01-01','265.0'),
	('30','P28','2021-01-02','2021-01-05','1620.0'),
	('40','P28','2021-01-04','2021-01-04','60.0'),
	('50','P28','2021-01-04','2021-01-04','60.0'),
	('10','P31','2021-01-05','2021-01-05','36.0'),
	('10','P34','2021-05-10','2021-05-10','553.0'),
	('10','P37','2021-02-03','2021-02-03','80.0'),
	('20','P37','2021-02-04','2021-02-14','3355.0'),
	('40','P37','2021-02-05','2021-02-05','60.0'),
	('50','P37','2021-02-05','2021-02-05','60.0'),
	('40','P37','2021-02-07','2021-02-07','60.0'),
	('50','P37','2021-02-07','2021-02-07','60.0'),
	('40','P37','2021-02-09','2021-02-09','60.0'),
	('50','P37','2021-02-09','2021-02-09','60.0'),
	('40','P37','2021-02-10','2021-02-10','60.0'),
	('50','P37','2021-02-10','2021-02-10','60.0'),
	('40','P37','2021-02-13','2021-02-13','60.0'),
	('50','P37','2021-02-13','2021-02-13','60.0'),
	('20','P37','2021-05-02','2021-05-05','1360.0'),
	('40','P37','2021-05-02','2021-05-02','60.0'),
	('50','P37','2021-05-02','2021-05-02','60.0'),
	('40','P37','2021-05-03','2021-05-03','60.0'),
	('50','P37','2021-05-03','2021-05-03','60.0'),
	('20','P37','2021-06-26','2021-06-29','200.0'),
	('40','P37','2021-06-27','2021-06-27','60.0'),
	('50','P37','2021-06-27','2021-06-27','60.0'),
	('40','P37','2021-06-28','2021-06-28','60.0'),
	('50','P37','2021-06-28','2021-06-28','60.0'),
	('20','P37','2021-09-04','2021-09-06','315.0'),
	('40','P37','2021-09-04','2021-09-04','60.0'),
	('50','P37','2021-09-04','2021-09-04','60.0'),
	('40','P37','2021-09-05','2021-09-05','60.0'),
	('50','P37','2021-09-05','2021-09-05','60.0'),
	('10','P40','2021-03-26','2021-03-26','50.0'),
	('20','P40','2021-03-27','2021-03-27','310.0'),
	('20','P40','2021-04-24','2021-05-02','1980.0'),
	('40','P40','2021-04-25','2021-04-25','60.0'),
	('50','P40','2021-04-25','2021-04-25','60.0'),
	('40','P40','2021-04-26','2021-04-26','60.0'),
	('50','P40','2021-04-26','2021-04-26','60.0'),
	('40','P40','2021-04-27','2021-04-27','60.0'),
	('50','P40','2021-04-27','2021-04-27','60.0'),
	('40','P40','2021-05-01','2021-05-01','60.0'),
	('50','P40','2021-05-01','2021-05-01','60.0'),
	('20','P40','2021-05-22','2021-05-31','3800.0'),
	('40','P40','2021-05-22','2021-05-22','60.0'),
	('50','P40','2021-05-22','2021-05-22','60.0'),
	('40','P40','2021-05-23','2021-05-23','60.0'),
	('50','P40','2021-05-23','2021-05-23','60.0'),
	('40','P40','2021-05-25','2021-05-25','60.0'),
	('50','P40','2021-05-25','2021-05-25','60.0'),
	('40','P40','2021-05-26','2021-05-26','60.0'),
	('50','P40','2021-05-26','2021-05-26','60.0'),
	('40','P40','2021-05-27','2021-05-27','60.0'),
	('50','P40','2021-05-27','2021-05-27','60.0'),
	('40','P40','2021-05-28','2021-05-28','60.0'),
	('50','P40','2021-05-28','2021-05-28','60.0'),
	('40','P40','2021-05-30','2021-05-30','60.0'),
	('50','P40','2021-05-30','2021-05-30','60.0'),
	('20','P40','2021-07-16','2021-07-25','900.0'),
	('40','P40','2021-07-16','2021-07-16','60.0'),
	('50','P40','2021-07-16','2021-07-16','60.0'),
	('40','P40','2021-07-18','2021-07-18','60.0'),
	('50','P40','2021-07-18','2021-07-18','60.0'),
	('40','P40','2021-07-19','2021-07-19','60.0'),
	('50','P40','2021-07-19','2021-07-19','60.0'),
	('40','P40','2021-07-20','2021-07-20','60.0'),
	('50','P40','2021-07-20','2021-07-20','60.0'),
	('40','P40','2021-07-21','2021-07-21','60.0'),
	('50','P40','2021-07-21','2021-07-21','60.0'),
	('40','P40','2021-07-22','2021-07-22','60.0'),
	('50','P40','2021-07-22','2021-07-22','60.0'),
	('40','P40','2021-07-23','2021-07-23','60.0'),
	('50','P40','2021-07-23','2021-07-23','60.0'),
	('40','P40','2021-07-24','2021-07-24','60.0'),
	('50','P40','2021-07-24','2021-07-24','60.0'),
	('20','P40','2021-09-08','2021-09-15','3360.0'),
	('40','P40','2021-09-08','2021-09-08','60.0'),
	('50','P40','2021-09-08','2021-09-08','60.0'),
	('40','P40','2021-09-09','2021-09-09','60.0'),
	('50','P40','2021-09-09','2021-09-09','60.0'),
	('40','P40','2021-09-11','2021-09-11','60.0'),
	('50','P40','2021-09-11','2021-09-11','60.0'),
	('40','P40','2021-09-12','2021-09-12','60.0'),
	('50','P40','2021-09-12','2021-09-12','60.0'),
	('40','P40','2021-09-13','2021-09-13','60.0'),
	('50','P40','2021-09-13','2021-09-13','60.0'),
	('40','P40','2021-09-14','2021-09-14','60.0'),
	('50','P40','2021-09-14','2021-09-14','60.0'),
	('20','P40','2021-12-04','2021-12-09','900.0'),
	('40','P40','2021-12-04','2021-12-04','60.0'),
	('50','P40','2021-12-04','2021-12-04','60.0'),
	('40','P40','2021-12-06','2021-12-06','60.0'),
	('50','P40','2021-12-06','2021-12-06','60.0'),
	('40','P40','2021-12-07','2021-12-07','60.0'),
	('50','P40','2021-12-07','2021-12-07','60.0'),
	('40','P40','2021-12-08','2021-12-08','60.0'),
	('50','P40','2021-12-08','2021-12-08','60.0');

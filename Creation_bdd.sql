-- BDD Mestour Alicia et Narayana Viswadevi
--1-Création de la base:
CREATE DATABASE universite_konoha
USE universite_konoha;

-- Table : etudiant
CREATE TABLE etudiant (
    id_etud INT PRIMARY KEY,
    num_etud INT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    date_naissance DATE,
    email VARCHAR(100),
    telephone VARCHAR(20)
);

-- Table : enseignant
CREATE TABLE enseignant (
    id_ens INT PRIMARY KEY,
    matricule VARCHAR(20) UNIQUE NOT NULL,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    tel VARCHAR(20),
    statut VARCHAR(100)
);

-- Table : cours
CREATE TABLE cours (
    id_cours INT PRIMARY KEY,
    matricule VARCHAR(20),
    nom VARCHAR(255) NOT NULL,
    credits INT NOT NULL,
    volume_horaire INT,
    semestre INT(10),
    coeff FLOAT,
    id_ens INT NOT NULL,
    FOREIGN KEY (id_ens) REFERENCES enseignant(id_ens)
		ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table : examen
CREATE TABLE examen (
    id_exam INT PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    nom VARCHAR(100) NOT NULL,
    date DATE NOT NULL,
    salle VARCHAR(50),
    id_cours INT NOT NULL,
    FOREIGN KEY (id_cours) REFERENCES cours(id_cours)
		ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table d'association : s'inscrire
CREATE TABLE s_inscrire (
    id_etud INT,
    id_cours INT,
    date_inscription DATE,
    statut VARCHAR(50),
    PRIMARY KEY (id_etud, id_cours),
    FOREIGN KEY (id_etud) REFERENCES etudiant(id_etud)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_cours) REFERENCES cours(id_cours)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table d'association : enseigner
CREATE TABLE enseigner (
    id_ens INT,
    id_cours INT,
    PRIMARY KEY (id_ens, id_cours),
    FOREIGN KEY (id_ens) REFERENCES enseignant(id_ens)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_cours) REFERENCES cours(id_cours)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table d'association : donner_lieu
CREATE TABLE donner_lieu (
    id_cours INT,
    id_exam INT UNIQUE,
    PRIMARY KEY (id_cours, id_exam),
    FOREIGN KEY (id_cours) REFERENCES cours(id_cours)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_exam) REFERENCES examen(id_exam)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table d'association : noter
CREATE TABLE noter (
    id_etud INT,
    id_exam INT,
    valeur DECIMAL(5,2),
    PRIMARY KEY (id_etud, id_exam),
    FOREIGN KEY (id_etud) REFERENCES etudiant(id_etud)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_exam) REFERENCES examen(id_exam)
        ON DELETE CASCADE ON UPDATE CASCADE
);



--2-Remplir la base :
-- 10 enseignants
INSERT INTO Enseignant (id_ens, matricule, nom, prenom, email, tel, statut) VALUES
(01,'ENS01', 'Hatake', 'Kakashi', 'kakashi@konoha.edu', '070100001', 'Chercheur'),
(02,'ENS02', 'Maito', 'Gai', 'gai@konoha.edu', '070100002', 'Enseignant'),
(03,'ENS03', 'Sarutobi', 'Asuma', 'asuma@konoha.edu', '070100003', 'Enseignant'),
(04,'ENS04', 'Kurenai', 'Yuhi', 'kurenai@konoha.edu', '070100004', 'Chercheuse'),
(05,'ENS05', 'Senju', 'Tsunade', 'tsunade@konoha.edu', '070100005', 'Directrice de recherche'),
(06,'ENS06', 'Ogata', 'Jiraiya', 'jiraiya@konoha.edu', '070100006', 'Intervenant'),
(07,'ENS07', 'Yamata', 'Orochimaru', 'orochimaru@konoha.edu', '070100007', 'Chargé de cours'),
(08,'ENS08', 'Umino', 'Iruka', 'iruka@konoha.edu', '070100008', 'Enseignant'),
(09,'ENS09', 'Nakatomi', 'Yamato', 'yamato@konoha.edu', '070100009', 'Intervenant'),
(10,'ENS10', 'Namikaze', 'Minato', 'shikamaru@konoha.edu', '070100010', 'Directeur de recherche'),
(11,'ENS11', 'Inconnu', 'Test', 'test@konoha.edu', '070100011', 'Enseignant');

-- 10 cours
INSERT INTO Cours (id_cours, matricule, nom, credits, volume_horaire, semestre, coeff, id_ens) VALUES
(01, 'C01', 'Ninjutsu de base', 3, 30, 1, 1.0, 1),
(02, 'C02', 'Techniques de clonage', 2, 25, 1, 1.0, 8),
(03, 'C03', 'Taijutsu avancé', 4, 40, 2, 1.2, 2),
(04, 'C04', 'Genjutsu illusoires', 3, 30, 2, 1.1, 4),
(05, 'C05', 'Soins médicaux ninja', 4, 35, 2, 1.3, 5),
(06, 'C06', 'Techniques d’invocation', 3, 25, 3, 1.0, 6),
(07, 'C07', 'Expérimentation génétique', 4, 30, 3, 1.2, 7),
(08, 'C08', 'Combat rapproché', 3, 20, 3, 1.0, 3),
(09, 'C09', 'Contrôle du chakra naturel', 2, 15, 4, 1.0, 9),
(10, 'C10', 'Tactique de mission', 3, 30, 4, 1.2, 10),

(11, 'C11', 'Anglais appliqué au ninja', 2, 20, 1, 1.0, 8),
(12, 'C12', 'Japonais', 2, 20, 1, 1.0, 3),
(13, 'C13', 'Chinois', 2, 20, 2, 1.0, 9),
(14, 'C14', 'Programmation', 4, 40, 2, 1.3, 7),
(15, 'C15', 'Mathématiques pour le combat', 3, 30, 1, 1.1, 10),
(16, 'C16', 'Biologie et anatomie ninja', 3, 30, 2, 1.2, 5),
(17, 'C17', 'Droit et éthique shinobi', 2, 20, 1, 1.0, 6),
(18, 'C18', 'Physique des éléments', 3, 30, 3, 1.2, 1),
(19, 'C19', 'Chimie des potions et onguents', 3, 25, 3, 1.1, 5),
(20, 'C20', 'Histoire des villages ninja', 2, 20, 4, 1.0, 10);

-- 30 étudiants
INSERT INTO Etudiant (id_etud, num_etud, nom, prenom, date_naissance, email, telephone) VALUES
(001, 20250001, 'Uzumaki', 'Naruto', '2002-10-10', 'naruto@konoha.edu', '070200001'),
(002, 20250002, 'Uchiha', 'Sasuke', '2002-07-23', 'sasuke@konoha.edu', '070200002'),
(003, 20250003, 'Haruno', 'Sakura', '2002-03-28', 'sakura@konoha.edu', '070200003'),
(004, 20250004, 'Nara', 'Shikamaru', '2002-09-22', 'shikamaru@konoha.edu', '070200004'),
(005, 20250005, 'Akimichi', 'Choji', '2002-05-01', 'choji@konoha.edu', '070200005'),
(006, 20250006, 'Hyuuga', 'Hinata', '2002-12-27', 'hinata@konoha.edu', '070200006'),
(007, 20250007, 'Inuzuka', 'Kiba', '2002-07-07', 'kiba@konoha.edu', '070200007'),
(008, 20250008, 'Aburame', 'Shino', '2002-01-23', 'shino@konoha.edu', '070200008'),
(009, 20250009, 'Yamanaka', 'Ino', '2002-09-23', 'ino@konoha.edu', '070200009'),
(010, 20250010, 'Rock', 'Lee', '2002-11-27', 'lee@konoha.edu', '070200010'),
(011, 20250011, 'Misaki', 'Tenten', '2002-03-09', 'tenten@konoha.edu', '070200011'),
(012, 20250012, 'Subaku', 'Gaara', '2002-01-19', 'gaara@suna.edu', '070200012'),
(013, 20250013, 'Subaku', 'Temari', '2000-08-23', 'temari@suna.edu', '070200013'),
(014, 20250014, 'Subaku', 'Kankuro', '2000-05-15', 'kankuro@suna.edu', '070200014'),
(015, 20250015, 'Yamanaka', 'Sai', '2002-04-01', 'sai@konoha.edu', '070200015'),
(016, 20250016, 'Kazamatsuri', 'Moegi', '2002-06-20', 'moegi@konoha.edu', '070200016'),
(017, 20250017, 'Sarutobi', 'Konohamaru', '2002-12-30', 'konohamaru@konoha.edu', '070200017'),
(018, 20250018, 'Hyuuga', 'Hanabi', '2002-03-27', 'hanabi@konoha.edu', '070200018'),
(019, 20250019, 'Uzumaki', 'Karin', '2001-09-15', 'karin@konoha.edu', '070200019'),
(020, 20250020, 'Hozuki', 'Suigetsu', '2001-02-02', 'suigetsu@konoha.edu', '070200020'),
(021, 20250021, 'Yakushi', 'Kabuto', '1999-04-10', 'kabuto@konoha.edu', '070200021'),
(022, 20250022, 'Iwa', 'Deidara', '1998-05-05', 'deidara@iwa.edu', '070200022'),
(023, 20250023, 'Suna', 'Sasori', '1998-11-08', 'sasori@suna.edu', '070200023'),
(024, 20250024, 'Uchiha', 'Itachi', '1997-06-09', 'itachi@konoha.edu', '070200024'),
(025, 20250025, 'Ame', 'Nagato', '1997-01-01', 'nagato@ame.edu', '070200025'),
(026, 20250026, 'Ame', 'Konan', '1997-02-20', 'konan@ame.edu', '070200026'),
(027, 20250027, 'Ame', 'Pain', '1997-03-03', 'pain@ame.edu', '070200027'),
(028, 20250028, 'Hoshigaki', 'Kisame', '1996-07-05', 'kisame@kiri.edu', '070200028'),
(029, 20250029, 'Jashin', 'Hidan', '1997-09-11', 'hidan@jash.edu', '070200029'),
(030, 20250030, 'Taki', 'Kakuzu', '1995-10-09', 'kakuzu@taki.edu', '070200030');


-- 5 examens
INSERT INTO Examen (id_exam,type, nom, date, salle, id_cours) VALUES
(01,'Partiel', 'Examen de Ninjutsu', '2025-03-15', 'Salle 101', 1),
(02,'Examen final', 'Examen de Taijutsu avancé', '2025-06-25', 'Salle 203', 3),
(03,'Contrôle', 'Test de Genjutsu', '2025-04-10', 'Salle 205', 4),
(04,'Partiel', 'Soins médicaux ninja', '2025-05-12', 'Salle 301', 5),
(05,'Final', 'Tactique et stratégie shinobi', '2025-06-30', 'Salle 404', 10);


-- les notes des 5 examen, pour 27 étudiants
INSERT INTO noter (id_etud, id_exam, valeur) VALUES
(1, 1, 14.5),(1, 2, 16.0),(1, 3, 15.5),(1, 4, 13.0),(1, 5, 17.0),
(2, 1, 12.0),(2, 2, 14.5),(2, 3, 16.0),(2, 4, 15.0),(2, 5, 14.0),
(3, 1, 18.0),(3, 2, 17.5),(3, 3, 16.0),(3, 4, 15.0),(3, 5, 18.0),
(4, 1, 10.0),(4, 2, 11.5),(4, 3, 12.0),(4, 4, 13.0),(4, 5, 12.5),
(5, 1, 15.0),(5, 2, 16.0),(5, 3, 15.5),(5, 4, 14.0),(5, 5, 16.0),

(6, 1, 13.5),(6, 2, 14.0),(6, 3, 13.0),(6, 4, 12.5),(6, 5, 14.0),
(7, 1, 7.5),(7, 2, 17.0),(7, 3, 15.5),(7, 4, 16.0),(7, 5, 17.0),
(8, 1, 12.0),(8, 2, 13.5),(8, 3, 14.0),(8, 4, 13.0),(8, 5, 12.5),
(9, 1, 14.0),(9, 2, 15.0),(9, 3, 14.5),(9, 4, 15.0),(9, 5, 16.0),
(10, 1, 16.0),(10, 2, 17.0),(10, 3, 18.0),(10, 4, 16.5),(10, 5, 17.5),

(11, 1, 13.0),(11, 2, 14.5),(11, 3, 15.0),(11, 4, 14.0),(11, 5, 16.0),
(12, 1, 11.5),(12, 2, 12.0),(12, 3, 13.0),(12, 4, 12.5),(12, 5, 13.0),
(13, 1, 14.0),(13, 2, 15.5),(13, 3, 16.0),(13, 4, 14.5),(13, 5, 15.0),
(14, 1, 12.0),(14, 2, 13.0),(14, 3, 12.5),(14, 4, 13.5),(14, 5, 14.0),
(15, 1, 15.0),(15, 2, 16.0),(15, 3, 15.5),(15, 4, 16.0),(15, 5, 17.0),

(16, 1, 9.5),(16, 2, 14.0),(16, 3, 13.0),(16, 4, 14.5),(16, 5, 15.0),
(17, 1, 14.0),(17, 2, 15.0),(17, 3, 16.0),(17, 4, 15.5),(17, 5, 16.0),
(18, 1, 12.5),(18, 2, 13.0),(18, 3, 12.0),(18, 4, 13.5),(18, 5, 14.0),
(19, 1, 15.0),(19, 2, 16.0),(19, 3, 15.5),(19, 4, 16.0),(19, 5, 17.0),
(20, 1, 8.0),(20, 2, 14.0),(20, 3, 13.5),(20, 4, 14.5),(20, 5, 15.0),

(21, 1, 12.0),(21, 2, 13.5),(21, 3, 14.0),(21, 4, 13.0),(21, 5, 14.5),
(22, 1, 11.0),(22, 2, 12.5),(22, 3, 13.0),(22, 4, 12.0),(22, 5, 13.5),
(23, 1, 14.0),(23, 2, 15.0),(23, 3, 14.5),(23, 4, 15.0),(23, 5, 16.0),
(24, 1, 13.5),(24, 2, 14.0),(24, 3, 13.0),(24, 4, 14.5),(24, 5, 15.0),
(25, 1, 12.5),(25, 2, 13.0),(25, 3, 12.0),(25, 4, 13.5),(25, 5, 14.0),

(26, 1, 15.0),(26, 2, 16.0),(26, 3, 15.5),(26, 4, 16.0),(26, 5, 17.0),
(27, 1, 13.0),(27, 2, 14.0),(27, 3, 13.5),(27, 4, 14.5),(27, 5, 15.0);


-- enseigner 
INSERT INTO enseigner (id_ens, id_cours) VALUES
(1, 1), (1, 18),
(2, 3),
(3, 8), (3, 12),
(4, 4),
(6, 6), (6, 17),
(7, 7), (7, 14),
(8, 2), (8, 11),
(10, 10), (10, 15), (10, 20);

-- donner lieu
INSERT INTO donner_lieu (id_cours, id_exam) VALUES
(1, 1),
(3, 2),
(4, 3),
(5, 4),
(10, 5);


-- s'inscrire
INSERT INTO s_inscrire (id_etud, id_cours, date_inscription, statut) VALUES
(1, 1, '2025-01-10', 'valide'),
(1, 3, '2025-01-12', 'valide'),
(1, 10, '2025-01-15', 'valide'),
(1, 15, '2025-01-20', 'valide'),
(2, 1, '2025-01-11', 'valide'),
(2, 4, '2025-02-05', 'valide'),
(3, 1, '2025-01-07', 'valide'),
(3, 18, '2025-01-08', 'valide'),
(4, 10, '2025-03-12', 'valide'),
(5, 5, '2025-03-15', 'valide'),
(6, 1, '2025-02-01', 'valide'),
(6, 12, '2025-02-15', 'valide'),
(6, 11, '2025-03-03', 'valide'),
(7, 8, '2025-02-20', 'valide'),
(8, 13, '2025-04-10', 'valide'),
(9, 11, '2025-05-01', 'valide'),
(9, 12, '2025-05-05', 'valide'),
(9, 13, '2025-06-01', 'valide'),
(10, 3, '2025-01-10', 'valide'),
(10, 7, '2025-01-15', 'valide'),
(13, 4, '2025-02-18', 'valide'),
(12, 20, '2025-03-01', 'valide'),
(12, 15, '2025-03-05', 'valide'),
(14, 1, '2025-04-02', 'annule'),
(14, 3, '2025-04-15', 'annule'),
(16, 8, '2025-05-20', 'supprime'),
(16, 11, '2025-05-21', 'annule');



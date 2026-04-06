-- ============================
-- 1. Afficher les étudiants qui n’ont pas encore passé d’examens.
-- ============================
SELECT e.*
FROM etudiant e
LEFT JOIN noter n ON e.id_etud = n.id_etud
WHERE n.id_exam IS NULL;

-- ============================
-- 2. Calculer le nombre total d’étudiants inscrits à la plateforme.
-- ============================
SELECT COUNT(*) AS total_etudiants
FROM etudiant;

-- ============================
-- 3. Trouver les étudiants ayant amélioré leurs notes entre deux semestres consécutifs.
-- ============================
SELECT DISTINCT n1.id_etud
FROM noter n1
JOIN examen ex1 ON n1.id_exam = ex1.id_exam
JOIN noter n2 ON n2.id_etud = n1.id_etud
JOIN examen ex2 ON n2.id_exam = ex2.id_exam
WHERE ex2.date > ex1.date
  AND n2.valeur > n1.valeur;
  
-- AUTRES--
SELECT DISTINCT 
    e.id_etud,
    e.nom,
    e.prenom
FROM noter n1
JOIN examen ex1 ON n1.id_exam = ex1.id_exam
JOIN noter n2 ON n2.id_etud = n1.id_etud
JOIN examen ex2 ON n2.id_exam = ex2.id_exam
JOIN etudiant e ON e.id_etud = n1.id_etud
WHERE ex2.date > ex1.date
  AND n2.valeur > n1.valeur;


-- ============================
-- 4. Obtenir la moyenne des notes pour chaque cours.
-- ============================
SELECT c.nom, AVG(n.valeur) AS moyenne_cours
FROM cours c
JOIN examen ex ON c.id_cours = ex.id_cours
JOIN noter n ON ex.id_exam = n.id_exam
GROUP BY c.id_cours;

-- décimal plus court
SELECT 
    c.nom, 
    ROUND(AVG(n.valeur), 2) AS moyenne_cours
FROM cours c
JOIN examen ex ON c.id_cours = ex.id_cours
JOIN noter n ON ex.id_exam = n.id_exam
GROUP BY c.id_cours;


-- ============================
-- 5. Afficher les enseignants qui encadrent des examens (avec nom de l’examen).
-- Pas obligé de mettre as examen
-- ============================
SELECT ens.nom, ens.prenom, ex.nom AS examen
FROM enseignant ens
JOIN cours c ON ens.id_ens = c.id_ens
JOIN examen ex ON ex.id_cours = c.id_cours;

-- ============================
-- 6. Afficher le nombre total d’examens organisés pour chaque cours.
-- ============================
SELECT c.nom, COUNT(ex.id_exam) AS nb_examens
FROM cours c
LEFT JOIN examen ex ON c.id_cours = ex.id_cours
GROUP BY c.id_cours;

-- ============================
-- 7. Répartition des étudiants par tranche d’âge
-- ============================
SELECT 
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, date_naissance, CURDATE()) < 20 THEN 'Moins de 20 ans'
        WHEN TIMESTAMPDIFF(YEAR, date_naissance, CURDATE()) BETWEEN 20 AND 30 THEN '20 - 30 ans'
        ELSE 'Plus de 30 ans'
    END AS tranche_age,
    COUNT(*) AS total
FROM etudiant
GROUP BY tranche_age;

-- ============================
-- 8. Étudiants ayant une moyenne générale > 15
-- ============================
SELECT e.id_etud, e.nom, e.prenom, AVG(n.valeur) AS moyenne
FROM etudiant e
JOIN noter n ON e.id_etud = n.id_etud
GROUP BY e.id_etud
HAVING moyenne > 15;

-- ============================
-- 9. Enseignants ne dispensant aucun cours.
-- ============================
SELECT *
FROM enseignant ens
LEFT JOIN cours c ON ens.id_ens = c.id_ens
WHERE c.id_cours IS NULL;

-- ============================
-- 10. Cours dispensés par un enseignant donné (ex : nom = 'Hatake')
-- ============================
SELECT c.*
FROM cours c
JOIN enseignant ens ON c.id_ens = ens.id_ens
WHERE ens.nom = 'Hatake';

-- ============================
-- 11. Nombre total d’inscriptions par cours (ordre décroissant)
-- ============================
SELECT c.nom, COUNT(s.id_etud) AS total_inscriptions
FROM cours c
LEFT JOIN s_inscrire s ON c.id_cours = s.id_cours
GROUP BY c.id_cours
ORDER BY total_inscriptions DESC;

-- ============================
-- 12. Étudiants ayant obtenu la meilleure note pour chaque examen.
-- ============================
SELECT ex.id_exam, ex.nom, e.id_etud, e.nom, e.prenom, n.valeur
FROM examen ex
JOIN noter n ON ex.id_exam = n.id_exam
JOIN etudiant e ON e.id_etud = n.id_etud
WHERE n.valeur = (
    SELECT MAX(valeur)
    FROM noter
    WHERE id_exam = ex.id_exam
);

-- ============================
-- 13. Inscription après une date donnée
-- ============================
SELECT *
FROM s_inscrire
WHERE date_inscription > '2024-01-01';

-- ============================
-- 14. Nombre moyen d’inscriptions par étudiant
-- ============================
SELECT AVG(cnt) AS moyenne
FROM (
    SELECT COUNT(*) AS cnt
    FROM s_inscrire
    GROUP BY id_etud
) AS sous_table;

-- ============================
-- 15. Inscriptions d’un étudiant donné (nom + prénom)
-- ============================
SELECT s.*
FROM s_inscrire s
JOIN etudiant e ON s.id_etud = e.id_etud
WHERE e.nom = 'Uzumaki' AND e.prenom = 'Naruto';

-- ============================
-- 16. Étudiants inscrits à un cours spécifique (ex : 'Japonais')
-- ============================
SELECT e.*
FROM etudiant e
JOIN s_inscrire s ON e.id_etud = s.id_etud
JOIN cours c ON c.id_cours = s.id_cours
WHERE c.nom = 'Japonais';

-- ============================
-- 17. Evolution des inscriptions par mois d’une année donnée
-- ============================
SELECT MONTH(date_inscription) AS mois, COUNT(*) AS total
FROM s_inscrire
WHERE YEAR(date_inscription) = 2025
GROUP BY mois;

-- ============================
-- 18. Moyenne générale par étudiant et par cours
-- ============================
SELECT e.id_etud, e.nom, e.prenom, c.nom AS cours, AVG(n.valeur) AS moyenne
FROM etudiant e
JOIN s_inscrire s ON e.id_etud = s.id_etud
JOIN cours c ON c.id_cours = s.id_cours
JOIN examen ex ON ex.id_cours = c.id_cours
JOIN noter n ON n.id_exam = ex.id_exam AND n.id_etud = e.id_etud
GROUP BY e.id_etud, c.id_cours;

-- décimal 2 chifre apprés 
SELECT 
    e.id_etud, 
    e.nom, 
    e.prenom, 
    c.nom AS cours, 
    ROUND(AVG(n.valeur), 2) AS moyenne
FROM etudiant e
JOIN s_inscrire s ON e.id_etud = s.id_etud
JOIN cours c ON c.id_cours = s.id_cours
JOIN examen ex ON ex.id_cours = c.id_cours
JOIN noter n ON n.id_exam = ex.id_exam AND n.id_etud = e.id_etud
GROUP BY e.id_etud, c.id_cours;


-- ============================
-- 19. Étudiants inscrits à plus de 3 cours
-- ============================
SELECT e.*, COUNT(s.id_cours) AS nb_cours
FROM etudiant e
JOIN s_inscrire s ON e.id_etud = s.id_etud
GROUP BY e.id_etud
HAVING nb_cours > 3;

-- ============================
-- 20. Liste des enseignants et cours dispensés
-- ============================
SELECT ens.nom, ens.prenom, c.nom AS cours
FROM enseignant ens
LEFT JOIN cours c ON ens.id_ens = c.id_ens;

-- ============================
-- 21. Inscriptions annulées / supprimées 
-- (si champs « statut » = 'annulé')
-- ============================
SELECT *
FROM s_inscrire
WHERE statut = 'annulé';

-- ============================
-- 22. Enseignant qui encadre le plus grand nombre de cours
-- ============================
SELECT ens.nom, ens.prenom, COUNT(c.id_cours) AS nb_cours
FROM enseignant ens
JOIN cours c ON ens.id_ens = c.id_ens
GROUP BY ens.id_ens
ORDER BY nb_cours DESC
LIMIT 1;

-- ============================
-- 23. Liste complète des étudiants
-- ============================
SELECT nom, prenom, date_naissance, email
FROM etudiant;

-- ============================
-- 24. Liste des cours et total des inscriptions
-- ============================
SELECT c.nom, COUNT(s.id_etud) AS total_inscriptions
FROM cours c
LEFT JOIN s_inscrire s ON c.id_cours = s.id_cours
GROUP BY c.id_cours;

-- ============================
-- 25. Cours avec plus de 2 étudiants inscrits
-- ============================
SELECT c.nom
FROM cours c
JOIN s_inscrire s ON c.id_cours = s.id_cours
GROUP BY c.id_cours
HAVING COUNT(*) > 2;

-- ============================
-- 26. Cours ayant le taux de réussite le plus élevé (note ≥ 10)
-- ============================
SELECT c.nom,
    SUM(CASE WHEN n.valeur >= 10 THEN 1 ELSE 0 END) AS nb_reussites
FROM cours c
JOIN examen ex ON c.id_cours = ex.id_cours
JOIN noter n ON n.id_exam = ex.id_exam
GROUP BY c.id_cours
ORDER BY nb_reussites DESC;

-- ============================
-- 27. Nombre d’inscriptions annulées par mois
-- ============================
SELECT MONTH(date_inscription) AS mois, COUNT(*) AS total
FROM s_inscrire
WHERE statut = 'annulé'
GROUP BY mois;

-- ============================
-- 28. Étudiants inscrits à tous les cours d’un enseignant donné
-- ============================
SELECT e.id_etud, e.nom, e.prenom
FROM etudiant e
WHERE NOT EXISTS (
    SELECT c.id_cours
    FROM cours c
    WHERE c.id_ens = 1
    AND NOT EXISTS (
        SELECT *
        FROM s_inscrire s
        WHERE s.id_etud = e.id_etud
        AND s.id_cours = c.id_cours)
);

-- ============================
-- 29. Étudiants + leurs cours + leurs enseignants
-- ============================
SELECT e.nom, e.prenom, c.nom AS cours, ens.nom AS enseignant
FROM etudiant e
JOIN s_inscrire s ON e.id_etud = s.id_etud
JOIN cours c ON c.id_cours = s.id_cours
JOIN enseignant ens ON ens.id_ens = c.id_ens;

-- ============================
-- 30. Cours avec moyenne < 15
-- ============================
SELECT c.nom, AVG(n.valeur) AS moyenne
FROM cours c
JOIN examen ex ON c.id_cours = ex.id_cours
JOIN noter n ON n.id_exam = ex.id_exam
GROUP BY c.id_cours
HAVING moyenne < 15;

-- ============================
-- 31. Date d’inscription pour chaque étudiant et chaque cours
-- ============================
SELECT e.nom, e.prenom, c.nom AS cours, s.date_inscription
FROM s_inscrire s
JOIN etudiant e ON s.id_etud = e.id_etud
JOIN cours c ON c.id_cours = s.id_cours;

-- ============================
-- 32. Étudiants ayant passé un examen spécifique
-- ============================
SELECT e.*
FROM etudiant e
JOIN noter n ON e.id_etud = n.id_etud
JOIN examen ex ON ex.id_exam = n.id_exam
WHERE ex.nom = 'Examen de Ninjutsu';

-- ============================
-- 33. Notes obtenues par les étudiants pour un cours donné
-- ============================
SELECT e.nom, e.prenom, n.valeur
FROM etudiant e
JOIN noter n ON e.id_etud = n.id_etud
JOIN examen ex ON n.id_exam = ex.id_exam
JOIN cours c ON c.id_cours = ex.id_cours
WHERE c.nom = 'Taijutsu avancé';

-- ============================
-- 34. Examens programmés pour un cours donné
-- ============================
SELECT ex.*
FROM examen ex
JOIN cours c ON c.id_cours = ex.id_cours
WHERE c.nom = 'Examen de Ninjutsu';

-- ============================
-- 35. Liste des cours + enseignant responsable
-- ============================
SELECT c.nom AS cours, ens.nom AS enseignant
FROM cours c
JOIN enseignant ens ON c.id_ens = ens.id_ens;

-- ============================
-- 36. Nombre d’étudiants inscrits dans les cours de chaque enseignant
-- ============================
SELECT ens.nom, ens.prenom, COUNT(s.id_etud) AS total_etudiants
FROM enseignant ens
JOIN cours c ON ens.id_ens = c.id_ens
JOIN s_inscrire s ON s.id_cours = c.id_cours
GROUP BY ens.id_ens;

-- ============================
-- 37. Cours sans inscriptions
-- ============================
SELECT c.*
FROM cours c
LEFT JOIN s_inscrire s ON c.id_cours = s.id_cours
WHERE s.id_etud IS NULL;

-- ============================
-- 38. Performance moyenne des étudiants par enseignant
-- ============================
SELECT ens.nom, ens.prenom, AVG(n.valeur) AS moyenne
FROM enseignant ens
JOIN cours c ON ens.id_ens = c.id_ens
JOIN examen ex ON ex.id_cours = c.id_cours
JOIN noter n ON n.id_exam = ex.id_exam
GROUP BY ens.id_ens;

-- ============================
-- 39. Étudiants ayant échoué à un examen (note < 10)
-- ============================
SELECT e.*, n.valeur
FROM etudiant e
JOIN noter n ON e.id_etud = n.id_etud
JOIN examen ex ON ex.id_exam = n.id_exam
WHERE ex.nom = 'Examen de Ninjutsu'
  AND n.valeur < 10;

-- ============================
-- 40. Nombre de cours dispensés par chaque enseignant
-- ============================
SELECT ens.nom, ens.prenom, COUNT(c.id_cours) AS nb_cours
FROM enseignant ens
LEFT JOIN cours c ON ens.id_ens = c.id_ens
GROUP BY ens.id_ens;

-- ============================
-- 41. Cours dispensés par un enseignant donné
-- ============================
SELECT c.*
FROM cours c
JOIN enseignant ens ON ens.id_ens = c.id_ens
WHERE ens.nom = 'Kakashi';
 

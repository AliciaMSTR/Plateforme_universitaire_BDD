# **Plateforme universitaire**

Ce projet consiste en la conception et l’implémentation d’une base de données relationnelle pour la gestion d’une plateforme universitaire.

## **1- Objectifs du projet :**
 - Centraliser les informations liées aux étudiants, enseignants, cours, examens, inscriptions et notes.
 -  Modéliser le domaine avec la méthode Entité-Association (MCD/ER), puis le transformer en Modèle Logique de Données (MLD).
 - Implémenter la base sous forme de tables SQL, avec clés primaires, clés étrangères et contraintes d’intégrité. 
 - Illustrer l’exploitation de la base via des requêtes SQL de gestion et d’analyse (indicateurs de performance académique, statistiques, etc.).

## **2-Technologies utilisées**
- SGBD : MySQL (via XAMPP / phpMyAdmin).
- Langage : SQL pour la création des tables, l’insertion des données et les requêtes.

## **3-Modélisation**

### A- Entités principales

- **Etudiant** : informations sur les étudiants inscrits (identifiant, numéro, nom, prénom, date de naissance, email, téléphone).
- **Enseignant** : informations sur les enseignants (identifiant, matricule, nom, prénom, email, téléphone, statut).
- **Cours** : description des enseignements (identifiant, matricule, nom, crédits, volume horaire, semestre, coefficient, enseignant responsable).
- **Examen** : évaluations organisées pour un cours (identifiant, type, nom, date, salle, cours associé).

### B- Relations

- **S’inscrire** : relation N–N entre étudiants et cours, avec date d’inscription et statut.
- **Enseigner** : relation N–N entre enseignants et cours (co-enseignement possible).
- **Donner_lieu** : lien entre un cours et ses examens (un cours peut donner lieu à plusieurs examens).
- **Noter** : relation N–N entre étudiants et examens, avec la valeur de la note.


##  4-Documentation
**Le document doc/BDD_Rapport_MESTOUR_NARAYANA.pdf présente :**

 - L’introduction du projet et le contexte.
 - Le diagramme Entité-Relation (MCD).
 - Le Modèle Logique de Données (MLD).
 - La description détaillée des entités, relations et choix de modélisation.
 - Les scripts SQL de création, d’insertion et les requêtes.

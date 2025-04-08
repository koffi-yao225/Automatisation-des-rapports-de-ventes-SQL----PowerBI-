# Automatisation_des_ventes_SQL_&_PowerBI

📌 # Contexte

Ce projet a été réalisé dans le cadre de l’apprentissage de l'automatisation des rapports d’analyse de données. L’objectif était de créer un rapport de ventes interactif et automatisé, à partir d'une base de données d’entreprise de vente opérant dans plusieurs pays.

Le fichier SQL contenant le schema de la base et les données est disponible sur mon espace mais aussi sur le lien https://github.com/lerocha/chinook-database si vous utisés des systèmes de gestion de base de données différent de MYSQL.

##🧰 Technologies utilisées
MySQL : pour la gestion de la base de données relationnelle

SQL (views, jointures, filtres) : pour l’extraction, le nettoyage et la structuration des données

Python (pandas + SQLAlchemy) : pour l’automatisation de l’injection de données dans MySQL et aussi la récupération des vues créées dans un CSV

Power BI Desktop : pour la création du tableau de bord interactif

Power BI Service : pour la publication et la planification du rafraîchissement automatique

##🗃 Structure de la base de données
La base contient plusieurs tables :
- Album
- Artist
- Customer
- employee
- genre
- invoice
- invoiceline
- mediatype
- playlist
- playlisttrack
- track

Ces tables sont liées par des clés étrangères, respectant une modélisation pour faciliter l'analyse.

##🧠 Étapes du projet
###1. Préparation de la base de données
Création de la base chinook sur MySQL

insertion des données à partir du script SQL

Automatisation de l’insertion avec un script Python des données fictifs avec pandas + SQLAlchemy (Facultatif)

###2. Création des vues SQL
Requêtes SQL pour préparer les données métiers : chiffre d’affaires par pays, par agent de vente, par cleint, etc.

Création de vues SQL permettant de centraliser les indicateurs clés

###3. Connexion à Power BI Desktop et Conception du rapport interactif
Connexion à MySQL avec le connecteur natif

Chargement des vues SQL comme source de données (Possibilité d'utiliser les vues extraires dans les CSV)

Transformation des données si besoin via Power Query

Création de visuels dynamiques

###5. Publication sur Power BI Service
Publication du rapport finalisé

Configuration du rafraîchissement automatique des données (connecteur + gateway)

📊 Aperçu du tableau de bord

![Visualisation_tableau_de_bord](https://github.com/user-attachments/assets/77e5a8fa-df91-40cf-b61e-b6d10c03a9ce)


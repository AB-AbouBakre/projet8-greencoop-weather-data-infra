# Déploiement AWS réel - Projet 8 GreenAndCoop

## Objectif

Un déploiement AWS minimal a été réalisé afin de valider le passage du pipeline local vers une infrastructure cloud.

L'objectif n'était pas de déployer toute l'architecture de production complète, mais de prouver la faisabilité des composants 
principaux :

- stockage source sur Amazon S3
- base PostgreSQL managée sur Amazon RDS
- connexion sécurisée avec SSL
- gestion des identifiants via AWS Secrets Manager
- préparation des schémas `raw` et `analytics`

## Ressources créées

### Amazon S3

Un bucket S3 a été créé en région Europe Paris `eu-west-3`.

Un fichier météo Weather Underground a été chargé dans le bucket :

- `weather_underground_ichtegem.csv`

Ce bucket représente le stockage source cloud qui remplacerait le dossier local `airbyte_files`.

### Amazon RDS PostgreSQL

Une instance Amazon RDS PostgreSQL a été créée :

- moteur : PostgreSQL
- région : Europe Paris `eu-west-3`
- classe : `db.t4g.micro`
- identifiant : `weather-db`
- endpoint : `weather-db.cl4siq4woehq.eu-west-3.rds.amazonaws.com`

La connexion depuis le poste local a été validée avec SSL :

```text
SSL connection (protocol: TLSv1.3)

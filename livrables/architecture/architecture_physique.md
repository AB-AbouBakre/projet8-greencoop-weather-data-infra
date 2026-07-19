# Architecture physique - Projet 8 GreenAndCoop

## Objectif

L'architecture physique décrit l'environnement technique permettant d'ingérer, stocker, transformer, tester et documenter les données 
météorologiques.

Le projet a été réalisé localement avec Docker, PostgreSQL, Airbyte et DBT. Une architecture cible AWS est proposée pour répondre aux 
contraintes de la DSI.

## Architecture locale réalisée

```text
Poste local
    |
    |-- Docker Desktop
    |
    |-- Conteneur PostgreSQL
    |       |-- base : weather_db
    |       |-- port local : 5433
    |       |-- schéma raw
    |       |-- schéma analytics
    |
    |-- Airbyte local avec abctl
    |       |-- interface : http://localhost:8000
    |       |-- destination PostgreSQL configurée
    |
    |-- DBT Core
            |-- projet : dbt_greencoop
            |-- connexion PostgreSQL
            |-- modèles staging / intermediate / marts
            |-- tests qualité
            |-- documentation DBT
## Complément AWS

Une architecture AWS cible détaillée est disponible dans le fichier :

`livrables/architecture/aws_cible.md`

Cette architecture précise les services proposés pour le passage en production :

- Amazon S3 pour le stockage des fichiers sources
- Airbyte sur AWS pour l'ingestion
- Amazon RDS PostgreSQL pour la base centrale
- DBT sur ECS Fargate pour les transformations
- EventBridge pour la planification
- CloudWatch pour les logs et alertes
- Secrets Manager pour la sécurité des identifiants
- SageMaker pour l'exploitation par les Data Scientists

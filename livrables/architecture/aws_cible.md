# Architecture AWS cible - Projet 8 GreenAndCoop

## Objectif

L'objectif de l'architecture AWS cible est de rendre le pipeline météo exploitable en production.

L'environnement local a permis de valider le fonctionnement technique avec Docker, PostgreSQL, Airbyte et DBT.

L'architecture AWS proposée permettrait de répondre aux besoins suivants :

- héberger PostgreSQL de manière fiable
- automatiser l'ingestion des données météo
- exécuter les transformations DBT de manière planifiée
- superviser les logs et erreurs
- sécuriser les identifiants
- rendre les données accessibles aux Data Scientists

## Schéma cible

```text
Sources météo
    |
    |-- InfoClimat
    |-- Weather Underground
    |-- Fichiers CSV / JSON
    |
    v
Stockage source AWS
    |
    |-- Amazon S3
    |
    v
Airbyte sur AWS
    |
    v
Amazon RDS PostgreSQL
    |
    |-- schéma raw
    |-- schéma analytics
    |
    v
DBT sur AWS
    |
    |-- transformations
    |-- tests qualité
    |-- documentation
    |
    v
Tables analytiques
    |
    |-- analytics.dim_weather_stations
    |-- analytics.fact_weather_observations
    |
    v
Amazon SageMaker / Data Scientists

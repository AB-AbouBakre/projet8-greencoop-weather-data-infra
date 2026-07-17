# Airbyte - Projet 8 GreenAndCoop

## Rôle d'Airbyte

Airbyte est utilisé comme outil d'ingestion des données.

Son rôle dans l'architecture est de centraliser les flux provenant de 
plusieurs sources météorologiques vers PostgreSQL, dans le schéma `raw`.

Dans l'architecture cible, Airbyte doit permettre :

- la connexion aux sources de données météo
- la planification des synchronisations
- le chargement automatique dans PostgreSQL
- la surveillance des erreurs d'ingestion

## Configuration locale

Airbyte a été installé localement avec `abctl`.

Commande de vérification :

```bash
abctl local status

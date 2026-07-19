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
## Validation avec une source HTTPS GitHub

Après le blocage rencontré avec les fichiers locaux, une nouvelle 
tentative a été réalisée avec une source accessible en HTTPS public via 
GitHub.

Source utilisée :

- `airbyte_files/weather_underground_ichtegem.csv`

Cette source a été exposée via l'URL raw GitHub du dépôt projet.

Une source Airbyte de type `File` a été créée avec les paramètres suivants 
:

- nom de la source : `wu_ichtegem_csv_github`
- format : `csv`
- storage provider : `HTTPS: Public Web`
- dataset name : `wu_ichtegem_csv`

Une connexion Airbyte a ensuite été créée :

```text
wu_ichtegem_csv_github → greencoop_postgres_raw

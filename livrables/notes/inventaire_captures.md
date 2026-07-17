# Inventaire des captures - Projet 8

## PostgreSQL

- Conteneur Docker PostgreSQL actif
- Tables du schéma `raw`
- Comptage des lignes dans les tables RAW
- Tables du schéma `analytics`

## Airbyte

- Airbyte accessible sur `http://localhost:8000`
- Destination PostgreSQL configurée
- Test de connexion destination réussi
- Éventuellement : tentative de source File / limite rencontrée en local

## DBT

- `dbt debug` : connexion PostgreSQL réussie
- `dbt run` : pipeline exécuté avec succès
- `dbt test` : 18 tests réussis
- DBT Docs : structure du projet
- DBT Docs : sources RAW
- DBT Docs : lineage graph corrigé
- DBT Docs : modèle `fact_weather_observations`
- DBT Docs : modèle `dim_weather_stations`

## Résultat final

- `dim_weather_stations` : 6 stations
- `fact_weather_observations` : 1719 observations

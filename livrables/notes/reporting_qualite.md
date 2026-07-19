# Reporting qualité - Projet 8 GreenAndCoop

## Objectif

Ce document synthétise les contrôles qualité réalisés sur le pipeline 
météo.

L'objectif est de vérifier que les données intégrées, transformées et 
exposées aux Data Scientists sont cohérentes, complètes et exploitables.

## Volumes de données

### Sources RAW PostgreSQL

- `raw.infoclimat_raw` : 1 ligne JSON brute
- `raw.weather_underground_ichtegem_raw` : 289 lignes
- `raw.weather_underground_la_madeleine_raw` : 289 lignes
- `raw.wu_ichtegem_csv` : 288 lignes chargées via Airbyte

### Tables analytiques

- `analytics.dim_weather_stations` : 6 stations météo
- `analytics.fact_weather_observations` : 1719 observations météo 
standardisées

## Modèles DBT contrôlés

### Staging

- `stg_infoclimat_stations`
- `stg_infoclimat_hourly`
- `stg_wu_ichtegem`
- `stg_wu_la_madeleine`

### Intermediate

- `int_weather_observations_standardized`

### Marts

- `dim_weather_stations`
- `fact_weather_observations`

## Tests DBT réalisés

Les tests DBT couvrent :

- la non-nullité des champs obligatoires
- l'unicité des identifiants
- les relations entre faits et dimensions
- les valeurs acceptées pour les sources
- la plage de validité de l'humidité entre 0 et 100 %

Commande exécutée :

```text
dbt test

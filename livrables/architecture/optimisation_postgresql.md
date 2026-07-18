# Optimisation PostgreSQL - Projet 8 GreenAndCoop

## Objectif

L'objectif de cette optimisation est d'améliorer les performances d'accès 
aux tables analytiques utilisées par les Data Scientists.

Les requêtes les plus fréquentes portent probablement sur :

- une station météo donnée
- une période donnée
- une station météo sur une période donnée

## Tables concernées

Les optimisations ont été appliquées sur les tables finales du schéma 
`analytics` :

- `analytics.dim_weather_stations`
- `analytics.fact_weather_observations`

## Index créés

### Table dim_weather_stations

Un index unique a été créé sur :

- `station_id`

Objectif :

- garantir l'unicité logique des stations
- accélérer les jointures entre la dimension station et la table de faits

### Table fact_weather_observations

Trois index ont été créés :

- `station_id`
- `measured_at_utc`
- `station_id, measured_at_utc`

Objectifs :

- accélérer les filtres par station
- accélérer les filtres par période
- accélérer les requêtes combinant station et période

## Implémentation avec DBT

Les index ont été déclarés directement dans les configurations des modèles 
DBT.

Modèle concerné :

- `dim_weather_stations.sql`
- `fact_weather_observations.sql`

Cette approche permet de recréer automatiquement les index lors de la 
reconstruction des tables DBT.

## Vérification PostgreSQL

Les index ont été vérifiés avec la requête :

```sql
SELECT
    schemaname,
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'analytics'
  AND tablename IN ('dim_weather_stations', 'fact_weather_observations')
ORDER BY tablename, indexname;
```

Résultat obtenu :

- 1 index unique sur `analytics.dim_weather_stations(station_id)`
- 1 index sur `analytics.fact_weather_observations(station_id)`
- 1 index sur `analytics.fact_weather_observations(measured_at_utc)`
- 1 index composite sur `analytics.fact_weather_observations(station_id, 
measured_at_utc)`

## Justification

Ces index sont adaptés au modèle analytique car la table de faits contient 
les observations météo horodatées.

Les Data Scientists peuvent ainsi interroger efficacement :

- toutes les observations d'une station
- toutes les observations d'une période
- les observations d'une station sur une période précise

Le nombre d'index reste limité afin d'éviter de ralentir inutilement les 
écritures ou les reconstructions DBT.

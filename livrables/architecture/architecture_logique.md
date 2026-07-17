# Architecture logique - Projet 8 GreenAndCoop

## Objectif

L'objectif est de centraliser plusieurs sources météorologiques hétérogènes dans PostgreSQL, puis de les transformer avec DBT afin de 
fournir des données propres, standardisées et exploitables par les Data Scientists.

## Sources de données

Trois sources brutes sont chargées dans PostgreSQL :

- `raw.infoclimat_raw`
- `raw.weather_underground_ichtegem_raw`
- `raw.weather_underground_la_madeleine_raw`

## Schéma logique

```text
Sources météo
    ↓
PostgreSQL - schéma raw
    ↓
DBT staging
    ↓
DBT intermediate
    ↓
DBT marts
    ↓
Tables analytiques pour les Data Scientists

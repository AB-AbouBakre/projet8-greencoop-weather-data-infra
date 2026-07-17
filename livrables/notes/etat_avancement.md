# État d'avancement - Projet 8 GreenAndCoop
## Environnement local
- Docker fonctionne.
- PostgreSQL fonctionne dans Docker.
- Airbyte fonctionne localement avec abctl.
- DBT Core est installé avec le plugin PostgreSQL.
## PostgreSQL
Base : `weather_db`  
Utilisateur : `greencoop`  
Port local : `5433`
Schémas :
- `raw` : données brutes
- `analytics` : données transformées par DBT
Tables RAW :
- `raw.infoclimat_raw`
- `raw.weather_underground_ichtegem_raw`
- `raw.weather_underground_la_madeleine_raw`
## DBT
Projet : `dbt_greencoop`
Couches :
- `staging`
- `intermediate`
- `marts`
Modèles staging :
- `stg_infoclimat_stations`
- `stg_infoclimat_hourly`
- `stg_wu_ichtegem`
- `stg_wu_la_madeleine`
Modèle intermediate :
- `int_weather_observations_standardized`
Modèles marts :
- `dim_weather_stations`
- `fact_weather_observations`
## Résultats
- `dim_weather_stations` : 6 stations météo
- `fact_weather_observations` : 1719 observations météo standardisées
## Tests qualité
Commande :
dbt test
Résultat :
PASS=18  
WARN=0  
ERROR=0  
TOTAL=18
Tests réalisés :
- non-nullité
- unicité
- relations entre faits et dimensions
- valeurs acceptées pour les sources
- humidité entre 0 et 100 %
## Documentation DBT
Documentation générée avec :
dbt docs generate  
dbt docs serve
Captures disponibles :
- structure du projet DBT
- sources RAW
- couches staging, intermediate et marts
- lineage graph corrigé

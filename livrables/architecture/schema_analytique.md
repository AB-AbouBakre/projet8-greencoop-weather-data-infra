# Schéma analytique - Projet 8 GreenAndCoop

## Objectif

Le schéma analytique permet de fournir aux Data Scientists une base météo propre, unifiée et exploitable pour les modèles de prévision de 
consommation électrique.

Le modèle final suit une logique de schéma en étoile :

- une table de faits contenant les observations météo
- une dimension contenant les stations météo

## Tables finales

### Dimension : dim_weather_stations

Cette table décrit les stations météorologiques.

Colonnes principales :

- `station_id` : identifiant unique de la station
- `station_name` : nom de la station
- `latitude` : latitude
- `longitude` : longitude
- `elevation` : altitude
- `station_type` : type de station
- `source_system` : source de données
- `city` : ville
- `hardware` : matériel utilisé
- `software` : logiciel utilisé
- `license_name` : licence de la donnée
- `license_source` : fournisseur de la donnée
- `license_url` : lien vers la licence
- `metadata_url` : lien vers les métadonnées

Contenu :

- 4 stations InfoClimat
- 2 stations Weather Underground
- 6 stations au total

### Table de faits : fact_weather_observations

Cette table contient les mesures météorologiques standardisées.

Colonnes principales :

- `station_id` : identifiant de la station
- `measured_at_utc` : date et heure de mesure
- `source_system` : source de données
- `temperature_c` : température en degrés Celsius
- `pressure_hpa` : pression en hPa
- `humidity_pct` : humidité en pourcentage
- `dewpoint_c` : point de rosée en degrés Celsius
- `visibility_m` : visibilité en mètres
- `wind_speed_kmh` : vitesse moyenne du vent en km/h
- `wind_gust_kmh` : rafales de vent en km/h
- `wind_direction_deg` : direction du vent en degrés
- `wind_direction_text` : direction textuelle du vent
- `rain_1h_mm` : pluie sur 1 heure en mm
- `rain_3h_mm` : pluie sur 3 heures en mm
- `precip_rate_mm` : intensité de précipitation en mm
- `precip_accum_mm` : cumul de précipitation en mm
- `snow_depth_cm` : hauteur de neige au sol en cm
- `cloud_cover_octas` : nébulosité en octats
- `weather_code` : code météo OMM
- `uv_index` : indice UV
- `solar_w_m2` : rayonnement solaire en W/m²

Contenu :

- 1719 observations météo standardisées

## Relation entre les tables

La relation principale est :

```text
dim_weather_stations.station_id
        1 ──────────────── n
fact_weather_observations.station_id

# Logigramme ELT - Projet 8 GreenAndCoop

## Objectif

Le pipeline ELT permet de centraliser, transformer et contrôler les données météorologiques utilisées par les Data Scientists pour la 
prévision de consommation électrique.

## Logigramme général

```text
Sources météorologiques
        |
        |-- InfoClimat JSON
        |-- Weather Underground Ichtegem CSV
        |-- Weather Underground La Madeleine CSV
        |
        v
Ingestion des données
        |
        |-- Airbyte configuré localement
        |-- Chargement RAW dans PostgreSQL
        |
        v
PostgreSQL - schéma raw
        |
        |-- raw.infoclimat_raw
        |-- raw.weather_underground_ichtegem_raw
        |-- raw.weather_underground_la_madeleine_raw
        |
        v
DBT - couche staging
        |
        |-- extraction du JSON InfoClimat
        |-- nettoyage des lignes vides
        |-- conversion des types
        |-- conversion des unités Weather Underground
        |
        v
DBT - couche intermediate
        |
        |-- harmonisation des sources
        |-- union des observations météo
        |-- standardisation des colonnes
        |
        v
DBT - couche marts
        |
        |-- dim_weather_stations
        |-- fact_weather_observations
        |
        v
Tests qualité DBT
        |
        |-- not_null
        |-- unique
        |-- relationships
        |-- accepted_values
        |-- accepted_range
        |
        v
Documentation DBT
        |
        |-- lineage graph
        |-- descriptions des modèles
        |-- tests documentés
        |
        v
Données exploitables par les Data Scientists

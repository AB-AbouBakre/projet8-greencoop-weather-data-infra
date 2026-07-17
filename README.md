# Projet 8 - GreenAndCoop - Infrastructure de données météo

## Contexte

Ce projet s'inscrit dans le cadre du projet Forecast 2.0 de GreenAndCoop, 
fournisseur coopératif d'électricité renouvelable.

L'objectif est de construire une infrastructure de données permettant de 
centraliser, transformer, contrôler et documenter des données 
météorologiques issues de plusieurs sources.

Ces données sont destinées aux Data Scientists afin d'améliorer les 
modèles de prévision de consommation électrique.

## Sources de données

Les données utilisées proviennent de plusieurs sources météo :

- InfoClimat
- Weather Underground - Ichtegem
- Weather Underground - La Madeleine

Les fichiers sources sont chargés dans PostgreSQL dans un schéma `raw`.

## Architecture du pipeline

Le pipeline suit une approche ELT :

```text
Sources météo
    ↓
PostgreSQL - raw
    ↓
DBT staging
    ↓
DBT intermediate
    ↓
DBT marts
    ↓
Tables analytiques

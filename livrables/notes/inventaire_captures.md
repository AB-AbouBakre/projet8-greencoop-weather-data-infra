# Inventaire des captures - Projet 8

Les captures sélectionnées pour le livrable sont rangées dans :

`livrables/screenshots_selection/`

## GitHub

- `00_github_branches_repository.png`  
  Vue du dépôt GitHub avec les branches principales.

## Airbyte

- `01_airbyte_initial_setup_preferences.png`  
  Configuration initiale Airbyte.

- `02_airbyte_connections_overview.png`  
  Vue d'ensemble des connexions Airbyte.

- `03_airbyte_postgres_destination_settings.png`  
  Paramétrage de la destination PostgreSQL.

- `04_airbyte_postgres_destination_created.png`  
  Destination PostgreSQL créée.

- `05_airbyte_destination_sidebar.png`  
  Vue de la destination dans l'interface Airbyte.

- `06_airbyte_file_source_local_url_error.png`  
  Erreur rencontrée avec la source fichier locale.

## DBT Docs

- `07_dbt_docs_database_raw_table.png`  
  Vue d'une table RAW dans DBT Docs.

- `08_dbt_docs_project_sources_and_marts.png`  
  Vue du projet DBT avec sources et marts.

- `09_dbt_docs_raw_sources_overview.png`  
  Vue des sources RAW déclarées.

- `10_dbt_docs_database_analytics_and_raw.png`  
  Vue des schémas `analytics` et `raw`.

- `11_dbt_docs_lineage_corrected.png`  
  Graphe de lineage corrigé : raw → staging → intermediate → marts.

- `12_dbt_docs_project_structure_final.png`  
  Structure finale du projet DBT.

  - `13_airbyte_sync_success_288_records.png`  
  Synchronisation Airbyte réussie avec 288 lignes chargées.

- `14_postgresql_airbyte_table_count_288.png`  
  Vérification PostgreSQL de la table `raw.wu_ichtegem_csv` avec 288 lignes.

## Utilisation dans le livrable

Ces captures permettent de prouver :

- la mise en place de GitHub
- la configuration Airbyte
- la destination PostgreSQL
- la difficulté rencontrée avec la source fichier locale
- la documentation DBT
- la structure du projet DBT
- le lineage complet du pipeline ELT

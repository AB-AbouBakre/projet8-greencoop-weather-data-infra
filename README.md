# GreenAndCoop — Forecast 2.0

Pipeline ELT de données météorologiques construit dans le cadre du projet 8 OpenClassrooms : **Construisez et testez une infrastructure de données**.

L’objectif est de centraliser plusieurs sources météo, de les transformer avec dbt, de contrôler leur qualité et d’automatiser leur exécution sur AWS.

## Architecture

```text
Sources météo
  ├── InfoClimat — JSON / JSONL
  ├── Weather Underground — Ichtegem
  └── Weather Underground — La Madeleine
          ↓
Airbyte — ingestion ELT
          ↓
PostgreSQL / AWS RDS — données brutes
          ↓
dbt Core — staging → intermediate → marts
          ↓
Modèles analytiques et documentation
```

Industrialisation AWS :

```text
EventBridge Scheduler
        ↓
ECS Fargate
        ↓
Image dbt stockée dans ECR
        ↓
PostgreSQL RDS
        ↓
CloudWatch Logs
```

Le mot de passe PostgreSQL est stocké dans AWS Secrets Manager et injecté dans la tâche ECS au moment de l’exécution.

## Stack technique

- Airbyte
- PostgreSQL
- dbt Core
- Docker
- AWS RDS
- AWS ECR
- AWS ECS Fargate
- AWS EventBridge Scheduler
- AWS Secrets Manager
- AWS CloudWatch Logs

## Structure du projet

```text
dbt_greencoop/
├── models/
│   ├── staging/
│   │   ├── sources.yml
│   │   ├── schema.yml
│   │   ├── stg_infoclimat_hourly.sql
│   │   ├── stg_infoclimat_stations.sql
│   │   ├── stg_wu_ichtegem.sql
│   │   └── stg_wu_la_madeleine.sql
│   ├── intermediate/
│   │   ├── int_weather_observations_standardized.sql
│   │   ├── int_weather_underground.sql
│   │   └── schema.yml
│   └── marts/
│       ├── dim_weather_stations.sql
│       └── fact_weather_observations.sql
├── Dockerfile
├── requirements.txt
├── dbt_project.yml
└── README.md
```

## Modèles principaux

### `dim_weather_stations`

Dimension regroupant les métadonnées des stations :

- identifiant de station ;
- nom ;
- latitude et longitude ;
- altitude ;
- réseau ;
- type de station ;
- source.

### `fact_weather_observations`

Table de faits contenant les observations météo normalisées :

- horodatage ;
- station ;
- température ;
- humidité ;
- pression ;
- vitesse et direction du vent ;
- précipitations ;
- source de la donnée.

## Installation locale

### Prérequis

- Python 3.12
- Docker
- PostgreSQL accessible
- dbt Core

### Installer les dépendances

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### Configurer le profil dbt

Les identifiants de connexion ne doivent pas être enregistrés dans Git.

Exemple de variables d’environnement :

```bash
export AWS_RDS_HOST="<rds-endpoint>"
export AWS_RDS_USER="postgres"
export AWS_RDS_PASSWORD="<password>"
export AWS_RDS_DBNAME="weather_db"
```

Le fichier `profiles.yml` doit utiliser ces variables avec `env_var()`.

## Commandes dbt

Vérifier la connexion :

```bash
dbt debug --target aws
```

Exécuter les modèles :

```bash
dbt run --target aws
```

Exécuter les tests :

```bash
dbt test --target aws
```

Exécuter la chaîne complète :

```bash
dbt build --target aws
```

Générer la documentation :

```bash
dbt docs generate --target aws
dbt docs serve
```

## Qualité des données

Les contrôles dbt couvrent notamment :

- valeurs non nulles ;
- unicité des clés ;
- intégrité référentielle entre faits et dimension ;
- cohérence des identifiants de stations ;
- plages de valeurs plausibles ;
- validation des modèles staging, intermediate et marts.

Dernière exécution validée :

```text
Completed successfully
PASS=49 WARN=0 ERROR=0 SKIP=0 NO-OP=0 TOTAL=49
```

## Conteneurisation

Construire l’image :

```bash
docker build --platform linux/amd64 -t greencoop-dbt .
```

Tester localement :

```bash
docker run --rm \
  -e AWS_RDS_HOST \
  -e AWS_RDS_USER \
  -e AWS_RDS_PASSWORD \
  -e AWS_RDS_DBNAME \
  greencoop-dbt debug --target aws
```

## Déploiement AWS

Les composants déployés sont :

- **RDS PostgreSQL** pour le stockage central ;
- **ECR** pour l’image Docker dbt ;
- **ECS Fargate** pour l’exécution de `dbt build` ;
- **Secrets Manager** pour le mot de passe RDS ;
- **CloudWatch Logs** pour les journaux d’exécution ;
- **EventBridge Scheduler** pour la planification quotidienne.

La tâche ECS utilise :

```text
CPU    : 512
Mémoire: 1024 MiB
Mode   : FARGATE / awsvpc
```

La planification actuelle est :

```text
Nom       : greencoop-dbt-daily
État      : ENABLED
Expression: cron(0 6 * * ? *)
Fuseau    : UTC
```

## Résultat de l’exécution ECS

```text
Status    : STOPPED
Stop code : EssentialContainerExited
Exit code : 0
```

Pour une tâche batch dbt, l’arrêt du conteneur est normal après la fin de l’exécution. Le code de sortie `0` confirme le succès.

## Sécurité

Ne jamais versionner :

- `.env` ;
- `profiles.yml` contenant des identifiants ;
- mots de passe ;
- clés AWS ;
- fichiers temporaires ;
- sauvegardes locales ;
- secrets exportés dans des scripts.

Exemples recommandés dans `.gitignore` :

```gitignore
.env
profiles.yml
target/
logs/
dbt_packages/
*.pem
*.key
*.bak
*.backup
*.backup_*
~$*.pptx
.DS_Store
```

## Livrables

- modèles dbt ;
- tests et documentation ;
- schéma d’architecture ;
- logigramme ELT ;
- captures Airbyte, dbt et AWS ;
- présentation de soutenance ;
- preuve d’exécution ECS ;
- preuve des logs CloudWatch ;
- reporting qualité.

## Statut du projet

- ingestion : terminée ;
- transformations dbt : terminées ;
- tests : 49 réussis, 0 erreur ;
- déploiement AWS : terminé ;
- automatisation : active ;
- documentation et soutenance : finalisation.

## Auteur

Projet réalisé dans le cadre de la formation Data Engineer OpenClassrooms.

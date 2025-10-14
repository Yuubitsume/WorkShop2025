# Plan de Reprise d'Activité (PRA) pour l'infrastructure DOCKERWARTS

## Introduction

Ce document détaille le Plan de Reprise d'Activité (PRA) pour l'infrastructure DOCKERWARTS, visant à assurer la continuité des services en cas de défaillance majeure du système. Un PRA complet inclut des mesures de sauvegarde, de restauration et des procédures de reprise.

## Stratégie de Sauvegarde

La stratégie de sauvegarde est essentielle pour protéger les données critiques de l'infrastructure. Elle repose sur les principes suivants :

*   **Sauvegarde des volumes Docker :** Tous les volumes persistants (`glpi_data`, `es_data`, `grafana_data`, `cassandra_data`) seront sauvegardés régulièrement.
    *   **Fréquence :** Quotidienne pour les données transactionnelles (GLPI, Elasticsearch) et hebdomadaire pour les données de configuration (Grafana).
    *   **Méthode :** Utilisation de `docker cp` ou de solutions de sauvegarde de volumes Docker (ex: `docker-volume-backup`) pour copier les données vers un stockage externe.
*   **Sauvegarde de la configuration :** Les fichiers de configuration de chaque service (ex: `docker-compose.yml`, configurations Nginx/ModSecurity) seront versionnés et stockés dans un dépôt Git distant.
*   **Stockage des sauvegardes :** Les sauvegardes seront stockées sur un système de stockage objet (ex: S3, MinIO) ou un serveur de fichiers distant, avec une réplication géographique pour une résilience accrue.

## Stratégie de Reprise d'Activité

En cas de sinistre, la reprise d'activité suivra les étapes suivantes :

1.  **Déploiement de l'infrastructure de base :** Utilisation du fichier `docker-compose.yml` versionné pour redéployer l'ensemble des services sur une nouvelle infrastructure.
    ```bash
    docker-compose up -d
    ```
2.  **Restauration des données :** Les données sauvegardées seront restaurées dans les volumes correspondants.
    *   **GLPI :** Restauration de la base de données et des fichiers attachés.
    *   **Elasticsearch :** Restauration des snapshots d'index.
    *   **Grafana :** Restauration du volume de données pour récupérer les dashboards et configurations.
    *   **Cassandra :** Utilisation des outils de restauration de Cassandra pour récupérer les données.
3.  **Vérification et validation :** Après la restauration, des tests fonctionnels et de performance seront effectués pour s'assurer que tous les services sont opérationnels et que les données sont cohérentes.

## Mesures de Haute Disponibilité

En complément du PRA, des mesures de haute disponibilité sont intégrées à l'architecture :

*   **Docker Swarm :** Permet la réplication des services et le redémarrage automatique des conteneurs défaillants.
*   **Réplication des données :** Elasticsearch et Cassandra sont configurés pour la réplication des données entre plusieurs nœuds, assurant la tolérance aux pannes au niveau des données.
*   **Load Balancing :** Le WAF (Nginx) distribue le trafic, évitant un point de défaillance unique pour l'accès aux applications.

## Tests du PRA

Le PRA sera testé régulièrement (au moins une fois par an) pour valider son efficacité et identifier les éventuelles lacunes. Les tests incluront des scénarios de défaillance partielle et totale de l'infrastructure.

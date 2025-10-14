# 🐳 Infrastructure Big Data Dockerisée

Ce projet déploie une infrastructure complète et hautement disponible (HA), conçue pour supporter un projet Big Data en environnement professionnel, le tout orchestré avec **Docker Compose**.

## 🎯 Architecture du Projet et Technologies

L'infrastructure est modulaire et intègre des composants essentiels pour la gestion, le traitement et la surveillance des données et des services :

| Rôle | Technologie | Conteneurs | Haute Disponibilité (HA) |
| :--- | :--- | :--- | :--- |
| **Orchestration / Routing** | **Traefik v2** (Reverse Proxy/LB) | `traefik` | Point d'entrée unique. Prêt pour HA via Keepalived sur l'hôte. |
| **Ticketing / ITAM** | **GLPI** & **MariaDB** | `glpi-web`, `glpi-db` | Réplication DB (Master/Slave) et Mise à l'échelle du Web (`--scale glpi-web=N`). |
| **Datalake (NoSQL)** | **Apache Cassandra** | `cassandra1`, `cassandra2`, `cassandra3` | Cluster de 3 nœuds, réplication et tolérance aux pannes natives. |
| **Historisation / Logs** | **Elasticsearch** & **Kibana (ELK)** | `elasticsearch`, `kibana` | Cluster Elasticsearch (1 nœud, 3 recommandés en prod), indexation résiliente. |
| **Monitoring / Visualisation** | **Prometheus** & **Grafana** | `prometheus`, `grafana` | Collecte centralisée de métriques et alertes. |

***

## 🚀 Prérequis

1.  **Docker Engine** (version 20.10+).
2.  **Docker Compose** (version V2 recommandée).
3.  **Ressources Système** : Minimum **8 GB** de RAM (16 GB fortement recommandé pour Cassandra et Elasticsearch).

### Configuration Hôte Locale (`/etc/hosts`)

Pour que le reverse proxy Traefik fonctionne correctement en environnement local, ajoutez les entrées suivantes à votre fichier hôte (`/etc/hosts` ou équivalent) :

```text
127.0.0.1 glpi.localhost
127.0.0.1 kibana.localhost
127.0.0.1 prometheus.localhost
127.0.0.1 grafana.localhost
127.0.0.1 traefik.localhost
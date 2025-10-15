# Projet d'Infrastructure Big Data DevOps

Ce projet vise à concevoir, documenter et dockeriser une infrastructure complète et professionnelle pour un projet Big Data, en intégrant des outils clés pour le ticketing, l'historisation des données, le monitoring, la visualisation, le stockage NoSQL, la sécurité et la haute disponibilité.

## Architecture Générale

L'architecture sera basée sur Docker et Docker Compose, permettant un déploiement facile et une gestion cohérente des services. Les composants principaux incluront :

- **GLPI** : Pour la gestion des tickets et l'inventaire.
- **Elasticsearch** : Pour l'historisation et la recherche de données.
- **Grafana** : Pour le monitoring et la visualisation des métriques.
- **Cassandra** : Comme base de données NoSQL et datalake.
- **Nginx (Reverse Proxy)** : Pour la sécurité réseau et le load balancing.
- **Prometheus** : Pour la collecte de métriques.

La haute disponibilité sera assurée par des configurations spécifiques à chaque service (clusters Elasticsearch, Cassandra multi-nodes) et par des mécanismes de réplication et de failover au niveau de l'orchestration (Docker Swarm ou Kubernetes, si nécessaire, mais Docker Compose sera la base).

## Prérequis

Avant de lancer le projet, assurez-vous d'avoir les éléments suivants installés sur votre système :

-   **Docker Engine** : Version 19.03 ou supérieure.
-   **Docker Compose** : Version 1.27 ou supérieure.
-   **Git** (optionnel, pour cloner le dépôt).

## Lancement du Projet

Pour lancer l'ensemble de l'infrastructure, suivez les étapes ci-dessous :

1.  **Cloner le dépôt (si ce n'est pas déjà fait) :**
    ```bash
    git clone <URL_DU_DEPOT>
    cd <NOM_DU_DOSSIER_DU_PROJET>
    ```

2.  **Générer les certificats SSL auto-signés pour Nginx :**
    ```bash
    mkdir -p configs
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout configs/nginx.key -out configs/nginx.crt -subj "/C=FR/ST=IDF/L=Paris/O=BigDataDevOps/OU=IT/CN=localhost"
    ```

3.  **Démarrer l'infrastructure Docker :**
    ```bash
    docker-compose up -d
    ```
    Cette commande va télécharger les images Docker nécessaires, créer les conteneurs, les réseaux et les volumes, puis démarrer tous les services en arrière-plan.

4.  **Vérifier le statut des conteneurs :**
    ```bash
    docker-compose ps
    ```
    Tous les conteneurs devraient être en état `Up`.

## Vérification du Fonctionnement

Une fois l'infrastructure lancée, vous pouvez vérifier le bon fonctionnement de chaque service :

-   **Nginx (Reverse Proxy) :**
    -   Accédez à `https://localhost` dans votre navigateur. Vous devriez voir une page d'erreur 404 de Nginx, car il n'y a pas de route par défaut, mais cela confirme que Nginx est opérationnel et que le HTTPS fonctionne.

-   **GLPI :**
    -   Accédez à `https://localhost/glpi/` dans votre navigateur. Vous devriez être redirigé vers la page d'installation ou de connexion de GLPI.
    -   **Identifiants par défaut (après installation) :** `glpi/glpi` (à changer immédiatement).

-   **Grafana :**
    -   Accédez à `https://localhost/grafana/` dans votre navigateur. Vous devriez voir la page de connexion de Grafana.
    -   **Identifiants par défaut :** `admin/admin` (vous serez invité à changer le mot de passe au premier login).
    -   Ajoutez les sources de données Prometheus (`http://prometheus:9090`) et Elasticsearch (`http://elasticsearch:9200`) dans Grafana.

-   **Elasticsearch :**
    -   Accédez à `https://localhost/elasticsearch/` dans votre navigateur ou utilisez `curl https://localhost/elasticsearch/ -k` (pour ignorer le certificat auto-signé). Vous devriez obtenir une réponse JSON avec des informations sur le cluster Elasticsearch.

-   **Prometheus :**
    -   Accédez à `http://localhost:9090` dans votre navigateur. Vous devriez voir l'interface web de Prometheus. Vérifiez la section `Status -> Targets` pour vous assurer que tous les exporters sont `UP`.

-   **Cassandra :**
    -   Pour vérifier Cassandra, vous pouvez exécuter une commande à l'intérieur du conteneur :
        ```bash
        docker exec cassandra nodetool status
        ```
        Vous devriez voir le statut du nœud Cassandra.

## Documentation

Ce dossier `docs` contient la documentation détaillée du projet, incluant l'architecture, les détails techniques de chaque composant, le monitoring, et le plan de reprise d'activité (PRA).

-   `architecture.png` : Schéma de l'architecture générale.
-   `infrastructure.md` : Détails techniques de chaque composant.
-   `monitoring.md` : Explication du monitoring, des dashboards et des alertes.
-   `security.md` : Détails des mesures de sécurité.
-   `PRA.md` : Plan complet de sauvegarde et de reprise d'activité.

## Scripts de Sauvegarde et Restauration

Le dossier `scripts` contient des exemples de scripts pour la sauvegarde et la restauration de la base de données MySQL de GLPI.

-   `scripts/backup_mysql.sh` : Script de sauvegarde de la base de données MySQL.
-   `scripts/restore_mysql.sh` : Script de restauration de la base de données MySQL.

**Note :** Pour les sauvegardes d'Elasticsearch et Cassandra, les mécanismes natifs (snapshots) sont privilégiés et décrits dans `docs/PRA.md`.

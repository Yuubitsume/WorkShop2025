# Plan de Reprise d'Activité (PRA) et Stratégies de Sauvegarde

Ce document décrit le Plan de Reprise d'Activité (PRA) et les stratégies de sauvegarde mises en place pour l'infrastructure Big Data DevOps. L'objectif est d'assurer la persistance des données, la continuité des services et la capacité à récupérer rapidement en cas de sinistre.

## 1. Stratégies de Sauvegarde des Volumes

La sauvegarde des données est cruciale pour la résilience de l'infrastructure. Chaque service critique dispose d'une stratégie de sauvegarde adaptée à ses spécificités.

### 1.1. GLPI (Données d'application et Base de données MySQL)

-   **Volumes à sauvegarder :**
    -   `glpi_data` (fichiers de l'application GLPI : `/var/www/html/glpi`)
    -   `mysql_data` (base de données MySQL de GLPI : `/var/lib/mysql`)

-   **Outils et Fréquence :**
    -   **MySQL :** Utilisation de `mysqldump` pour exporter la base de données vers un fichier, puis compression et chiffrement. Fréquence quotidienne (ex: toutes les nuits à 2h du matin).
    -   **Fichiers GLPI :** Utilisation de `rsync` ou `restic` pour sauvegarder les fichiers de l'application. Fréquence hebdomadaire ou après chaque mise à jour majeure.

-   **Exemple de script de sauvegarde MySQL (à exécuter depuis un conteneur ou l'hôte) :**
    ```bash
    #!/bin/bash
    DB_USER="glpiuser"
    DB_PASSWORD="glpipassword"
    DB_NAME="glpidb"
    BACKUP_DIR="/backups/glpi_mysql"
    DATE=$(date +%Y%m%d%H%M%S)
    FILENAME="glpi_db_backup_${DATE}.sql.gz"

    mkdir -p $BACKUP_DIR
    docker exec mysql sh -c "exec mysqldump -u${DB_USER} -p${DB_PASSWORD} ${DB_NAME}" | gzip > ${BACKUP_DIR}/${FILENAME}
    # Optionnel: Chiffrement avec GPG et envoi vers un stockage distant
    # gpg --encrypt --recipient backup_key ${BACKUP_DIR}/${FILENAME}
    # rclone copy ${BACKUP_DIR}/${FILENAME}.gpg remote:glpi-backups/
    ```

### 1.2. Elasticsearch (Indices de données)

-   **Volumes à sauvegarder :** `es_data` (données des indices Elasticsearch : `/usr/share/elasticsearch/data`)

-   **Outils et Fréquence :**
    -   **Snapshots Elasticsearch :** Elasticsearch dispose d'une API de snapshots intégrée qui permet de sauvegarder l'état des indices vers un référentiel partagé (ex: S3, HDFS, ou un système de fichiers partagé). Fréquence quotidienne pour les indices critiques, hebdomadaire pour les autres.
    -   **Configuration :** Un référentiel de snapshots doit être enregistré via l'API Elasticsearch.

-   **Exemple de commande pour créer un snapshot (via l'API Elasticsearch) :**
    ```bash
    # Enregistrer un référentiel de snapshots (ex: sur un volume partagé)
    # PUT /_snapshot/my_backup_repository
    # {
    #   "type": "fs",
    #   "settings": {
    #     "location": "/usr/share/elasticsearch/snapshots"
    #   }
    # }

    # Créer un snapshot de tous les indices
    # PUT /_snapshot/my_backup_repository/snapshot_1?wait_for_completion=true
    ```

### 1.3. Cassandra (Keyspaces)

-   **Volumes à sauvegarder :** `cassandra_data` (données des keyspaces Cassandra : `/var/lib/cassandra`)

-   **Outils et Fréquence :**
    -   **Snapshots Cassandra (nodetool snapshot) :** Cassandra permet de créer des snapshots au niveau du nœud. Ces snapshots sont des copies immuables des données à un instant T. Fréquence quotidienne.
    -   **Sauvegarde incrémentale :** Cassandra supporte également la sauvegarde incrémentale, qui copie uniquement les données modifiées depuis le dernier snapshot. Fréquence horaire.

-   **Exemple de commande pour créer un snapshot (à exécuter dans le conteneur Cassandra) :**
    ```bash
    #!/bin/bash
    docker exec cassandra nodetool snapshot -t my_snapshot_tag
    # Les snapshots sont stockés dans /var/lib/cassandra/data/<keyspace>/<table>/snapshots/my_snapshot_tag
    # Ces fichiers doivent ensuite être copiés vers un stockage distant.
    ```

### 1.4. Grafana (Configuration et Tableaux de bord)

-   **Volumes à sauvegarder :** `grafana_data` (configuration, bases de données internes, tableaux de bord : `/var/lib/grafana`)

-   **Outils et Fréquence :**
    -   **Sauvegarde du volume :** Utilisation de `rsync` ou `restic` pour sauvegarder le volume `grafana_data`. Fréquence quotidienne.
    -   **API Grafana :** Les tableaux de bord peuvent être exportés via l'API Grafana en JSON. Fréquence après chaque modification majeure.

## 2. Plan de Restauration

Le plan de restauration décrit les étapes à suivre pour récupérer les services et les données en cas de perte totale ou partielle du système.

### 2.1. Restauration de GLPI

1.  Déployer un nouveau conteneur GLPI et MySQL (ou utiliser les conteneurs existants si seulement les données sont perdues).
2.  Restaurer la base de données MySQL à partir du dernier `mysqldump` sauvegardé.
    ```bash
    # Exemple de restauration MySQL
    # gunzip < glpi_db_backup_latest.sql.gz | docker exec -i mysql sh -c "exec mysql -u${DB_USER} -p${DB_PASSWORD} ${DB_NAME}"
    ```
3.  Restaurer les fichiers de l'application GLPI dans le volume `glpi_data`.
4.  Vérifier la connectivité et le fonctionnement de GLPI.

### 2.2. Restauration d'Elasticsearch

1.  Déployer un nouveau cluster Elasticsearch (ou des nœuds de remplacement).
2.  Enregistrer le référentiel de snapshots existant sur le nouveau cluster.
3.  Restaurer les indices à partir du dernier snapshot.
    ```bash
    # Exemple de restauration Elasticsearch
    # POST /_snapshot/my_backup_repository/snapshot_1/_restore
    # {
    #   "indices": "*",
    #   "ignore_unavailable": true,
    #   "include_global_state": true
    # }
    ```
4.  Vérifier l'intégrité des données et le statut du cluster.

### 2.3. Restauration de Cassandra

1.  Déployer un nouveau cluster Cassandra (ou des nœuds de remplacement).
2.  Copier les fichiers de snapshot restaurés dans les répertoires de données appropriés de Cassandra (`/var/lib/cassandra/data/<keyspace>/<table>/snapshots/`).
3.  Utiliser `nodetool refresh` pour que Cassandra reconnaisse les données restaurées.
4.  Vérifier la cohérence des données et le statut du cluster.

### 2.4. Restauration de Grafana

1.  Déployer un nouveau conteneur Grafana.
2.  Restaurer le contenu du volume `grafana_data`.
3.  Vérifier que les sources de données et les tableaux de bord sont correctement chargés.

## 3. Mesures de Redondance et de Tolérance aux Pannes

Au-delà des sauvegardes, l'infrastructure intègre des mécanismes de redondance pour minimiser les temps d'arrêt.

-   **Haute Disponibilité (HA) des services :**
    -   **Elasticsearch :** Déployé en cluster avec plusieurs nœuds et réplication des shards pour tolérer la perte de nœuds.
    -   **Cassandra :** Conçu pour la HA par nature, avec une architecture distribuée et une réplication des données configurable (facteur de réplication).
    -   **Nginx :** Peut être mis en HA avec des solutions comme Keepalived ou un load balancer externe pour éviter un point de défaillance unique.

-   **Docker Compose `restart: unless-stopped` :** Assure que les conteneurs redémarrent automatiquement en cas de défaillance ou de redémarrage de l'hôte.

-   **Volumes persistants :** L'utilisation de volumes Docker garantit que les données ne sont pas liées au cycle de vie des conteneurs.

## 4. Procédures de Test du PRA

Un PRA n'est efficace que s'il est régulièrement testé. Les tests doivent inclure :

-   **Tests de restauration de données :** Vérifier que les sauvegardes peuvent être restaurées avec succès et que les données sont intactes.
-   **Tests de basculement (Failover) :** Simuler la défaillance d'un nœud ou d'un service et vérifier que les mécanismes de HA prennent le relais.
-   **Tests de récupération complète :** Simuler une perte totale de l'environnement et exécuter le plan de restauration complet pour mesurer le RTO (Recovery Time Objective) et le RPO (Recovery Point Objective).
-   **Documentation :** Mettre à jour la documentation du PRA après chaque test et modification de l'infrastructure.

**Fréquence des tests :** Au moins une fois par an, ou après toute modification significative de l'architecture ou des stratégies de sauvegarde.

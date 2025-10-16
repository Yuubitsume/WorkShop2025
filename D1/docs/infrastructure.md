# Détails Techniques de l'Infrastructure

Cette section décrit en détail chaque composant de l'infrastructure Big Data DevOps, incluant leur rôle, leur configuration, les ports utilisés, les volumes persistants et leurs dépendances.

## 1. Nginx (Reverse Proxy / Load Balancer)

**Rôle :** Point d'entrée unique pour toutes les requêtes externes. Il agit comme un reverse proxy, distribuant le trafic vers les services internes (GLPI, Grafana, Elasticsearch/Kibana) et assurant la terminaison SSL.

**Configuration :**
- **Ports :** 80 (HTTP, redirigé vers HTTPS), 443 (HTTPS).
- **Volumes :** `/etc/nginx/conf.d` pour les configurations des sites, `/etc/nginx/certs` pour les certificats SSL.
- **Dépendances :** Aucun service externe direct, mais dépend des services internes (GLPI, Grafana, Elasticsearch) pour la redirection du trafic.
- **Sécurité :** Terminaison SSL, filtrage de base via les configurations Nginx.

## 2. GLPI

**Rôle :** Système de gestion de services informatiques (ITSM) et de gestion de parc informatique. Utilisé pour le ticketing et l'inventaire.

**Configuration :**
- **Ports :** Accédé via Nginx (pas de port exposé directement).
- **Volumes :** `/var/www/html/glpi` pour les fichiers de l'application, `/var/lib/mysql` pour la base de données MySQL associée.
- **Dépendances :** Base de données MySQL (non incluse dans ce document, mais nécessaire pour GLPI).
- **Authentification :** Gérée par GLPI, avec une configuration HTTPS via Nginx.

## 3. Elasticsearch

**Rôle :** Moteur de recherche et d'analyse distribué, utilisé pour l'historisation et la recherche de données (logs, métriques).

**Configuration :**
- **Ports :** 9200 (API HTTP), 9300 (communication inter-nœuds).
- **Volumes :** `/usr/share/elasticsearch/data` pour les données persistantes.
- **Dépendances :** Aucune dépendance directe pour le démarrage, mais interagit avec Grafana et Kibana.
- **Haute Disponibilité :** Déployé en cluster multi-nœuds pour la réplication et la tolérance aux pannes.
- **Authentification :** Sécurisé via X-Pack (ou équivalent open-source) et accédé via Nginx en HTTPS.

## 4. Grafana

**Rôle :** Plateforme de visualisation et de monitoring. Collecte et affiche des métriques et des logs provenant d'Elasticsearch, Prometheus et d'autres sources.

**Configuration :**
- **Ports :** Accédé via Nginx (pas de port exposé directement).
- **Volumes :** `/var/lib/grafana` pour les bases de données, les tableaux de bord et les plugins.
- **Dépendances :** Elasticsearch, Prometheus (en tant que sources de données).
- **Authentification :** Gérée par Grafana, avec une configuration HTTPS via Nginx.

## 5. Cassandra

**Rôle :** Base de données NoSQL distribuée, conçue pour gérer de très grands volumes de données sur de nombreux serveurs, offrant une haute disponibilité sans point de défaillance unique.

**Configuration :**
- **Ports :** 7000 (communication inter-nœuds), 7001 (SSL inter-nœuds), 7199 (JMX), 9042 (client CQL).
- **Volumes :** `/var/lib/cassandra` pour les données, `/var/log/cassandra` pour les logs.
- **Dépendances :** Aucune dépendance directe pour le démarrage.
- **Haute Disponibilité :** Déployé en cluster multi-nœuds pour la réplication et la tolérance aux pannes.

## 6. Prometheus

**Rôle :** Système de monitoring et d'alerting. Collecte des métriques à partir de cibles configurées (exporters) et les stocke dans une base de données de séries temporelles.

**Configuration :**
- **Ports :** 9090 (interface web et API).
- **Volumes :** `/prometheus` pour les données de séries temporelles et la configuration.
- **Dépendances :** Exporters sur les services cibles (Node Exporter pour les hôtes, cAdvisor pour les conteneurs, JMX Exporter pour Cassandra, etc.).

## Réseau Docker

L'infrastructure utilisera un réseau Docker personnalisé pour isoler les services et contrôler les flux de communication :

- **`frontend-net` (Bridge) :** Pour les services exposés via Nginx (Nginx, GLPI, Grafana, Kibana).
- **`backend-net` (Bridge) :** Pour les services internes (Elasticsearch, Prometheus, Cassandra) et la communication entre eux.
- **`data-net` (Bridge) :** (Optionnel, pour une isolation plus stricte) Pour la communication entre les nœuds de bases de données (Elasticsearch, Cassandra).

Les conteneurs seront connectés aux réseaux appropriés pour permettre la communication nécessaire tout en maintenant une segmentation logique. Par exemple, Nginx sera sur `frontend-net` et `backend-net` pour router le trafic. Elasticsearch et Cassandra seront sur `backend-net` (et potentiellement `data-net`) pour leur communication interne et avec Prometheus/Grafana.

## Volumes Persistants

Des volumes Docker seront utilisés pour assurer la persistance des données pour tous les services critiques :

- **`nginx_conf` :** Configuration de Nginx.
- **`nginx_certs` :** Certificats SSL de Nginx.
- **`glpi_data` :** Fichiers de l'application GLPI.
- **`mysql_data` :** Base de données MySQL pour GLPI.
- **`es_data` :** Données d'Elasticsearch.
- **`grafana_data` :** Données, tableaux de bord et configuration de Grafana.
- **`cassandra_data` :** Données de Cassandra.
- **`prometheus_data` :** Données de séries temporelles de Prometheus.

Ces volumes garantiront que les données ne sont pas perdues lors de la recréation ou de la mise à jour des conteneurs.

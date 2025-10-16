# Monitoring et Logs

Cette section détaille la mise en place du monitoring et de la gestion des logs pour l'infrastructure Big Data DevOps, en utilisant Prometheus et Grafana.

## 1. Prometheus

**Rôle :** Prometheus est un système de surveillance et d'alerte open-source. Il collecte des métriques à partir de cibles configurées à intervalles réguliers, évalue des règles d'expression, affiche les résultats et peut déclencher des alertes si certaines conditions sont remplies.

**Configuration :** Le fichier `configs/prometheus.yml` définit les cibles à surveiller. Nous avons configuré Prometheus pour collecter des métriques des services suivants :

- **Prometheus lui-même :** Pour surveiller son propre état de fonctionnement.
- **cAdvisor :** Pour les métriques des conteneurs Docker (CPU, mémoire, I/O, réseau).
- **Node Exporter :** Pour les métriques de l'hôte sous-jacent (CPU, mémoire, disque, réseau).
- **Elasticsearch :** Pour les métriques spécifiques à Elasticsearch.
- **Cassandra :** Pour les métriques spécifiques à Cassandra.
- **GLPI :** (Potentiellement, si un exporter est disponible ou si des métriques sont exposées via une API).
- **Grafana :** (Potentiellement, pour surveiller l'état de Grafana).

```yaml
# Contenu de configs/prometheus.yml
# (voir le fichier pour les détails complets)
```

## 2. Grafana

**Rôle :** Grafana est une plateforme open-source d'analyse et de visualisation de données. Il permet de créer des tableaux de bord interactifs et personnalisables pour visualiser les métriques collectées par Prometheus, Elasticsearch, et d'autres sources de données.

**Configuration :** Grafana sera configuré pour utiliser Prometheus et Elasticsearch comme sources de données. Des tableaux de bord pré-construits ou personnalisés seront importés ou créés pour visualiser les métriques clés.

**Tableaux de bord pertinents :**

- **Métriques CPU :** Utilisation du CPU par conteneur et par hôte.
- **Métriques Mémoire :** Utilisation de la mémoire par conteneur et par hôte.
- **Métriques I/O :** Opérations d'entrée/sortie disque et réseau.
- **Disponibilité des services :** État de santé des conteneurs et des services (GLPI, Elasticsearch, Cassandra, Grafana).
- **Erreurs d'accès :** Logs d'erreurs collectés par Elasticsearch et visualisés dans Grafana.
- **Métriques Elasticsearch :** État du cluster, nombre de documents, requêtes par seconde.
- **Métriques Cassandra :** Latence des requêtes, utilisation du disque, état des nœuds.

### Exemple de configuration de source de données Prometheus dans Grafana (via API ou UI) :

```json
{
  "name": "Prometheus",
  "type": "prometheus",
  "url": "http://prometheus:9090",
  "access": "proxy",
  "isDefault": true
}
```

### Exemple de configuration de source de données Elasticsearch dans Grafana (via API ou UI) :

```json
{
  "name": "Elasticsearch",
  "type": "elasticsearch",
  "url": "http://elasticsearch:9200",
  "access": "proxy",
  "database": "[logstash-]YYYY.MM.DD",
  "jsonData": {
    "esVersion": 7,
    "timeField": "@timestamp"
  }
}
```

## 3. Logs Centralisés

Les logs de tous les conteneurs seront centralisés et ingérés dans Elasticsearch. Cela permettra une recherche et une analyse efficaces des événements et des erreurs à travers toute l'infrastructure. Grafana sera utilisé pour visualiser ces logs via des tableaux de bord dédiés.

## 4. Alerting

Prometheus et Grafana seront configurés pour envoyer des alertes en cas de dépassement de seuils critiques (ex: utilisation CPU > 90%, service down, erreurs fréquentes). Ces alertes pourront être acheminées vers des systèmes de notification (ex: email, Slack, PagerDuty).

#!/bin/bash

# Ce script est un exemple simple pour illustrer la collecte de métriques.
# Dans un environnement réel, Prometheus et Grafana géreraient cela de manière plus robuste.

LOG_FILE="/var/log/pra_monitor.log"

# Assurez-vous que le répertoire de log existe
mkdir -p $(dirname $LOG_FILE)

echo "$(date "+%Y-%m-%d %H:%M:%S") - Démarrage du monitoring..."

# Exemple de collecte de métriques système (utilisation CPU, mémoire)
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk 
'{print 100 - $1}')
MEM_USAGE=$(free | grep Mem | awk 
'{print $3/$2 * 100.0}')

echo "$(date "+%Y-%m-%d %H:%M:%S") - CPU Usage: ${CPU_USAGE}%"
echo "$(date "+%Y-%m-%d %H:%M:%S") - Memory Usage: ${MEM_USAGE}%"

# Exemple de vérification de l'accessibilité des services Docker
BACKEND_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000)
FRONTEND_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:80)

echo "$(date "+%Y-%m-%d %H:%M:%S") - Backend Status (HTTP): ${BACKEND_STATUS}"
echo "$(date "+%Y-%m-%d %H:%M:%S") - Frontend Status (HTTP): ${FRONTEND_STATUS}"

# Enregistrer les logs dans un fichier
echo "$(date "+%Y-%m-%d %H:%M:%S") - Monitoring data collected." >> $LOG_FILE

# Pour une intégration Prometheus, ces métriques seraient exposées via un exporter
# Par exemple, un Node Exporter pour les métriques système, et des exporters spécifiques pour les applications.

echo "Monitoring terminé."


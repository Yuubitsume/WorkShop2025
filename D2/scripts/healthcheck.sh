#!/bin/bash

echo "Vérification de l'état des conteneurs Docker..."

# Vérifier si Docker est en cours d'exécution
if ! systemctl is-active --quiet docker; then
  echo "Erreur: Le service Docker n'est pas en cours d'exécution."
  exit 1
fi

# Vérifier l'état des conteneurs définis dans docker-compose
CONTAINERS=("pra-si-backend-1" "pra-si-frontend-1" "pra-si-database-1" "pra-si-prometheus-1" "pra-si-grafana-1" "pra-si-cadvisor-1")

ALL_RUNNING=true
for CONTAINER in "${CONTAINERS[@]}"; do
  if ! docker ps --filter "name=${CONTAINER}" --filter "status=running" --quiet | grep -q .; then
    echo "Conteneur ${CONTAINER} n'est PAS en cours d'exécution."
    ALL_RUNNING=false
  else
    echo "Conteneur ${CONTAINER} est en cours d'exécution."
  fi
done

if $ALL_RUNNING; then
  echo "Tous les conteneurs critiques sont en cours d'exécution."
  exit 0
else
  echo "Certains conteneurs critiques ne sont pas en cours d'exécution."
  exit 1
fi


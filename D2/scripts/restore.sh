#!/bin/bash

# Variables d'environnement (à configurer ou passer en paramètre)
DB_CONTAINER_NAME="pra-si-database-1" # Nom du conteneur de la base de données
DB_NAME="${POSTGRES_DB:-mydatabase}"
DB_USER="${POSTGRES_USER:-user}"
BACKUP_FILE="/tmp/db_backups/${DB_NAME}_latest.sql" # Chemin vers le fichier de sauvegarde à restaurer

# Vérifier si le fichier de sauvegarde existe
if [ ! -f "${BACKUP_FILE}" ]; then
  echo "Erreur : Fichier de sauvegarde non trouvé à ${BACKUP_FILE}"
  exit 1
fi

echo "Démarrage de la restauration de la base de données ${DB_NAME} à partir de ${BACKUP_FILE}..."

# Arrêter les services qui pourraient utiliser la base de données si nécessaire
# docker-compose stop backend frontend

# Supprimer la base de données existante et la recréer pour une restauration propre
docker exec "${DB_CONTAINER_NAME}" dropdb -U "${DB_USER}" "${DB_NAME}"
docker exec "${DB_CONTAINER_NAME}" createdb -U "${DB_USER}" "${DB_NAME}"

# Exécuter pg_restore ou psql à l'intérieur du conteneur PostgreSQL
docker exec -i "${DB_CONTAINER_NAME}" psql -U "${DB_USER}" -d "${DB_NAME}" < "${BACKUP_FILE}"

if [ $? -eq 0 ]; then
  echo "Restauration de la base de données ${DB_NAME} terminée avec succès."
  # Démarrer les services après restauration si nécessaire
  # docker-compose start backend frontend
else
  echo "Erreur lors de la restauration de la base de données ${DB_NAME}."
  exit 1
fi


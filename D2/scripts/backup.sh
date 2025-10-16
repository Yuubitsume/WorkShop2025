#!/bin/bash

# Variables d'environnement (à configurer ou passer en paramètre)
DB_CONTAINER_NAME="pra-si-database-1" # Nom du conteneur de la base de données
DB_NAME="${POSTGRES_DB:-mydatabase}"
DB_USER="${POSTGRES_USER:-user}"
BACKUP_DIR="/tmp/db_backups" # Répertoire local pour les sauvegardes (simulé)
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_${TIMESTAMP}.sql"

# Créer le répertoire de sauvegarde s'il n'existe pas
mkdir -p "${BACKUP_DIR}"

echo "Démarrage de la sauvegarde de la base de données ${DB_NAME}..."

# Exécuter pg_dump à l'intérieur du conteneur PostgreSQL
docker exec "${DB_CONTAINER_NAME}" pg_dump -U "${DB_USER}" -d "${DB_NAME}" > "${BACKUP_FILE}"

if [ $? -eq 0 ]; then
  echo "Sauvegarde de la base de données ${DB_NAME} terminée avec succès : ${BACKUP_FILE}"
  # Envoi vers un stockage distant (exemple avec AWS S3 CLI, nécessite configuration)
  # aws s3 cp "${BACKUP_FILE}" s3://your-s3-bucket/db_backups/
else
  echo "Erreur lors de la sauvegarde de la base de données ${DB_NAME}."
  exit 1
fi

# Supprimer les anciennes sauvegardes (ex: garder les 7 dernières)
find "${BACKUP_DIR}" -name "${DB_NAME}_*.sql" -type f -mtime +7 -delete

echo "Nettoyage des anciennes sauvegardes terminé."


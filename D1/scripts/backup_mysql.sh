#!/bin/bash

# Configuration
DB_USER="glpiuser"
DB_PASSWORD="glpipassword"
DB_NAME="glpidb"
BACKUP_DIR="/backups/glpi_mysql"
CONTAINER_NAME="mysql"

# Créer le répertoire de sauvegarde si inexistant
mkdir -p ${BACKUP_DIR}

# Nom du fichier de sauvegarde
DATE=$(date +%Y%m%d%H%M%S)
FILENAME="glpi_db_backup_${DATE}.sql.gz"

echo "Démarrage de la sauvegarde de la base de données GLPI..."

# Exécuter mysqldump dans le conteneur MySQL et compresser la sortie
docker exec ${CONTAINER_NAME} sh -c "exec mysqldump -u${DB_USER} -p${DB_PASSWORD} ${DB_NAME}" | gzip > ${BACKUP_DIR}/${FILENAME}

if [ $? -eq 0 ]; then
    echo "Sauvegarde de la base de données GLPI terminée avec succès : ${BACKUP_DIR}/${FILENAME}"
else
    echo "Erreur lors de la sauvegarde de la base de données GLPI."
    exit 1
fi

# Nettoyage des anciennes sauvegardes (ex: garder les 7 derniers jours)
find ${BACKUP_DIR} -type f -name "glpi_db_backup_*.sql.gz" -mtime +7 -delete

echo "Nettoyage des anciennes sauvegardes terminé."


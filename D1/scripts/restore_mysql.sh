#!/bin/bash

# Configuration
DB_USER="glpiuser"
DB_PASSWORD="glpipassword"
DB_NAME="glpidb"
BACKUP_DIR="/backups/glpi_mysql"
CONTAINER_NAME="mysql"

# Trouver la sauvegarde la plus récente
LATEST_BACKUP=$(ls -t ${BACKUP_DIR}/glpi_db_backup_*.sql.gz | head -1)

if [ -z "${LATEST_BACKUP}" ]; then
    echo "Aucune sauvegarde trouvée dans ${BACKUP_DIR}."
    exit 1
fi

echo "Démarrage de la restauration de la base de données GLPI à partir de : ${LATEST_BACKUP}"

# Décompresser et restaurer la base de données
gunzip < ${LATEST_BACKUP} | docker exec -i ${CONTAINER_NAME} sh -c "exec mysql -u${DB_USER} -p${DB_PASSWORD} ${DB_NAME}"

if [ $? -eq 0 ]; then
    echo "Restauration de la base de données GLPI terminée avec succès."
else
    echo "Erreur lors de la restauration de la base de données GLPI."
    exit 1
fi


#!/bin/bash

# Configuration
VELERO_VERSION="v1.13.0" # Vérifier la dernière version
CLOUD_PROVIDER="aws" # aws, azure, gcp, ou autre
BUCKET_NAME="pra-velero-backups-bucket" # Nom du bucket de sauvegarde (DOIT ÊTRE ACCESSIBLE)
REGION="eu-central-1" # Région du bucket

echo "-> Téléchargement de Velero CLI..."
wget https://github.com/vmware-tanzu/velero/releases/download/$VELERO_VERSION/velero-$VELERO_VERSION-linux-amd64.tar.gz
tar -xvf velero-$VELERO_VERSION-linux-amd64.tar.gz
sudo mv velero-$VELERO_VERSION-linux-amd64/velero /usr/local/bin/

echo "-> Création des identifiants (fichiers credentials.txt)"
# Ce fichier doit contenir les clés d'accès au stockage objet Cloud
# Le fichier 'credentials.txt' doit être sécurisé et préexistant
# Exemple AWS:
# [default]
# aws_access_key_id = XXXX
# aws_secret_access_key = YYYY

echo "-> Déploiement de Velero sur le cluster Kubernetes (Site B)"
velero install \
  --provider $CLOUD_PROVIDER \
  --plugins velero/velero-plugin-for-aws:v1.9.1 \
  --bucket $BUCKET_NAME \
  --backup-location-config region=$REGION \
  --secret-file ./credentials.txt # Utiliser le fichier de secrets pour les accès Cloud

echo "Installation de Velero terminée. Prêt pour la restauration."
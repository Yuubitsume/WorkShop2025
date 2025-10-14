# 🛡️ Plan de Reprise d'Activité (PRA) pour le SI Dockerisé

## 🎯 Objectif du Projet

Ce projet établit un **Plan de Reprise d'Activité (PRA)** complet pour l'ensemble du Système d'Information (SI) et de ses projets (microservices dockerisés). L'objectif est de garantir une **continuité de service rapide et fiable** suite à un sinistre majeur affectant le site de production principal (Site A).

Le PRA est basé sur une approche **Infrastructure as Code (IaC)** et **DevOps** pour automatiser la reconstruction et le déploiement sur un site de secours (Site B).

## 🛠️ Stack Technique

| Catégorie | Technologie | Rôle |
| :--- | :--- | :--- |
| **Orchestration** | **Kubernetes (K8s)** | Plateforme d'exécution et de Haute Disponibilité (HA) des conteneurs. |
| **IaC** | **Terraform** | Provisionnement de l'infrastructure de secours (Réseau, VMs, Stockage). |
| **Automatisation** | **Ansible** | Configuration fine du système (installation K8s, outils, sécurité). |
| **Sauvegarde K8s** | **Velero** | Sauvegarde de l'état du cluster (Ressources K8s, Persistent Volumes - PVs). |
| **Monitoring** | **Prometheus & Grafana** | Surveillance de la santé (*Health Status*), alertes et visualisation du SI. |
| **Conteneurisation** | **Docker** | Empaquetage des applications (microservices, bases de données, etc.). |

## 🔑 Principes Clés du PRA

1.  **Infrastructure as Code (IaC)** : Le Site de secours (B) est entièrement décrit par **Terraform** (provisionnement) et **Ansible** (configuration), garantissant la reproductibilité.
2.  **Sauvegarde 3-2-1** : Sauvegarde des données critiques et des configurations **hors site** (stockage objet Cloud) avec **Velero**.
3.  **Haute Disponibilité (HA)** : Tous les projets sont déployés sur K8s avec des **réplicas multiples** et l'utilisation de **Liveness/Readiness Probes**.
4.  **Processus Opérationnel** : La procédure de reprise est scriptée et documentée (`docs/SOP_PRA_Procedure.md`).

## 📈 Métriques Clés

* **RTO (Recovery Time Objective)** : Objectif de Temps de Reprise (ex: **< 2 heures**).
* **RPO (Recovery Point Objective)** : Objectif de Point de Reprise (ex: **< 15 minutes** de perte de données).
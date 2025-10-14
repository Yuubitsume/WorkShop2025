# Documentation de Défense aux Intrusions - Défi N°4 : Protego Maxima

## Introduction

Ce document présente une stratégie de défense aux intrusions pour protéger un système d'information, en réponse au défi N°4. L'objectif est de mettre en place des mesures de sécurité robustes et ingénieuses pour contrer les tentatives d'intrusion, en adoptant une approche de défense en profondeur.

## Principes de Défense en Profondeur

La stratégie repose sur le principe de la défense en profondeur, qui consiste à superposer plusieurs couches de sécurité. Si une couche est compromise, les couches suivantes doivent pouvoir détecter et bloquer l'attaque.

## Mesures de Défense Mises en Œuvre

### 1. Sécurité Périmétrique (Réseau)

*   **Pare-feu de Bordure (Firewall) :** Mise en place d'un pare-feu au niveau du réseau pour filtrer le trafic entrant et sortant. Seuls les ports et protocoles strictement nécessaires sont ouverts. Utilisation de règles strictes de filtrage par adresse IP et par service.
    *   **Ingéniosité :** Implémentation d'un système de *port knocking* pour les accès administratifs (SSH, RDP), rendant ces ports invisibles aux scanners externes jusqu'à une séquence spécifique de requêtes sur des ports fermés.
*   **Système de Détection et Prévention d'Intrusion (IDS/IPS) :** Déploiement d'un IDS/IPS (ex: Suricata, Snort) pour analyser le trafic réseau en temps réel, détecter les signatures d'attaques connues et bloquer les activités suspectes.
    *   **Ingéniosité :** Configuration de règles personnalisées basées sur l'analyse comportementale du trafic habituel du SI, permettant de détecter des anomalies spécifiques à l'environnement.

### 2. Sécurité des Hôtes (Serveurs et Conteneurs)

*   **Durcissement des Systèmes (Hardening) :** Application des meilleures pratiques de sécurité aux systèmes d'exploitation (Linux, Windows) et aux conteneurs Docker. Cela inclut la désactivation des services inutiles, la suppression des logiciels par défaut, la configuration de politiques de mots de passe robustes et la mise à jour régulière des systèmes.
    *   **Ingéniosité :** Utilisation de *Docker Content Trust* pour s'assurer que seules les images Docker signées et approuvées peuvent être déployées, empêchant l'exécution de conteneurs malveillants.
*   **Gestion des Vulnérabilités :** Utilisation d'outils de scan de vulnérabilités (ex: OpenVAS, Trivy pour les images Docker) pour identifier et corriger proactivement les failles de sécurité.
*   **Contrôle d'Accès :** Implémentation du principe du moindre privilège pour tous les utilisateurs et services. Utilisation de l'authentification forte (MFA) pour les accès sensibles.

### 3. Sécurité Applicative

*   **Pare-feu Applicatif Web (WAF) :** Déploiement d'un WAF (comme Nginx avec ModSecurity, mentionné dans le défi N°1) en amont des applications web pour protéger contre les attaques courantes (SQL Injection, XSS, CSRF, etc.).
    *   **Ingéniosité :** Configuration de règles WAF spécifiques aux applications développées, en plus des règles génériques, pour une protection ciblée contre les vulnérabilités connues de l'application.
*   **Tests de Sécurité Applicative (SAST/DAST) :** Intégration de tests de sécurité statiques (SAST) et dynamiques (DAST) dans le pipeline CI/CD pour détecter les vulnérabilités dès les premières phases de développement.

### 4. Surveillance et Réponse aux Incidents

*   **Gestion des Logs (SIEM) :** Centralisation et analyse des logs de tous les composants de l'infrastructure (systèmes, applications, pare-feu, IDS/IPS) via un système SIEM (ex: ELK Stack, Splunk). Cela permet de détecter les activités suspectes et de corréler les événements de sécurité.
    *   **Ingéniosité :** Mise en place de *honeypots* (leurres) sur le réseau pour attirer les attaquants et enregistrer leurs activités, fournissant des informations précieuses sur leurs techniques sans compromettre les systèmes réels.
*   **Plan de Réponse aux Incidents (PRI) :** Établissement d'un PRI détaillé, incluant les procédures de détection, d'analyse, de confinement, d'éradication, de récupération et de post-mortem en cas d'incident de sécurité.

## Documentation des Actions

Chaque mesure de défense mise en œuvre sera accompagnée d'une documentation technique détaillée, incluant :

*   La configuration des outils (pare-feu, IDS/IPS, WAF).
*   Les procédures de durcissement des systèmes.
*   Les règles de contrôle d'accès.
*   Les plans de surveillance et de réponse aux incidents.

Cette documentation sera présentée au conseil des ministres pour évaluation et attribution des points.

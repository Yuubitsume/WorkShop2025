# Sécurité de l'Infrastructure

La sécurité est un aspect fondamental de toute infrastructure de production. Pour ce projet Big Data DevOps, plusieurs couches de sécurité sont mises en œuvre pour protéger les services et les données.

## 1. Pare-feu / Sécurité Réseau

Nous avons choisi d'utiliser **Nginx comme reverse proxy sécurisé** et les **réseaux Docker** pour la segmentation et l'isolation. Ce choix est motivé par la flexibilité et l'intégration native avec l'environnement Docker.

### Nginx en Reverse Proxy Sécurisé

Nginx agit comme un point d'entrée unique et sécurisé pour toutes les requêtes externes. Ses fonctions de sécurité incluent :

-   **Terminaison SSL/TLS :** Toutes les communications externes sont chiffrées via HTTPS. Nginx gère les certificats SSL (auto-signés pour cet environnement de développement/test, mais des certificats émis par une autorité de certification seraient utilisés en production).
-   **Filtrage de base :** Nginx peut être configuré pour limiter les requêtes, bloquer certaines adresses IP ou patterns de requêtes malveillantes, et protéger contre les attaques DDoS de base.
-   **Masquage des services internes :** Les services internes (GLPI, Grafana, Elasticsearch) ne sont pas directement exposés à Internet, réduisant ainsi leur surface d'attaque.

### Segmentation Réseau avec Docker

L'utilisation de réseaux Docker personnalisés (`frontend-net`, `backend-net`, `data-net`) permet une isolation logique des services :

-   **`frontend-net` :** Contient Nginx et les services accessibles via Nginx (GLPI, Grafana, Elasticsearch/Kibana). Seul Nginx est exposé au réseau externe.
-   **`backend-net` :** Contient les services internes qui communiquent entre eux (Elasticsearch, Cassandra, Prometheus). Nginx peut communiquer avec ces services via ce réseau.
-   **`data-net` :** (Optionnel, pour une isolation plus stricte) Peut être utilisé pour la communication inter-nœuds des bases de données (Elasticsearch, Cassandra), isolant ainsi le trafic de données du trafic applicatif.

Cette segmentation garantit que seuls les services autorisés peuvent communiquer entre eux, limitant la propagation d'éventuelles compromissions.

## 2. Règles de Filtrage et Ports Ouverts

Au niveau de l'hôte Docker, seuls les ports 80 (HTTP, redirigé) et 443 (HTTPS) sont ouverts pour permettre l'accès à Nginx. Tous les autres ports des conteneurs sont internes aux réseaux Docker et ne sont pas exposés directement à l'extérieur.

-   **Ports exposés sur l'hôte :**
    -   `80/tcp` (HTTP, redirigé vers HTTPS)
    -   `443/tcp` (HTTPS)

-   **Ports internes aux réseaux Docker :**
    -   `GLPI:80`
    -   `Grafana:3000`
    -   `Elasticsearch:9200, 9300`
    -   `Cassandra:7000, 7001, 7199, 9042`
    -   `Prometheus:9090`
    -   `MySQL:3306`

## 3. Authentification Sécurisée

Une authentification robuste est essentielle pour protéger l'accès aux interfaces de gestion et aux données.

### GLPI

GLPI gère sa propre authentification utilisateur. Il est recommandé de configurer :

-   **Mots de passe forts :** Imposer des politiques de mots de passe complexes.
-   **HTTPS :** L'accès à GLPI se fait via Nginx en HTTPS, garantissant la confidentialité des identifiants.
-   **Authentification externe :** GLPI supporte l'intégration avec des annuaires LDAP/Active Directory pour une gestion centralisée des utilisateurs.

### Grafana

Grafana offre plusieurs mécanismes d'authentification :

-   **Authentification par base de données interne :** Utilisateurs et mots de passe stockés dans Grafana.
-   **Intégration LDAP/OAuth :** Pour une authentification centralisée.
-   **HTTPS :** L'accès à Grafana se fait via Nginx en HTTPS.
-   **Certificats auto-signés :** Pour l'environnement de développement, des certificats auto-signés sont utilisés. En production, des certificats émis par une autorité de certification sont indispensables.

### Elasticsearch

Elasticsearch nécessite une attention particulière pour la sécurité. Pour un environnement de production, l'utilisation de **X-Pack Security** (ou une alternative open-source comme Search Guard/Open Distro for Elasticsearch) est cruciale. Pour cet environnement de développement, nous nous concentrons sur les bases :

-   **HTTPS :** L'accès à l'API Elasticsearch via Nginx se fait en HTTPS.
-   **Authentification de base :** X-Pack Security permet de configurer des utilisateurs et des rôles, ainsi que l'authentification par nom d'utilisateur/mot de passe.
-   **Contrôle d'accès basé sur les rôles (RBAC) :** Définir des rôles avec des privilèges spécifiques pour limiter l'accès aux indices et aux opérations.
-   **Chiffrement des communications :** Chiffrement des communications inter-nœuds et client-nœud.

**Note :** Pour une implémentation complète de la sécurité Elasticsearch en production, il serait nécessaire d'activer X-Pack Security (ou équivalent) et de configurer les utilisateurs, les rôles et les certificats de manière approfondie.

# 📜 CAHIER DES CHARGES FONCTIONNEL : REGISTRE MAGIQUE PÉDAGOGIQUE (RMP) - L'HOROLOGIUM

## Projet : Transformation Digitale de l'Emploi du Temps et de la Gestion de Présence
### Thème : Transformation digitale d’un outil emblématique de Poudlard (Le Tableau d'Affichage Enchanté)
### Auteur : [Votre Nom] — EPSI Consultant Sorcier

---

## 1. Contexte général

Depuis plus de mille ans, Poudlard gère l'organisation de ses cours via des supports physiques traditionnels : tableaux d'affichage enchantés, parchemins et registres de présence. 
Cependant, l’ère moderne — portée par les nouvelles technologies magiques et numériques — appelle à une refonte profonde de ces outils ancestraux.

Le Conseil des Sorciers souhaite initier un grand chantier de **transformation digitale** afin de moderniser ses outils administratifs et logistiques. 
Le premier projet prioritaire identifié est la **digitalisation de l'Emploi du Temps et de l'Assiduité**, sous le nom de projet **“Registre Magique Pédagogique (RMP) - L'Horologium”**. Cet outil doit devenir le point central de la vie scolaire pour les élèves et les professeurs.

---

## 2. Description de l’outil existant

### 2.1 Fonction et usage actuel
L'*Horologium* (Tableau d'Affichage/Registre) est actuellement un ensemble de **registres et tableaux physiques, souvent désynchronisés**.
- Les élèves consultent l'emploi du temps sur le tableau d'affichage de leur Maison ou de la Grande Salle.
- Les professeurs gèrent la présence via un **Registre de Parchemins Enchantés**.

Les utilisateurs peuvent actuellement :
- Consulter l'heure et la salle des cours.
- Signaler des changements manuels d'horaire (par les Préfets).
- Vérifier la présence (Professeurs uniquement).

### 2.2 Problématiques actuelles
L'outil présente de nombreuses limites, rendant l'organisation scolaire inefficace :
- **Accès dispersé et statique** : l'information n'est pas personnalisée ni accessible à distance.
- **Erreurs d'assiduité** : le registre de présence physique est susceptible d'oublis ou de fraudes.
- **Mises à jour lentes** : un changement de salle ou d'horaire n'est pas propagé instantanément, causant des retards ou des confusions (ex: salles mouvantes).
- **Aucune personnalisation** selon le profil de l’élève (Maison, spécialité).
- **Aucune interconnexion** avec les notes, les ressources pédagogiques ou les systèmes de sécurité (couvre-feu).

---

## 3. Analyse des Besoins et Enquête Utilisateur (EAB)

Pour garantir la pertinence du projet, une enquête a été menée auprès des parties prenantes, soulignant la nécessité d'un outil central d'organisation.

### 3.1. Méthodologie d'Enquête
* **Cible :** 50 élèves (toutes Maisons et Années), 15 professeurs (divers départements), 5 membres de la Direction/Administration.
* **Format :** Entretiens qualitatifs et questionnaires ciblés sur les irritants liés aux changements d'horaires et à l'appel.

### 3.2. Synthèse des Besoins et Retours Clés
| Parties Prenantes | Problématiques/Besoins Clés | Exigence Fonctionnelle Associée |
| :--- | :--- | :--- |
| **Élèves** | Confusion dans les changements d'horaires ; besoin de savoir où est le prochain cours instantanément ; **preuve de présence numérique (style Edusign)**. | **RMP (F-11) :** Emploi du Temps Dynamique. **RMP (F-12) :** Validation de Présence Magique. |
| **Enseignants** | Perte de temps à faire l'appel ; besoin d'un tableau de bord de classe rapide ; facilité de signalement d'absence. | **RMP (F-12) :** Automatisation de l'appel. **RMP (F-13) :** Rapports d'Assiduité. |
| **Direction/Admin.** | Manque de statistiques fiables sur l'assiduité ; traçabilité des données d'horaire et de présence non sécurisée ; besoin de notifier les parents. | **RMP (F-13) :** Rapports et Statistiques. **RMP (F-14) :** Sécurité Blockchain des données. |

---

## 4. Objectifs de la transformation digitale

### 4.1 Objectif principal
Concevoir une **solution numérique innovante** permettant de **centraliser la gestion de l'Emploi du Temps, de l'Assiduité et de l'organisation scolaire**. L'outil devra fonctionner comme un système de planification de ressources d'entreprise (ERP) magique, alliant **ergonomie, sécurité et fiabilité des données**.

### 4.2 Objectifs secondaires
- Offrir un accès **personnalisé et en temps réel** à l'emploi du temps de chaque utilisateur (élève ou professeur). 
- **Automatiser la gestion de présence** (F-12) en utilisant la technologie de géolocalisation et d'authentification magique.
- Assurer la **traçabilité infalsifiable** des données de présence et d'horaire via une **Blockchain Magique**.
- Permettre l'interconnexion avec d'autres systèmes (notes, sécurité du château).

---

## 5. Présentation du nouveau système : *RMP - L'Horologium*

Le **RMP - L'Horologium** est une **application magique numérique** (Mobile/Web) qui agit comme le tableau de bord central de la vie scolaire.

### 5.1 Architecture fonctionnelle
- **Interface utilisateur magique (UI)** : inspirée des horloges astronomiques et des cartes enchantées (DA Harry Potter).
- **Authentification biomagique** : reconnaissance de la baguette et de l'empreinte magique. 
- **Backend ERP (Odoo)** : Gère la logique de l'Emploi du Temps, les affectations de salles et les registres de présence.
- **Moteur de Géolocalisation** : Utilisation du réseau Wi-Fi/Magie du château pour localiser les utilisateurs pour la validation de présence.
- **Module Contenu Pédagogique (optionnel)** : Intégration d'un accès léger au *Livre des Sorts* pour consultation rapide des manuels liés au cours.

### 5.2 Exemples d’interactions
- L'élève ouvre l'application : l'écran affiche son **Emploi du Temps** avec le cours actuel, la salle et un itinéraire suggéré.
- En arrivant en classe, le professeur déclenche l'appel (sortilège *'Accio Présence'*) sur son terminal. L'application valide la présence des élèves connectés **ET** géolocalisés dans la salle (F-12).
- En cas de changement de salle (salle mouvante, métamorphose), l'EDT est mis à jour en **temps réel** pour tous les élèves concernés, avec une **notification push enchantée**.

---

## 6. Fonctionnalités principales

| N° | Fonctionnalité | Description | Objectif |
|----|----------------|-------------|-----------|
| **1** | **Emploi du Temps Dynamique (F-11)** | Affichage personnalisé et en temps réel des cours, des salles, des changements d'horaires et du statut de l'enseignant. | Organisation élève/professeur |
| **2** | **Validation de Présence Magique (F-12)** | Système d'appel automatisé par géolocalisation (W-Fi magique) et authentification biomagique de l'élève. (Style Edusign). | Automatisation de l'appel |
| **3** | **Rapports d'Assiduité Sécurisés (F-13)** | Tableau de bord pour la Direction et les Professeurs, listant les absences et retards, avec alertes automatiques. | Suivi administratif fiable |
| **4** | **Sécurité Blockchain (F-14)** | Les données de présence, de retards et les changements d'EDT sont horodatés et tracés sur la Blockchain Magique. | Intégrité et fiabilité des données |
| **5** | **Gestion des Salles Mobiles** | API de connexion aux systèmes d'architecture mouvante pour mettre à jour la localisation des salles en temps réel. | Logistique fiable |
| **6** | **Espace Notes et Bulletins** | Consultation sécurisée des notes des élèves (B.U.S.E., A.S.P.I.C.) et des commentaires des professeurs. | Suivi pédagogique |
| **7** | **Communication Parentale** | Portail sécurisé pour les parents/tuteurs afin de consulter l'EDT et l'assiduité de leur enfant. | Transparence |
| **8** | **Notifications Enchantées** | Alertes push personnalisées en cas de cours annulé, de changement de salle ou de menace de sécurité. | Engagement et sécurité |

---

## 7. Contraintes techniques

| Domaine | Contraintes |
|----------|-------------|
| **Sécurité** | Authentification magique multi-facteurs. Respect du **Règlement Général sur la Protection des Informations Magiques (RGPIM)**. |
| **Compatibilité** | Fonctionne sur tablettes enchantées, miroirs connectés et terminaux mobiles classiques. |
| **Performance** | Temps de chargement instantané de l'EDT. Latence maximale de 2 secondes pour la validation de présence (F-12). |
| **Backend** | Utilisation de **Python (Odoo 18)** pour le cœur ERP de gestion de l'EDT et de la présence. |
| **Évolutivité** | Possibilité d'intégrer des modules futurs (gestion des événements de Quidditch, sorties à Pré-au-Lard). |

---

## 8. Technologies pressenties

- **Backend (Cœur RMP) :** Python (Odoo 18), PostgreSQL.
- **Frontend :** React Native / Flutter (pour la portabilité sur terminaux magiques et mobiles).
- **Blockchain :** Solution privée (Hyperledger Sorcerus) pour l'intégrité du registre de présence et des notes.
- **Géolocalisation :** Réseau propriétaire Wi-Fi/Magie du château (similaire au GPS, mais basé sur les champs magiques).
- **IA Magique :** Moteur d'optimisation de l'EDT pour éviter les conflits d'horaires et les trajets trop longs.

---

## 9. Enjeux pédagogiques et humains

Le projet vise à :
- **Optimiser la logistique** et l'organisation du temps de tous les acteurs.
- **Fiabiliser les données d'assiduité** pour un meilleur suivi pédagogique (lutte contre le décrochage magique).
- **Simplifier le travail des professeurs** en automatisant les tâches administratives chronophages (appel).
- **Créer un environnement d'apprentissage plus serein** grâce à la clarté de l'organisation.

L’adoption de cet outil sera accompagnée de **sessions de formation enchantée** pour le personnel et les élèves.

---

## 10. Dimension commerciale

### 10.1 Marché cible
- Écoles de sorcellerie européennes et internationales (Beauxbâtons, Durmstrang) : pour une vente de licence.
- Ministères de la Magie : pour l'audit et l'accès API aux données d'assiduité.

### 10.2 Modèle économique
- **Licence annuelle par établissement (Modèle SaaS - Software as a Spell)** : basée sur le nombre d'élèves.
- **Licence API RMP Premium** : Vente d'accès sécurisé aux données d'assiduité et d'horaire.
- **Offres de Support et Maintenance Magique** : Contrats de niveau de service (SLA) pour garantir la disponibilité à 99.9%.

### 10.3 Avantages concurrentiels
- Première solution de gestion de l'EDT/Présence **intégrée et certifiée Blockchain** dans le monde magique.
- Solution conçue pour des environnements complexes (salles mouvantes, géolocalisation magique).
- Associée à l'image d'excellence et de modernisation de Poudlard.

---

## 11. Indicateurs de réussite

| Indicateur | Cible |
|-------------|--------|
| Taux d’adoption des professeurs | ≥ 95 % |
| Temps moyen pour faire l'appel (F-12) | < 10 secondes |
| Taux de fiabilité des données d'assiduité | 100% (via Blockchain) |
| Taux de satisfaction globale | ≥ 9/10 |
| Réduction des erreurs de salle/retards | -75 % |

---

## 12. Planning prévisionnel

| Étape | Délai | Responsable |
|--------|--------|--------------|
| Étude et maquettage (UX/UI Horologium) | Semaine 1–2 | Équipe EPSI |
| Développement Prototype RMP (EDT, Présence F-11/F-12) | Semaine 3–7 | Pôle Dev & Data |
| Intégration Blockchain et API Salles Mobiles | Semaine 8–9 | Pôle Sécurité Magique |
| Test utilisateurs (professeurs & élèves) | Semaine 10 | Conseil des Sorciers |
| Lancement officiel | Semaine 11 | Direction Poudlard |

---

## 13. Conclusion

Le projet **RMP - L'Horologium** symbolise la transition de Poudlard vers une gestion logistique **proactive et numérique**. En faisant de l'Emploi du Temps l'outil central, il répond directement aux besoins de clarté, d'organisation et de sécurité exprimés par l'ensemble de la communauté scolaire.

> “EPSI — Where Magic Meets Technology”

---

📄 **Auteur :** [Votre Nom]
**École :** EPSI
**Défi :** Oculus Reparo N°10
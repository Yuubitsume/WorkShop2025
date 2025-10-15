// lib/data/qcm_data.dart
import 'package:tri_des_sorciers/models/question.dart';
import 'package:tri_des_sorciers/models/sorcier_type.dart';

// --- I. LES TYPES DE SORCIERS ---

final alchimiste = SorcierType(
  nom: 'L\'Alchimiste Runique',
  description: 'Vous êtes un maître de la logique, de la formule et de la précision. La magie est une science pour vous.',
  couleurHex: '0xFF0077B6', // Bleu profond
  imagePath: 'alchimiste.png',
);

final mystique = SorcierType(
  nom: 'Le Mystique Éthéré',
  description: 'Vous vous fiez à l\'intuition et au lien avec le cosmos. Votre magie est imprévisible et puisée dans les émotions.',
  couleurHex: '0xFFD90429', // Rouge vif
  imagePath: 'mystique.png',
);

final chronomancien = SorcierType(
  nom: 'Le Chronomancien',
  description: 'Obsédé par le temps et les conséquences, vous manipulez les probabilités. L\'organisation est votre force.',
  couleurHex: '0xFFF77F00', // Orange/Or
  imagePath: 'chronomancien.png',
);

final sauvage = SorcierType(
  nom: 'L\'Enchanteur Sauvage',
  description: 'Vous êtes fusionné avec la nature brute et les éléments. Votre magie est impulsive, puissante et indomptable.',
  couleurHex: '0xFF2B9348', // Vert forêt
  imagePath: 'sauvage.png',
);

final List<SorcierType> typesDeSorciers = [alchimiste, mystique, chronomancien, sauvage];

// --- II. LES 20 QUESTIONS DU QCM ---
// Chaque réponse attribue des points {Type: Points}

final List<Question> qcmQuestions = [
  // ===============================================
  // 1. Catégorie : SITUATION (Dilemmes d'urgence)
  // ===============================================
  
  // Q1 : Situation - Urgence Magique (Déjà fournie)
  Question(
    texte: "Un sort tourne mal. Que faites-vous en premier ?",
    reponses: [
      Reponse(texte: "Analyser la défaillance et chercher l'antidote exact.", points: {alchimiste.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "Tenter d'absorber l'énergie chaotique par la volonté pure.", points: {mystique.nom: 3, sauvage.nom: 1}),
      Reponse(texte: "Reconstruire mentalement la chaîne des événements pour trouver l'erreur.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "Lâcher une décharge élémentaire pour noyer le sort défectueux.", points: {sauvage.nom: 3, mystique.nom: 1}),
    ],
  ),
  
  // Q2 : Situation - Le Portail Instable
  Question(
    texte: "Face à un portail dimensionnel instable, vous devez réagir immédiatement :",
    reponses: [
      Reponse(texte: "Tenter un ajustement de fréquence précis pour le stabiliser.", points: {alchimiste.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "Provoquer une surcharge énergétique pour le fermer brutalement.", points: {sauvage.nom: 3, mystique.nom: 1}),
      Reponse(texte: "Chercher l'origine temporelle de l'instabilité.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "Communiquer avec l'énergie du portail pour le calmer.", points: {mystique.nom: 3, sauvage.nom: 1}),
    ],
  ),
  
  // Q3 : Situation - Créature Bannie
  Question(
    texte: "Une créature interdite vous attaque. Comment gérez-vous le combat ?",
    reponses: [
      Reponse(texte: "Étudier ses faiblesses organiques et créer un venin ciblé.", points: {alchimiste.nom: 3, sauvage.nom: 1}),
      Reponse(texte: "Lancer un sort de confusion basé sur ses peurs profondes.", points: {mystique.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "Bloquer le temps autour d'elle pour la paralyser temporairement.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "Libérer une rafale de foudre ou de feu pur.", points: {sauvage.nom: 3, mystique.nom: 1}),
    ],
  ),

  // Q4 : Situation - Le Grimoire Maudit
  Question(
    texte: "Vous trouvez un grimoire maudit. Quel est votre premier geste ?",
    reponses: [
      Reponse(texte: "L'isoler dans un champ de force hermétique pour l'analyser.", points: {alchimiste.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "Le brûler immédiatement pour stopper la contagion magique.", points: {sauvage.nom: 3, mystique.nom: 1}),
      Reponse(texte: "Faire un saut temporel pour observer son créateur.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "Le toucher pour en décoder l'histoire par intuition.", points: {mystique.nom: 3, sauvage.nom: 1}),
    ],
  ),
  
  // Q5 : Situation - Dilemme Moral Rapide
  Question(
    texte: "Un ennemi menace votre allié. Vous avez 3 secondes pour agir :",
    reponses: [
      Reponse(texte: "Créer un leurre visuel pour attirer le regard de l'ennemi.", points: {mystique.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "Invoquer un bouclier élémentaire massif.", points: {sauvage.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "Calculer la trajectoire et le lancer d'un projectile non létal.", points: {alchimiste.nom: 3, sauvage.nom: 1}),
      Reponse(texte: "Tirer votre allié hors de la ligne de temps actuelle.", points: {chronomancien.nom: 3, mystique.nom: 1}),
    ],
  ),
  
  // ===============================================
  // 2. Catégorie : PHILOSOPHIE (Source de la magie)
  // ===============================================

  // Q6 : Philosophie - Source de la Magie (Déjà fournie)
  Question(
    texte: "Selon vous, quelle est la source ultime de la magie ?",
    reponses: [
      Reponse(texte: "Les lois fondamentales de l'Univers, réductibles en formules.", points: {alchimiste.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "L'énergie invisible du cosmos et des êtres spirituels.", points: {mystique.nom: 3, sauvage.nom: 1}),
      Reponse(texte: "Les échos des grands événements passés et futurs.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "La force brute des éléments et la vie sauvage.", points: {sauvage.nom: 3, mystique.nom: 1}),
    ],
  ),

  // Q7 : Philosophie - La plus grande Vertu
  Question(
    texte: "Quelle est la plus grande vertu d'un sorcier ?",
    reponses: [
      Reponse(texte: "La Précision immuable dans l'exécution des rituels.", points: {alchimiste.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "L'Empathie profonde envers toutes les formes de vie.", points: {mystique.nom: 3, sauvage.nom: 1}),
      Reponse(texte: "La Patience d'attendre le moment parfait.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "Le Courage de braver l'inconnu sans peur.", points: {sauvage.nom: 3, mystique.nom: 1}),
    ],
  ),

  // Q8 : Philosophie - L'Échec
  Question(
    texte: "Que représente l'échec pour vous ?",
    reponses: [
      Reponse(texte: "Une déviation mesurable par rapport aux résultats attendus.", points: {alchimiste.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "Une leçon émotionnelle douloureuse mais nécessaire.", points: {mystique.nom: 3, sauvage.nom: 1}),
      Reponse(texte: "Une variable historique à analyser et à ne jamais répéter.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "Une preuve que la magie était trop contenue, pas assez libre.", points: {sauvage.nom: 3, mystique.nom: 1}),
    ],
  ),

  // Q9 : Philosophie - Le Secret
  Question(
    texte: "Comment traitez-vous un secret magique ancien et dangereux ?",
    reponses: [
      Reponse(texte: "Je le déconstruis, documente et le rend inoffensif.", points: {alchimiste.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "Je le scelle avec une force émotionnelle pour qu'il soit protégé.", points: {mystique.nom: 3, sauvage.nom: 1}),
      Reponse(texte: "Je l'archive dans une séquence temporelle non accessible.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "Je l'ensevelis sous la terre pour que la nature le purifie.", points: {sauvage.nom: 3, mystique.nom: 1}),
    ],
  ),

  // Q10 : Philosophie - Le But Ultime
  Question(
    texte: "Quel est le but ultime de votre pratique magique ?",
    reponses: [
      Reponse(texte: "Comprendre et maîtriser chaque variable de l'existence.", points: {alchimiste.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "L'union spirituelle avec le plan supérieur (l'éther).", points: {mystique.nom: 3, sauvage.nom: 1}),
      Reponse(texte: "Assurer la stabilité et l'équilibre de la ligne de temps.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "Vivre en harmonie avec le monde, sans artifices ni contraintes.", points: {sauvage.nom: 3, mystique.nom: 1}),
    ],
  ),

  // ===============================================
  // 3. Catégorie : OUTIL (Artefacts et ressources)
  // ===============================================

  // Q11 : Outil - Artefact de Combat
  Question(
    texte: "Quel artefact magique préférez-vous emporter au combat ?",
    reponses: [
      Reponse(texte: "Une fiole d'un puissant acide alchimique à effet rapide.", points: {alchimiste.nom: 3, sauvage.nom: 1}),
      Reponse(texte: "Un pendule divinatoire pour anticiper les mouvements de l'ennemi.", points: {mystique.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "Un médaillon capable de stocker une minute de temps.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "Un bâton en chêne brut qui canalise les forces du vent et du feu.", points: {sauvage.nom: 3, mystique.nom: 1}),
    ],
  ),

  // Q12 : Outil - Réunion de Sorciers
  Question(
    texte: "Lors d'une réunion, vous préférez consulter :",
    reponses: [
      Reponse(texte: "Un tableau de statistiques complexes sur la magie étudiée.", points: {alchimiste.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "Les prophéties anciennes et les visions collectives.", points: {mystique.nom: 3, sauvage.nom: 1}),
      Reponse(texte: "Le registre historique des réussites et échecs passés.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "Les signaux envoyés par les esprits animaux ou végétaux.", points: {sauvage.nom: 3, mystique.nom: 1}),
    ],
  ),

  // Q13 : Outil - Le Livre
  Question(
    texte: "Votre bibliothèque contient principalement :",
    reponses: [
      Reponse(texte: "Des manuels de formule et des traités de transmutation.", points: {alchimiste.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "Des carnets personnels remplis d'expériences et de rêves.", points: {mystique.nom: 3, sauvage.nom: 1}),
      Reponse(texte: "Des chroniques détaillées de l'histoire magique et politique.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "Des herbiers et des encyclopédies sur les propriétés des plantes.", points: {sauvage.nom: 3, mystique.nom: 1}),
    ],
  ),

  // Q14 : Outil - Votre atelier/Laboratoire
  Question(
    texte: "L'élément le plus important dans votre laboratoire est :",
    reponses: [
      Reponse(texte: "La balance de précision pour mesurer les ingrédients critiques.", points: {alchimiste.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "Un puits de lumière pour la méditation et l'introspection.", points: {mystique.nom: 3, sauvage.nom: 1}),
      Reponse(texte: "Un immense calendrier ou un chronographe d'événements.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "Un foyer ouvert où le bois et les herbes brûlent sans contrainte.", points: {sauvage.nom: 3, mystique.nom: 1}),
    ],
  ),

  // Q15 : Outil - La Rune
  Question(
    texte: "Si vous deviez graver une rune pour vous définir, ce serait celle de :",
    reponses: [
      Reponse(texte: "L'Équation, symbolisant la vérité mathématique.", points: {alchimiste.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "L'Onde, symbolisant l'énergie fluctuante.", points: {mystique.nom: 3, sauvage.nom: 1}),
      Reponse(texte: "La Spirale, symbolisant le déroulement des âges.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "La Racine, symbolisant le lien à la terre et la croissance.", points: {sauvage.nom: 3, mystique.nom: 1}),
    ],
  ),

  // ===============================================
  // 4. Catégorie : RELATION (Interaction sociale)
  // ===============================================

  // Q16 : Relation - Collaboration
  Question(
    texte: "Lorsque vous collaborez, vous vous concentrez sur :",
    reponses: [
      Reponse(texte: "La répartition logique des tâches pour maximiser l'efficacité.", points: {alchimiste.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "La synchronisation émotionnelle et l'harmonie du groupe.", points: {mystique.nom: 3, sauvage.nom: 1}),
      Reponse(texte: "La planification méticuleuse et le respect strict du calendrier.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "L'échange instinctif et la liberté de chaque membre.", points: {sauvage.nom: 3, mystique.nom: 1}),
    ],
  ),

  // Q17 : Relation - Conseil
  Question(
    texte: "Un jeune sorcier vient vous demander conseil, vous lui recommandez de :",
    reponses: [
      Reponse(texte: "Tester, documenter et répliquer ses sorts jusqu'à la perfection.", points: {alchimiste.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "Faire confiance à sa première intuition et ne pas trop penser.", points: {mystique.nom: 3, sauvage.nom: 1}),
      Reponse(texte: "Étudier l'histoire pour éviter les erreurs passées.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "Passer du temps seul dans la nature pour se purifier.", points: {sauvage.nom: 3, mystique.nom: 1}),
    ],
  ),

  // Q18 : Relation - Conflit
  Question(
    texte: "Comment résolvez-vous un conflit avec un autre sorcier ?",
    reponses: [
      Reponse(texte: "Par un débat logique et une démonstration factuelle.", points: {alchimiste.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "Par un échange d'énergies pour sentir sa vérité.", points: {mystique.nom: 3, sauvage.nom: 1}),
      Reponse(texte: "En rappelant les conséquences historiques de la discorde.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "Par un test de force physique ou magique (Sauvage).", points: {sauvage.nom: 3, mystique.nom: 1}),
    ],
  ),

  // Q19 : Relation - Le Partage
  Question(
    texte: "Si vous découvrez un nouveau sort, vous le :",
    reponses: [
      Reponse(texte: "Publiez dans un traité chiffré pour la communauté Alchimiste.", points: {alchimiste.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "Partagez avec ceux qui en ont le plus besoin émotionnellement.", points: {mystique.nom: 3, sauvage.nom: 1}),
      Reponse(texte: "Consignez d'abord dans les archives pour les générations futures.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "Utilisez pour protéger une zone sauvage sans le documenter.", points: {sauvage.nom: 3, mystique.nom: 1}),
    ],
  ),
  
  // Q20 : Relation - Alliance (Déjà fournie)
  Question(
    texte: "Comment gérez-vous une alliance avec un être non-magique ?",
    reponses: [
      Reponse(texte: "Par un contrat écrit, clair et irrévocable.", points: {chronomancien.nom: 3, alchimiste.nom: 1}),
      Reponse(texte: "En partageant une vision ou une expérience émotionnelle.", points: {mystique.nom: 3, sauvage.nom: 1}),
      Reponse(texte: "En lui démontrant les bénéfices logiques et les risques.", points: {alchimiste.nom: 3, chronomancien.nom: 1}),
      Reponse(texte: "Par le respect mutuel et la protection du territoire.", points: {sauvage.nom: 3, mystique.nom: 1}),
    ],
  ),
];

// --- III. LOGIQUE DE TRI ---

SorcierType determinerSorcier(Map<String, int> scores) {
  String meilleurType = '';
  int meilleurScore = -1;

  // 1. Trouver le type avec le score le plus élevé
  scores.forEach((typeNom, score) {
    if (score > meilleurScore) {
      meilleurScore = score;
      meilleurType = typeNom;
    }
  });

  // 2. Gérer le cas d'égalité (simplifié, privilégie le premier trouvé)
  
  return typesDeSorciers.firstWhere((type) => type.nom == meilleurType);
}
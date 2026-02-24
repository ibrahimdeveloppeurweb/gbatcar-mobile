# 📋 SELLOVIA - IMPLÉMENTATION FONCTIONNALITÉS MANQUANTES

## ✅ PHASE 1 COMPLÉTÉE - Corrections Urgentes

### Fichiers créés/modifiés :

1. **dashboard_screen_enhanced.dart** ✅
   - ✅ Case dorée bonus fidélité (première case avec gradient or)
   - ✅ Message "BONUS FIDÉLITÉ" sous la grille
   - ✅ Compteur 3 cycles Élite (1/3, 2/3, 3/3)
   - ✅ Bouton "Réclamer ma récompense" (ouvre WhatsApp admin)
   - ✅ Message partage amélioré avec Share.share()

2. **wheel_screen_enhanced.dart** ✅
   - ✅ Timer dynamique vers prochain dimanche
   - ✅ Détection si c'est dimanche ou non
   - ✅ Overlay "ROUE VERROUILLÉE" si pas dimanche ou < 2 parrainages
   - ✅ Barre de progression 2 parrainages
   - ✅ Bouton "Partager ma chance" après avoir gagné

3. **pubspec.yaml** ✅
   - ✅ Ajout dépendance `share_plus: ^10.0.3`

---

## 📦 INSTALLATION

### Étape 1 : Installer les dépendances

```bash
cd C:\Users\cisse\StudioProjects\project
flutter pub get
```

### Étape 2 : Remplacer les fichiers

**Option A** : Utiliser les fichiers Enhanced (recommandé)

Renommer les fichiers :
```
dashboard_screen_enhanced.dart → dashboard_screen.dart
wheel_screen_enhanced.dart → wheel_screen.dart
```

**Option B** : Garder les deux versions

Les fichiers `_enhanced.dart` sont les nouvelles versions améliorées.
Les fichiers originaux sont conservés en backup.

### Étape 3 : Tester l'application

```bash
flutter run
```

---

## 🎯 CE QUI A ÉTÉ IMPLÉMENTÉ

### 1. ⭐ Case Dorée Bonus Fidélité

**Où** : Dashboard → Grille 20/35 cases

**Comment ça marche** :
- Si `user.bonusFidelite == true`, la case 1 a un gradient doré
- Message explicatif sous la grille
- L'étoile ⭐ apparaît dans la case

**Code clé** :
```dart
final isBonus = (index == 0 && user.bonusFidelite);
gradient: isBonus && isCompleted
  ? const LinearGradient(
      colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
    )
```

---

### 2. 🏆 Compteur 3 Cycles Élite

**Où** : Dashboard → Après la grille (UNIQUEMENT pour parcours Élite)

**Affiche** :
- Cycle 1 : ✅ COMPLÉTÉ ou 🔄 EN COURS ou 🔒 VERROUILLÉ
- Cycle 2 : Même chose
- Cycle 3 : Même chose + bonus Tecno

**Variables nécessaires** :
```dart
user.cycleCount // 0, 1, 2, ou 3
user.parcours == 'elite'
```

---

### 3. 📱 Bouton Réclamer Récompense

**Où** : Dashboard → S'affiche quand `currentScore >= targetScore`

**Action** :
- Ouvre WhatsApp avec message pré-rempli
- Numéro admin : +2250707070707
- Message inclut nom, ID, parcours

**Code** :
```dart
final uri = Uri.parse('https://wa.me/$phone?text=$message');
await launchUrl(uri, mode: LaunchMode.externalApplication);
```

---

### 4. 📤 Message Partage Amélioré

**Où** : Dashboard → Bouton "Partager"

**Nouveau message** :
```
🎁 Rejoins-moi sur SELLOVIA ! 🎁

Tu peux gagner une MONTRE DE LUXE (25 000F) en parrainant 20 amis !

Comment ça marche ?
1️⃣ Tu paies 500F une fois
2️⃣ Tu partages ton lien à 20 personnes
3️⃣ Tu reçois ta montre GRATUITEMENT ! ⌚

Bonus : Gagne aussi de l'argent RÉEL en devenant Ambassadeur (100F par filleul) 💰

👉 Clique ici pour t'inscrire :
[LIEN_UTILISATEUR]

À bientôt ! 🚀
```

---

### 5. ⏰ Timer Prochain Dimanche

**Où** : Wheel Screen → En haut

**Affiche** :
- Si dimanche : "🎰 DISPONIBLE MAINTENANT !"
- Sinon : "Prochain : 4j 15h 23min"

**Code clé** :
```dart
Duration _calculateTimeUntilSunday() {
  final now = DateTime.now();
  if (now.weekday == DateTime.sunday) return Duration.zero;
  
  int daysUntilSunday = (DateTime.sunday - now.weekday) % 7;
  final nextSunday = DateTime(now.year, now.month, now.day + daysUntilSunday, 0, 1);
  return nextSunday.difference(now);
}
```

---

### 6. 🔒 Roue Verrouillée

**Où** : Wheel Screen → Overlay sur la roue

**Conditions de verrouillage** :
1. Pas dimanche OU
2. < 2 parrainages cette semaine

**Affichage** :
- Overlay noir semi-transparent
- Icône cadenas
- Message "ROUE VERROUILLÉE"
- Barre de progression 2 parrainages

---

### 7. 📤 Partager Après Roue

**Où** : Wheel Screen → Après avoir gagné

**Bouton** : "Partager ma chance"

**Message** :
```
INCROYABLE ! 😱

Je viens de tourner la Roue de la Chance Sellovia et j'ai gagné [GAIN] ! 🔥

Je me rapproche de ma montre de luxe ! ⌚✨

Toi aussi, rejoins l'aventure Sellovia...
```

---

## ❌ CE QUI RESTE À FAIRE

### Phase 2 - Fonctions Importantes (5-7 jours)

- [ ] Écran Historique Gagnants
- [ ] Popup "Nouveau Cycle"
- [ ] Charte Ambassadeur
- [ ] Kit Média Ambassadeur
- [ ] Info Paiement Lundi
- [ ] Alertes "Proche du but"

### Phase 3 - Marketplace (10-14 jours)

- [ ] Écran Liste Produits
- [ ] Détails Produit
- [ ] Panier & Commande
- [ ] Mes Commandes
- [ ] Stock en temps réel

### Phase 4 - Bonus (3-5 jours)

- [ ] Écran Profil Complet
- [ ] Modifier Infos
- [ ] Notifications Push
- [ ] Deep Links

---

## 🐛 TESTS À FAIRE

### Test 1 : Case Dorée Bonus
1. Mettre `bonusFidelite = true` dans UserModel
2. Lancer l'app
3. Vérifier que case 1 est dorée avec étoile
4. Vérifier message "BONUS FIDÉLITÉ"

### Test 2 : Compteur Cycles Élite
1. Choisir parcours Élite
2. Mettre `cycleCount = 1`
3. Vérifier que Cycle 1 = ✅ COMPLÉTÉ
4. Vérifier que Cycle 2 = 🔄 EN COURS

### Test 3 : Bouton Réclamer
1. Mettre `currentScore = targetScore` (20 ou 35)
2. Vérifier bouton vert apparaît
3. Cliquer → doit ouvrir WhatsApp

### Test 4 : Timer Dimanche
1. Lancer un dimanche → doit afficher "DISPONIBLE"
2. Lancer un autre jour → doit afficher "Prochain : Xj Xh"

### Test 5 : Roue Verrouillée
1. Si pas dimanche → overlay noir avec message
2. Si dimanche mais < 2 parrainages → overlay avec barre progression
3. Si dimanche et >= 2 parrainages → roue débloquée

### Test 6 : Partage Après Roue
1. Tourner la roue
2. Gagner un lot
3. Vérifier bouton "Partager ma chance"
4. Cliquer → doit ouvrir dialog partage

---

## 📝 NOTES IMPORTANTES

### Variables UserModel nécessaires

Le `UserModel` doit avoir :
```dart
class UserModel {
  final int currentScore;      // Score actuel
  final int targetScore;        // Objectif (20 ou 35)
  final int cycleCount;         // Cycles complétés (0-3)
  final bool bonusFidelite;     // Bonus début cycle
  final String parcours;        // 'classique' ou 'elite'
  final String referralLink;    // Lien de parrainage
}
```

### Couleurs AppColors

Utiliser les couleurs officielles :
```dart
primaryBlue: #0074D9
darkBlue: #005BB5
primaryGreen: #7FDB5A
darkGreen: #5FBB3A
```

### Navigation Bottom Bar

Ordre des onglets :
1. 🏠 Accueil (bleu)
2. ✨ Roue (vert)
3. 👑 Ambassadeur (vert)
4. 🏆 Classement (bleu)

---

## 🚀 PROCHAINES ÉTAPES

1. **Tester Phase 1** (2-3 heures)
   - Vérifier tous les tests ci-dessus
   - Corriger les bugs éventuels

2. **Commencer Phase 2** (5-7 jours)
   - Créer WinnersHistoryScreen
   - Créer NewCycleDialog
   - Modifier AmbassadorScreen (charte)

3. **Phase 3 - Marketplace** (10-14 jours)
   - Créer toute la partie e-commerce
   - Intégration paiements

4. **Finalisation** (3-5 jours)
   - Tests complets
   - Debug
   - Déploiement

---

## 💡 CONSEILS

1. **Tester sur appareil réel** : Certaines fonctionnalités (WhatsApp, partage) ne marchent que sur téléphone

2. **Simuler les données** : Pour tester, modifier temporairement les valeurs :
```dart
bonusFidelite: true,
cycleCount: 1,
currentScore: 20,
```

3. **Vérifier les permissions** :
- AndroidManifest.xml : permissions internet, WhatsApp
- iOS Info.plist : LSApplicationQueriesSchemes

4. **Hot Reload** : Utiliser `r` dans le terminal pour recharger l'app rapidement

---

## 📞 SUPPORT

Si tu rencontres des problèmes :
1. Vérifier les erreurs dans le terminal
2. Faire `flutter clean && flutter pub get`
3. Redémarrer l'app
4. Vérifier que toutes les dépendances sont installées

---

**Version** : Phase 1 - v1.0
**Date** : 13 janvier 2026
**Prochaine mise à jour** : Phase 2 (à planifier)

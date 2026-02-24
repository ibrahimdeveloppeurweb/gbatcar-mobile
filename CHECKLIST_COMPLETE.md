# 📋 SELLOVIA - CHECKLIST COMPLÈTE DES FONCTIONNALITÉS

## LÉGENDE
- ✅ **TERMINÉ** : Implémenté et testé
- 🔄 **EN COURS** : En développement
- ❌ **À FAIRE** : Pas encore commencé
- 🔴 **PRIORITÉ HAUTE** : Critique
- 🟡 **PRIORITÉ MOYENNE** : Important
- 🟢 **PRIORITÉ BASSE** : Bonus

---

## ✅ PHASE 1 : CORRECTIONS URGENTES (7 fonctionnalités)

### 1. ✅ Case dorée bonus fidélité 🔴
**Statut** : TERMINÉ  
**Fichier** : `dashboard_screen_enhanced.dart`  
**Lignes** : 45  
**Description** : La case #1 de la grille a un gradient doré avec étoile ⭐ si `bonusFidelite = true`. Message explicatif apparaît sous la grille.

**Test** :
```dart
bonusFidelite: true,
```

---

### 2. ✅ Compteur 3 cycles Élite 🔴
**Statut** : TERMINÉ  
**Fichier** : `dashboard_screen_enhanced.dart`  
**Lignes** : 120  
**Description** : Section qui affiche les 3 cycles du Parcours Élite avec états (✅ COMPLÉTÉ, 🔄 EN COURS, 🔒 VERROUILLÉ) et récompenses.

**Test** :
```dart
parcours: 'elite',
cycleCount: 1,  // 0-3
```

---

### 3. ✅ Bouton "Réclamer ma récompense" 🔴
**Statut** : TERMINÉ  
**Fichier** : `dashboard_screen_enhanced.dart`  
**Lignes** : 60  
**Description** : Card verte qui apparaît quand objectif atteint. Bouton ouvre WhatsApp admin avec message pré-rempli.

**Test** :
```dart
currentScore: 20,
targetScore: 20,
```

---

### 4. ✅ Message partage amélioré 🟡
**Statut** : TERMINÉ  
**Fichier** : `dashboard_screen_enhanced.dart`  
**Lignes** : 30  
**Description** : Message WhatsApp/Facebook complet avec emojis, explications, et lien de parrainage.

---

### 5. ✅ Timer prochain dimanche 🔴
**Statut** : TERMINÉ  
**Fichier** : `wheel_screen_enhanced.dart`  
**Lignes** : 80  
**Description** : Compte à rebours dynamique "Prochain : 4j 15h 23min" qui se met à jour chaque seconde. Si dimanche : "🎰 DISPONIBLE MAINTENANT !"

---

### 6. ✅ Roue verrouillée 🔴
**Statut** : TERMINÉ  
**Fichier** : `wheel_screen_enhanced.dart`  
**Lignes** : 100  
**Description** : Overlay noir sur la roue si pas dimanche ou < 2 parrainages. Affiche icône 🔒, message explicatif, et barre de progression.

**Test** :
```dart
currentScore: 0,  // < 2 parrainages
```

---

### 7. ✅ Bouton "Partager ma chance" 🟡
**Statut** : TERMINÉ  
**Fichier** : `wheel_screen_enhanced.dart`  
**Lignes** : 30  
**Description** : Après avoir gagné à la roue, bouton pour partager sa victoire sur WhatsApp/Facebook avec message pré-rempli.

---

## ❌ PHASE 2 : FONCTIONS IMPORTANTES (10 fonctionnalités)

### 8. ❌ Écran Historique Gagnants 🔴
**Statut** : À FAIRE  
**Fichier** : `winners_history_screen.dart` (à créer)  
**Estimation** : 150 lignes, 2h  
**Description** : Liste scrollable de tous les gagnants précédents avec photo, nom, ville, date, et récompense (Montre/Tecno).

**Layout** :
```
┌─────────────────────────────┐
│ 🏆 Nos Gagnants             │
│                             │
│ ┌─────────────────────────┐ │
│ │ 👤 Kofi A.              │ │
│ │ ⌚ Montre - Cycle 12     │ │
│ │ 📅 15 déc 2025          │ │
│ │ 📍 Abidjan              │ │
│ └─────────────────────────┘ │
└─────────────────────────────┘
```

**Actions** :
- Scroll infini
- Filtrer par type (Montre/Tecno)
- Clic → voir détails gagnant

---

### 9. ❌ Popup "Nouveau Cycle" 🔴
**Statut** : À FAIRE  
**Fichier** : `new_cycle_dialog.dart` (à créer)  
**Estimation** : 100 lignes, 1h30  
**Description** : Dialog fullscreen qui s'affiche au lancement de l'app après un reset de cycle. Annonce le gagnant et le début du nouveau cycle.

**Layout** :
```
┌─────────────────────────────┐
│        🏆                   │
│  Le Cycle est bouclé !      │
│  Félicitations à Aya K.     │
│  qui remporte la montre !   │
│  ─────────────────────      │
│  Nouveau cycle commence !   │
│  À vos liens ! 🚀           │
│                             │
│ [Partager mon lien]         │
│ [OK, compris]               │
└─────────────────────────────┘
```

**Conditions** :
- S'affiche si `newCycleAvailable = true`
- Une seule fois par cycle

---

### 10. ❌ Charte Ambassadeur 🔴
**Statut** : À FAIRE  
**Fichier** : `ambassador_charter_dialog.dart` (à créer)  
**Estimation** : 120 lignes, 2h  
**Description** : Dialog avec texte légal que l'utilisateur doit accepter avant d'accéder à l'onglet Ambassadeur.

**Contenu** :
```
📜 CHARTE AMBASSADEUR

En activant mon lien, je m'engage à :

✓ Présenter Sellovia comme e-commerce
✓ Ne JAMAIS utiliser "investissement"
✓ Être transparent sur les gains
✓ Interdire la fraude
✓ Pas de garantie de victoire

□ J'accepte et je m'engage

[Activer mon statut d'ambassadeur]
```

**Variable** :
```dart
charteAmbassadeurAcceptee: bool
```

---

### 11. ❌ Kit Média Ambassadeur 🟡
**Statut** : À FAIRE  
**Fichier** : `ambassador_screen.dart` (à modifier)  
**Estimation** : 80 lignes, 1h  
**Description** : Section dans AmbassadorScreen pour télécharger les visuels officiels (images montres, Tecno, bannières).

**Layout** :
```
┌─────────────────────────────┐
│ 📸 KIT MÉDIA OFFICIEL       │
│ Téléchargez ces visuels :   │
│                             │
│ [IMG]  [IMG]  [IMG]         │
│ Montre  Tecno Banner        │
│  📥     📥     📥          │
└─────────────────────────────┘
```

**Actions** :
- Télécharger dans galerie
- Partager directement

---

### 12. ❌ Info Paiement Lundi 🟡
**Statut** : À FAIRE  
**Fichier** : `ambassador_screen.dart` (à modifier)  
**Estimation** : 50 lignes, 30 min  
**Description** : Card informative sur le calendrier des retraits (chaque lundi).

**Layout** :
```
┌─────────────────────────────┐
│ 📅 CALENDRIER DES RETRAITS  │
│ Les paiements : CHAQUE LUNDI│
│                             │
│ Prochain : Lundi 20 janvier │
│ Dans 6 jours                │
│                             │
│ Demandes en attente : 1     │
│ Montant : 12 400 F          │
└─────────────────────────────┘
```

---

### 13. ❌ Alerte "Proche du but" 🟡
**Statut** : À FAIRE  
**Fichier** : `dashboard_screen.dart` (à modifier)  
**Estimation** : 60 lines, 45 min  
**Description** : Banner rouge en haut du Dashboard quand quelqu'un est proche de 20/20.

**Layout** :
```
┌─────────────────────────────┐
│ ⚠️ ALERTE CYCLE             │
│ User123 est à 19/20 !       │
│ Le cycle va se terminer     │
│ Dépêchez-vous ! 🔥          │
└─────────────────────────────┘
```

---

### 14. ❌ Compte à rebours Reset 🟡
**Statut** : À FAIRE  
**Fichier** : `dashboard_screen.dart` (à modifier)  
**Estimation** : 70 lignes, 1h  
**Description** : Card d'urgence qui affiche combien de parrainages restent avant le reset global.

**Layout** :
```
┌─────────────────────────────┐
│ ⏰ FIN DU CYCLE IMMINENTE    │
│ Le leader est à 19/20 !     │
│ 🚨 Plus que 1 parrainage    │
│ avant le RESET GLOBAL       │
│ Terminez MAINTENANT ! 🔥    │
└─────────────────────────────┘
```

---

### 15. ❌ Écran Profil Complet 🟡
**Statut** : À FAIRE  
**Fichier** : `profile_screen.dart` (à créer)  
**Estimation** : 200 lignes, 3h  
**Description** : Écran avec photo profil, infos utilisateur, et menu d'actions.

**Layout** :
```
┌─────────────────────────────┐
│ 👤 Mon Profil               │
│     [Photo profil]          │
│     Ibrahim Traoré          │
│     ID: IBRAHIM789          │
│                             │
│ [📝 Modifier mes infos]     │
│ [📦 Mes commandes]          │
│ [🏆 Historique gagnants]    │
│ [📄 Termes & Conditions]    │
│ [💬 Support]                │
│ [🚪 Déconnexion]            │
└─────────────────────────────┘
```

---

### 16. ❌ Modifier Infos 🟡
**Statut** : À FAIRE  
**Fichier** : `edit_profile_screen.dart` (à créer)  
**Estimation** : 180 lignes, 2h30  
**Description** : Formulaire pour modifier nom, téléphone, email, ville, quartier, photo.

---

### 17. ❌ Message Post-Inscription 🟢
**Statut** : À FAIRE  
**Fichier** : `registration_success_dialog.dart` (à créer)  
**Estimation** : 80 lignes, 1h  
**Description** : Dialog après paiement avec message "Parrainez vos amis et gagnez une montre à valeur de 25 000 FCFA".

---

## ❌ PHASE 3 : MARKETPLACE (14 fonctionnalités)

### 18. ❌ Onglet Shopping 🔴
**Statut** : À FAIRE  
**Estimation** : Ajouter 5ème onglet dans BottomNav  
**Description** : Nouvel onglet 🛒 Shop entre Roue et Ambassadeur.

**Ordre final** :
```
🏠 Accueil | ✨ Roue | 🛒 Shop | 👑 Ambassadeur | 🏆 Classement
```

---

### 19. ❌ Liste Produits 🔴
**Statut** : À FAIRE  
**Fichier** : `marketplace_screen.dart` (à créer)  
**Estimation** : 250 lignes, 4h  
**Description** : Grille de produits électroniques avec images, prix, stock, notes.

**Layout** :
```
┌─────────────────────────────┐
│ 🛒 Boutique Sellovia        │
│ [Barre de recherche...]     │
│                             │
│ 📂 [Montres][Écouteurs]     │
│                             │
│ ┌───────────────────────┐   │
│ │ [Image produit]       │   │
│ │ Montre Connectée      │   │
│ │ 15 000 F              │   │
│ │ ⭐⭐⭐⭐⭐ (42)        │   │
│ │ 📦 Stock : 23         │   │
│ └───────────────────────┘   │
└─────────────────────────────┘
```

**Fonctions** :
- Recherche
- Filtres par catégorie
- Tri (prix, popularité)
- Stock en temps réel

---

### 20. ❌ Détails Produit 🔴
**Statut** : À FAIRE  
**Fichier** : `product_detail_screen.dart` (à créer)  
**Estimation** : 300 lignes, 5h  
**Description** : Page complète d'un produit avec galerie photos, description, avis, partage pour gagner 1000F.

**Layout** :
```
┌─────────────────────────────┐
│ [← Retour]         [♡ Like] │
│                             │
│ [Grande photo]              │
│ [📷][📷][📷][📷]            │
│                             │
│ Montre Connectée Smart      │
│ ⭐⭐⭐⭐⭐ (124)             │
│ 15 000 F  🚚 Gratuit        │
│ 📦 Stock : 42               │
│                             │
│ 📝 Description...           │
│                             │
│ [🛒 Commander]              │
│ [📤 Partager (1000F)]       │
└─────────────────────────────┘
```

**Fonctions** :
- Galerie zoomable
- Partage avec lien unique (1000F commission)
- Like/Favoris

---

### 21-34. Autres Marketplace

- ❌ Panier
- ❌ Checkout
- ❌ Mes Commandes
- ❌ Suivi Colis
- ❌ Avis Produit
- ❌ Stock Temps Réel
- ❌ Notifications Stock
- ❌ Live Shopping
- ❌ Favoris
- ❌ Historique Achats
- ❌ Retours
- ❌ Catégories
- ❌ Promotions
- ❌ Recherche Avancée

---

## 📊 STATISTIQUES GLOBALES

| Phase | Fonctionnalités | Terminées | En cours | À faire |
|-------|-----------------|-----------|----------|---------|
| **Phase 1** | 7 | ✅ 7 | - | - |
| **Phase 2** | 10 | - | - | ❌ 10 |
| **Phase 3** | 17 | - | - | ❌ 17 |
| **TOTAL** | **34** | **7 (20%)** | **0** | **27 (80%)** |

---

## ⏱️ TEMPS ESTIMÉ

| Phase | Temps estimé | Dates |
|-------|-------------|--------|
| ✅ Phase 1 | 3h | 13 jan 2026 |
| Phase 2 | 5-7 jours | À planifier |
| Phase 3 | 10-14 jours | À planifier |
| **TOTAL** | **15-21 jours** | - |

---

## 🎯 PROCHAINES ÉTAPES

### Immédiat (aujourd'hui)
1. ✅ Tester Phase 1
2. ✅ Vérifier tous les fichiers
3. ✅ Corriger les bugs éventuels

### Court terme (cette semaine)
4. Créer WinnersHistoryScreen
5. Créer NewCycleDialog
6. Modifier AmbassadorScreen (charte)

### Moyen terme (2 semaines)
7. Commencer Marketplace
8. Liste produits
9. Détails produit

### Long terme (1 mois)
10. Finaliser toutes les fonctionnalités
11. Tests complets
12. Déploiement

---

**Dernière mise à jour** : 13 janvier 2026, 15h30
**Phase actuelle** : Phase 1 TERMINÉE ✅
**Prochaine phase** : Phase 2 (à démarrer)

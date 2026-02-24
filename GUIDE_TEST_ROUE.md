# 🎰 GUIDE RAPIDE - UTILISER LA ROUE

## ⚡ INSTALLATION

```bash
cd C:\Users\cisse\StudioProjects\project
flutter pub get
flutter run
```

---

## 🎯 TESTER LA ROUE

### 1. DIMANCHE GRATUIT ✅

**Activer le mode :**
```dart
// Changer la date système de ton ordinateur → Dimanche
// OU modifier temporairement le code :

bool _isSunday() => true; // Force dimanche
```

**Avec 2+ parrainages (débloqué) :**
```dart
// Dans UserModel
currentScore: 3  // >= 2
```

**Résultat attendu :**
```
✅ Header VERT "🎁 AUJOURD'HUI C'EST GRATUIT"
✅ Message "Tournez SANS PAYER"
✅ Bouton vert "🎁 TOURNER GRATUITEMENT"
✅ Clic → Roue tourne directement (pas de paiement)
```

---

**Avec < 2 parrainages (verrouillé) :**
```dart
// Dans UserModel
currentScore: 1  // < 2
```

**Résultat attendu :**
```
✅ Overlay noir sur la roue
✅ Icône 🔒
✅ Message "Parrainez encore 1 personne"
✅ Barre progression : ● ○
✅ Bouton grisé "🔒 PARRAINEZ 1 PERSONNE(S)"
```

---

### 2. LUNDI-SAMEDI PAYANT 💰

**Activer le mode :**
```dart
// Changer date système → Mardi (ou autre jour ≠ dimanche)
// OU modifier :

bool _isSunday() => false; // Force jour semaine
```

**Résultat attendu :**
```
✅ Header BLEU "💰 300 FCFA par tour"
✅ Message "Tournez autant de fois que vous voulez"
✅ Timer "Roue gratuite dans : 4j 15h 23min"
✅ Bouton bleu "💰 PAYER 300F ET TOURNER"
✅ Clic → Dialog de confirmation
✅ "PAYER & TOURNER" → Roue tourne
```

---

### 3. TESTER LES 6 PRIX

**Prix 1 : REBOND (50%)**
```
Tourner plusieurs fois → 1 chance sur 2 de tomber dessus

Résultat :
✅ Écran rouge
✅ Icône ❌
✅ "PAS DE CHANCE !"
✅ "REBOND - Pas de chance cette fois !"
✅ Bouton "RÉESSAYER"
```

**Prix 2 : +1 BOOST (25%)**
```
Tourner → 1 chance sur 4

Résultat :
✅ Écran bleu
✅ Icône ⭐
✅ "FÉLICITATIONS !"
✅ "+1 BOOST - +1 Parrainage gratuit"
✅ Message "✅ +1 ajouté à votre score !"
✅ Boutons "Partager" + "SUPER !"
```

**Prix 3 : 3 TICKETS (15%)**
```
Tourner → 1 chance sur 7

Résultat :
✅ Écran violet
✅ Icône 🎫
✅ "3 TICKETS - Pour tirage dimanche"
✅ Message "🎫 Vous avez maintenant 3 tickets"
✅ "🎯 Tirage dimanche 20h - Prix : 5000F"
✅ Boutons "Partager" + "SUPER !"
```

**Prix 4 : BADGE ÉLITE (7%)**
```
Tourner ~15 fois → 1 chance

Résultat :
✅ Écran doré
✅ Icône 👑
✅ "BADGE ÉLITE - Statut Vendeur Élite"
✅ "👑 Vous êtes VENDEUR ÉLITE !"
✅ Avantages :
   ✨ Commission 100F → 150F
   👑 Nom doré classement
   🎁 Produits exclusifs
✅ Boutons "Partager" + "SUPER !"
```

**Prix 5 : 500F CRÉDIT (2.9%)**
```
Tourner ~35 fois → 1 chance

Résultat :
✅ Écran vert
✅ Icône 📞
✅ "500F CRÉDIT - Crédit d'appel"
✅ Card blanche avec "📞 500 FCFA"
✅ Bouton vert WhatsApp "RÉCLAMER"
✅ Message "Contactez-nous sous 5 min"
✅ Boutons "Partager" + "SUPER !"
```

**Prix 6 : 5000F CASH (0.1%)**
```
Tourner ~1000 fois → 1 chance (très rare !)

Résultat :
✅ Écran turquoise
✅ Icône 💰
✅ "5000F CASH - JACKPOT !"
✅ Card blanche avec "💰 5000 FCFA"
✅ Bouton vert WhatsApp "RÉCLAMER"
✅ Message "Contactez-nous sous 5 min"
✅ Boutons "Partager" + "SUPER !"
```

---

## 🧪 SCÉNARIOS DE TEST

### Scénario 1 : Utilisateur Dimanche (Déblocké)

```
État initial :
- Dimanche
- currentScore = 3 (>= 2)

Actions :
1. Ouvrir Roue
2. Vérifier header vert
3. Cliquer "TOURNER GRATUITEMENT"
4. Regarder animation
5. Noter le prix gagné
6. Cliquer "SUPER !"

Résultat attendu :
✅ Aucun paiement demandé
✅ 1 tour gratuit
✅ Prix appliqué selon type
```

---

### Scénario 2 : Utilisateur Dimanche (Verrouillé)

```
État initial :
- Dimanche
- currentScore = 0

Actions :
1. Ouvrir Roue
2. Vérifier overlay noir
3. Lire message
4. Essayer de cliquer (ne fonctionne pas)

Résultat attendu :
✅ Overlay visible
✅ Roue non cliquable
✅ Bouton désactivé
```

---

### Scénario 3 : Utilisateur Mardi (Payant)

```
État initial :
- Mardi
- Solde : 1500F

Actions :
1. Ouvrir Roue
2. Cliquer "PAYER 300F"
3. Voir dialog confirmation
4. Cliquer "PAYER & TOURNER"
5. Regarder animation
6. Noter prix
7. Cliquer "RÉESSAYER"
8. Recommencer 4 fois

Résultat attendu :
✅ 5 tours payés
✅ 5 × 300F = 1500F dépensés
✅ Différents prix gagnés
✅ Peut tourner autant qu'il veut
```

---

### Scénario 4 : Gagner 500F et Réclamer

```
État initial :
- Mardi
- Tourne jusqu'à gagner 500F

Actions :
1. Gagner 500F CRÉDIT
2. Lire écran victoire
3. Cliquer "RÉCLAMER PAR WHATSAPP"
4. WhatsApp s'ouvre
5. Message pré-rempli visible
6. Envoyer à +2250707070707

Résultat attendu :
✅ WhatsApp s'ouvre
✅ Message formaté :
   "🎉 GAIN ROUE..."
   "Nom : ..."
   "500 FCFA"
✅ Peut envoyer
```

---

### Scénario 5 : Partager Victoire

```
État initial :
- Vient de gagner +1 BOOST

Actions :
1. Écran victoire visible
2. Cliquer "Partager"
3. Choisir WhatsApp/Facebook
4. Message pré-rempli visible
5. Partager

Résultat attendu :
✅ Dialog partage s'ouvre
✅ Message :
   "🎉 INCROYABLE !"
   "Je viens de gagner..."
   "Lien : ..."
✅ Peut partager
```

---

## 📊 STATISTIQUES DE TEST

**Tourner 100 fois et compter :**

| Prix | Attendu | Obtenu | % |
|------|---------|--------|---|
| Rebond | ~50 | ? | ? |
| +1 Boost | ~25 | ? | ? |
| Tickets | ~15 | ? | ? |
| Badge | ~7 | ? | ? |
| 500F | ~3 | ? | ? |
| 5000F | ~0-1 | ? | ? |

**Si très différent → Vérifier algorithme**

---

## 💡 ASTUCES DEBUG

### Forcer un prix spécifique

**Modifier temporairement :**
```dart
WheelPrize _selectPrizeByProbability() {
  // return _prizes[0]; // Force REBOND
  // return _prizes[1]; // Force +1 BOOST
  // return _prizes[2]; // Force TICKETS
  // return _prizes[3]; // Force BADGE
  // return _prizes[4]; // Force 500F
  return _prizes[5]; // Force 5000F
}
```

---

### Voir les probabilités en console

**Ajouter :**
```dart
void _handleSpin(user, bool isFree) async {
  final prize = _selectPrizeByProbability();
  
  print('🎰 SPIN RESULT:');
  print('Prize: ${prize.label}');
  print('Probability: ${prize.probability * 100}%');
  print('Type: ${prize.type}');
  
  // ... reste du code
}
```

---

### Accélérer animation

**Changer durée :**
```dart
_controller = AnimationController(
  duration: const Duration(seconds: 1), // Au lieu de 4
  vsync: this,
);
```

---

### Désactiver paiement (test)

**Modifier :**
```dart
Future<void> _handleSpin(user, bool isFree) async {
  // Commenter cette partie pour tester sans payer
  /*
  if (!isFree) {
    final confirmed = await _showPaymentDialog();
    if (!confirmed) return;
  }
  */
  
  // ... tourner directement
}
```

---

## ✅ CHECKLIST TEST

### Interface
- [ ] Header change selon jour (vert dimanche, bleu semaine)
- [ ] Timer compte à rebours fonctionne
- [ ] Roue tourne (animation fluide)
- [ ] Overlay verrouillage visible si < 2 parrainages dimanche
- [ ] Barre progression affiche correctement
- [ ] Flèche indicateur visible en haut

### Fonctionnel
- [ ] Dimanche + 2+ parrainages = bouton gratuit
- [ ] Dimanche + < 2 parrainages = verrouillé
- [ ] Semaine = bouton payant 300F
- [ ] Dialog paiement apparaît
- [ ] Roue tourne après confirmation
- [ ] Prix sélectionné selon probabilités
- [ ] Écran résultat s'affiche
- [ ] Boutons actions fonctionnent

### Prix
- [ ] REBOND : écran rouge, message perdu
- [ ] +1 BOOST : écran bleu, message boost
- [ ] TICKETS : écran violet, message tickets
- [ ] BADGE : écran doré, avantages listés
- [ ] 500F : card blanche, bouton WhatsApp
- [ ] 5000F : card blanche, bouton WhatsApp

### Actions
- [ ] Bouton "Partager" ouvre dialog
- [ ] Message pré-rempli correct
- [ ] WhatsApp s'ouvre pour 500F/5000F
- [ ] Message réclamation correct
- [ ] Bouton "SUPER !" ferme résultat
- [ ] Peut re-tourner après

### Légende
- [ ] Affiche les 6 prix
- [ ] Couleurs correctes
- [ ] Pourcentages affichés
- [ ] Descriptions visibles

---

## 🐛 PROBLÈMES COURANTS

**Problème 1 : Roue ne tourne pas**
```
Cause : Animation controller non initialisé
Solution : Vérifier initState()
```

**Problème 2 : WhatsApp ne s'ouvre pas**
```
Cause : Émulateur n'a pas WhatsApp
Solution : Tester sur vrai téléphone
```

**Problème 3 : Toujours le même prix**
```
Cause : Random non initialisé
Solution : Vérifier _selectPrizeByProbability()
```

**Problème 4 : Timer ne change pas**
```
Cause : Timer.periodic non actif
Solution : Vérifier initState() et dispose()
```

---

## 🚀 PRÊT À TESTER !

```bash
flutter run
```

**Puis teste tous les scénarios ci-dessus ! 🎰**

---

**Status :** ✅ MODULE COMPLET  
**Tests :** En cours  
**Date :** 14 janvier 2026

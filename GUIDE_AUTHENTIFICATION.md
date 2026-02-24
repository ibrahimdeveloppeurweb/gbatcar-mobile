# 🚀 GUIDE RAPIDE - SYSTÈME D'AUTHENTIFICATION SELLOVIA

## ✅ FICHIERS CORRIGÉS

Les fichiers suivants ont été mis à jour dans votre projet :

1. **lib/main.dart** ✅
   - Initialisation complète des services (Storage, API, Auth)
   - Configuration du MultiProvider
   - Vérification automatique du statut d'authentification au démarrage
   - Route initiale conditionnelle (dashboard si connecté, splash sinon)

2. **lib/presentation/screens/auth/connexion_screen.dart** ✅
   - Design cohérent avec WelcomeScreen
   - Champs Email et Mot de passe avec validation
   - Intégration avec AuthProvider
   - Navigation vers dashboard après connexion réussie

3. **lib/presentation/screens/onboarding/welcome_screen.dart** ✅
   - Ajout du lien "Déjà un compte ? Se connecter" en bas
   - Navigation vers l'écran de connexion

## 📋 CHECKLIST AVANT DE TESTER

### 1. Vérifier les dépendances dans `pubspec.yaml`

Assurez-vous que ces dépendances sont présentes :

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.5+1
  dio: ^5.9.0
  shared_preferences: ^2.0.0
```

### 2. Installer les dépendances

```bash
flutter pub get
```

### 3. Configurer l'URL de votre API

Ouvrez `lib/core/services/api_service.dart` et modifiez la ligne 11 :

```dart
static const String baseUrl = 'https://api.sellovia.ci/api';
```

Remplacez par l'URL réelle de votre backend API.

### 4. Vérifier les endpoints dans `auth_service.dart`

Ouvrez `lib/core/services/auth_service.dart` et vérifiez que les endpoints correspondent à votre API :

- Ligne 24 : `/auth/login` (connexion)
- Ligne 68 : `/auth/register` (inscription)
- Ligne 112 : `/auth/logout` (déconnexion)

## 🎯 COMMENT TESTER

### Test 1 : Premier lancement (utilisateur non connecté)

```bash
flutter run
```

**Comportement attendu :**
1. L'app démarre sur le SplashScreen
2. Navigation vers WelcomeScreen
3. Vous voyez le lien "Déjà un compte ? Se connecter" en bas
4. Clic sur "Se connecter" → Navigation vers ConnexionScreen

### Test 2 : Connexion

Sur l'écran de connexion :

1. **Test avec champs vides** :
   - Cliquez sur "Se connecter"
   - → Messages d'erreur de validation s'affichent

2. **Test avec email invalide** :
   - Entrez : `test` (sans @)
   - → Message "Email invalide"

3. **Test avec mot de passe court** :
   - Entrez un mot de passe de moins de 6 caractères
   - → Message "Le mot de passe doit contenir au moins 6 caractères"

4. **Test avec credentials valides** :
   - Entrez email et mot de passe valides
   - → Loading indicator s'affiche
   - → Si succès : Navigation vers DashboardScreen
   - → Si échec : SnackBar rouge avec message d'erreur

### Test 3 : Persistance (utilisateur déjà connecté)

Après une connexion réussie :

1. Fermez complètement l'app (kill le processus)
2. Relancez l'app
3. **Comportement attendu** : L'app doit vous rediriger directement vers le Dashboard (pas de SplashScreen/WelcomeScreen)

### Test 4 : Déconnexion

1. Sur le DashboardScreen, cherchez le bouton de déconnexion
2. Cliquez dessus
3. **Comportement attendu** : Retour vers ConnexionScreen

## 🐛 RÉSOLUTION DES PROBLÈMES COURANTS

### Erreur : "Failed to load resource"

**Cause** : L'URL de l'API n'est pas accessible
**Solution** : Vérifiez que votre backend est bien démarré et accessible

### Erreur : "The method 'X' isn't defined for the type 'Y'"

**Cause** : Un import manque ou un fichier n'a pas été créé
**Solution** : 
1. Relancez `flutter pub get`
2. Redémarrez VS Code / Android Studio
3. Relancez `flutter clean` puis `flutter pub get`

### Erreur : "Navigator operation requested with a context that does not include a Navigator"

**Cause** : Problème de contexte de navigation
**Solution** : Utilisez `Navigator.of(context)` au lieu de `Navigator`

### L'app se bloque au démarrage

**Cause** : Erreur d'initialisation des services
**Solution** : Vérifiez les logs dans la console

```bash
flutter run --verbose
```

## 📱 STRUCTURE DU FLUX D'AUTHENTIFICATION

```
APP START
    ↓
StorageService.init()
    ↓
Création de tous les services
    ↓
AuthProvider.checkAuthStatus()
    ↓
    ├─→ Token trouvé? → Dashboard
    └─→ Pas de token? → Splash → Welcome
                            ↓
                      ┌─────┴─────┐
                      ↓           ↓
                 Connexion   Inscription
                      ↓           ↓
                      └─→ Dashboard ←┘
```

## 🔑 DONNÉES STOCKÉES LOCALEMENT

Le système stocke automatiquement :
- ✅ Token d'authentification
- ✅ Refresh token (si disponible)
- ✅ Données utilisateur (UserModel)
- ✅ User ID

Ces données sont sauvegardées avec `SharedPreferences` et persistent entre les sessions.

## 🎨 DESIGN

Les écrans suivent le design de Sellovia :
- **Gradient de fond** : background → primaryBlue
- **Cards** : Gradient avec bordure
- **Boutons** : Gradient vert avec icône flèche
- **Champs** : Fond semi-transparent avec bordure

## 📞 PROCHAINES ÉTAPES

1. ✅ Tester la connexion avec votre API backend
2. ✅ Implémenter le bouton de déconnexion dans DashboardScreen
3. ✅ Ajouter l'écran "Mot de passe oublié"
4. ✅ Personnaliser les messages d'erreur selon votre API

## 🆘 BESOIN D'AIDE ?

Si vous rencontrez un problème :
1. Vérifiez les logs : `flutter run --verbose`
2. Vérifiez que tous les fichiers ont bien été créés
3. Vérifiez que l'URL de l'API est correcte
4. Vérifiez que votre backend fonctionne

---

**Version** : 1.0.0  
**Date** : 2026-01-22  
**Projet** : Sellovia Mobile

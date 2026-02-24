# 🚀 DÉMARRAGE RAPIDE - TESTS AUTHENTIFICATION

## ⚡ Lancer l'App MAINTENANT

### Étape 1: Ouvre un terminal dans le dossier du projet
```bash
cd C:\Users\cisse\StudioProjects\project
```

### Étape 2: Installe les dépendances
```bash
flutter pub get
```

### Étape 3: Lance l'app
```bash
flutter run
```

## 🧪 Tests Rapides (Mode Développement)

### Test Sans Backend (Mock)
Pour tester sans API backend réelle, tu peux temporairement modifier:

**`lib/data/providers/auth_provider.dart`** ligne 56-77:

```dart
/// Connexion utilisateur
Future<bool> login({
  required String email,
  required String password,
}) async {
  _setLoading(true);
  _clearError();

  try {
    // MODE TEST: Simuler une connexion réussie
    await Future.delayed(const Duration(seconds: 2)); // Simule API delay
    
    // Créer un user fake pour test
    _currentUser = UserModel(
      id: '123',
      nom: 'Test User',
      email: email,
      telephone: '0712345678',
      ville: 'Abidjan',
      parcours: 'classic',
      codeParrainage: 'TEST123',
      currentScore: 0,
      createdAt: DateTime.now(),
    );
    
    _isAuthenticated = true;
    _setLoading(false);
    notifyListeners();
    return true;
    
    // CODE ORIGINAL (commenté pour test):
    // _currentUser = await _authRepository.login(
    //   email: email,
    //   password: password,
    // );
    // _isAuthenticated = true;
    // _setLoading(false);
    // notifyListeners();
    // return true;
  } catch (e) {
    _setError(_formatErrorMessage(e.toString()));
    _setLoading(false);
    return false;
  }
}
```

### Avec ce Mock:
1. Entre n'importe quel email (format valide)
2. Entre n'importe quel mot de passe (6+ caractères)
3. Clique "Se connecter"
4. ✅ Tu seras connecté et redirigé vers Dashboard

### Retirer le Mock:
Une fois que ton backend est prêt, retire le code de simulation et décommente le code original.

## 📱 Scénarios de Test

### ✅ Test 1: Première Installation
**Actions:**
1. Lance l'app
2. Observe SplashScreen (2 secondes)
3. Vérifie que tu arrives sur WelcomeScreen

**✅ Résultat Attendu:**
- Logo Sellovia animé
- 3 feature cards (Montres, Smartphones, Gains)
- Bouton "Commencer maintenant"
- Lien "Déjà un compte ? Se connecter"

---

### ✅ Test 2: Navigation vers Connexion
**Actions:**
1. Sur WelcomeScreen
2. Clique sur "Se connecter" (en bas)

**✅ Résultat Attendu:**
- Écran de connexion s'affiche
- Logo Sellovia
- 2 champs (Email + Mot de passe)
- Bouton "Se connecter"
- Lien "Créer un compte" en bas

---

### ✅ Test 3: Validation Formulaire
**Actions:**
1. Sur ConnexionScreen
2. Clique "Se connecter" sans rien remplir

**✅ Résultat Attendu:**
- Message d'erreur sous Email: "Email requis"
- Message d'erreur sous Password: "Mot de passe requis"

**Actions:**
3. Entre email invalide (ex: "test")
4. Clique "Se connecter"

**✅ Résultat Attendu:**
- Message d'erreur: "Email invalide"

**Actions:**
5. Entre email valide (ex: "test@test.com")
6. Entre mot de passe court (ex: "123")
7. Clique "Se connecter"

**✅ Résultat Attendu:**
- Message d'erreur: "Le mot de passe doit contenir au moins 6 caractères"

---

### ✅ Test 4: Connexion Réussie (avec Mock)
**Actions:**
1. Entre email valide: "test@test.com"
2. Entre mot de passe valide: "123456"
3. Clique "Se connecter"

**✅ Résultat Attendu:**
- Bouton affiche spinner (2 secondes)
- Redirection vers Dashboard
- Tu es maintenant connecté

---

### ✅ Test 5: Persistance Session
**Actions:**
1. Connecté sur Dashboard
2. Ferme l'app complètement (swipe et kill)
3. Rouvre l'app

**✅ Résultat Attendu:**
- SplashScreen s'affiche (2 secondes)
- Message "Vérification de la session..."
- Redirection DIRECTE vers Dashboard (pas de WelcomeScreen)
- Tu es toujours connecté

---

### ✅ Test 6: Déconnexion
**Actions:**
1. Sur Dashboard, trouve le bouton Logout
2. Clique Logout

**✅ Résultat Attendu:**
- Redirection vers WelcomeScreen
- Tu es déconnecté

**Actions:**
3. Ferme et rouvre l'app

**✅ Résultat Attendu:**
- SplashScreen → WelcomeScreen (pas de Dashboard)
- Tu es bien déconnecté

---

## 🐛 Problèmes Courants

### Erreur: "Null check operator used on a null value"
**Cause:** Services pas initialisés
**Solution:** Vérifie que `main.dart` initialise tous les services

### Erreur: "No MaterialLocalizations found"
**Cause:** Problème de widgets Flutter
**Solution:** Redémarre l'app

### Erreur: "Failed to load network image"
**Cause:** Problème réseau/API
**Solution:** Utilise le mode Mock pour tester sans backend

### Erreur: "The method 'read' was called on null"
**Cause:** Provider pas accessible
**Solution:** Vérifie que AuthProvider est dans MultiProvider

---

## 📸 Screenshots Attendus

### WelcomeScreen
- Fond gradient bleu sombre
- Logo Sellovia
- 3 cards colorées
- Bouton vert "Commencer maintenant"
- Lien "Déjà un compte ?"

### ConnexionScreen
- Fond gradient bleu sombre
- Logo Sellovia
- 2 cards bleues (Email + Password)
- Bouton vert "Se connecter"
- Lien "Créer un compte"

### SplashScreen
- Fond gradient avec particules
- Logo Sellovia animé
- Spinner de chargement
- Texte "Initialisation..." puis "Vérification de la session..."

---

## ✅ Checklist Finale

- [ ] App lance sans erreur
- [ ] WelcomeScreen s'affiche au premier lancement
- [ ] Bouton "Se connecter" fonctionne
- [ ] Validation formulaire fonctionne
- [ ] Connexion avec Mock fonctionne
- [ ] Redirection vers Dashboard après connexion
- [ ] Session persiste après redémarrage
- [ ] Déconnexion fonctionne
- [ ] Retour à Welcome après déconnexion

---

## 🎯 Prochaines Étapes

1. ✅ Tester avec Mock (mode développement)
2. 🔧 Connecter au vrai backend API
3. 🎨 Ajouter bouton Logout au Dashboard
4. 🔐 Implémenter "Mot de passe oublié"
5. 📱 Tester sur appareil réel

---

**Prêt pour les tests! Lance `flutter run` maintenant! 🚀**

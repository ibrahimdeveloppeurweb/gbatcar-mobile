class Validators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le nom est obligatoire';
    }
    if (value.length < 2) {
      return 'Le nom doit contenir au moins 2 caractères';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le numéro de téléphone est obligatoire';
    }

    final cleanedPhone = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    if (cleanedPhone.length < 10) {
      return 'Numéro invalide (min 10 chiffres)';
    }

    if (!RegExp(r'^\+?[0-9]+$').hasMatch(cleanedPhone)) {
      return 'Le numéro ne doit contenir que des chiffres';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Email invalide';
    }

    return null;
  }

  static String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'La ville est obligatoire';
    }
    if (value.length < 2) {
      return 'La ville doit contenir au moins 2 caractères';
    }
    return null;
  }

  static String? validateReferralCode(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return 'Code invalide (lettres et chiffres uniquement)';
    }

    if (value.length < 3) {
      return 'Code trop court (min 3 caractères)';
    }

    return null;
  }
}
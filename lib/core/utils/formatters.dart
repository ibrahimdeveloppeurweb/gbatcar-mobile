import 'package:intl/intl.dart';

class Formatters {
  static String formatPhoneNumber(String phone) {
    String cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');

    if (cleaned.startsWith('+225')) {
      String number = cleaned.substring(4);
      if (number.length >= 10) {
        return '+225 ${number.substring(0, 2)} ${number.substring(2, 4)} ${number.substring(4, 6)} ${number.substring(6, 8)} ${number.substring(8, 10)}';
      }
    }

    return phone;
  }

  static String formatCurrency(int amount) {
    final formatter = NumberFormat('#,###', 'fr_FR');
    return '${formatter.format(amount).replaceAll(',', ' ')} FCFA';
  }

  static String formatNumber(int number) {
    final formatter = NumberFormat('#,###', 'fr_FR');
    return formatter.format(number).replaceAll(',', ' ');
  }

  static String formatDate(DateTime date) {
    final formatter = DateFormat('dd MMMM yyyy', 'fr_FR');
    return formatter.format(date);
  }

  static String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'À l\'instant';
    } else if (difference.inMinutes < 60) {
      return 'Il y a ${difference.inMinutes}min';
    } else if (difference.inHours < 24) {
      return 'Il y a ${difference.inHours}h';
    } else if (difference.inDays == 1) {
      return 'Hier';
    } else if (difference.inDays < 7) {
      return 'Il y a ${difference.inDays} jours';
    } else {
      return formatDate(dateTime);
    }
  }
}
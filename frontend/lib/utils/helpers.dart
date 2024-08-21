import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Helpers {
  // Capitalize the first letter of a string
  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  // Check if the string is a valid email
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    final RegExp regex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return regex.hasMatch(email);
  }

  // Convert DateTime to a formatted string using Intl
  static String formatDateTime(DateTime dateTime,
      {String format = 'yyyy-MM-dd – kk:mm'}) {
    final DateFormat formatter = DateFormat(format);
    return formatter.format(dateTime);
  }

  // A function to truncate strings for display
  static String truncateString(String text, int length) {
    if (text.length <= length) return text;
    return text.substring(0, length) + '...';
  }

  double sumTransactionAmounts(List<Transaction>? transactions) {
    //ADD INCOME AND EXPENSE
    if (transactions == null || transactions.isEmpty) {
      return 0.0;
    }

    double totalAmount = 0.0;

    for (var transaction in transactions) {
      if (transaction != null && transaction.amount != null) {
        totalAmount += transaction.amount!;
      }
    }

    return totalAmount;
  }
}

class UIParameters {
  final double titleFontSize;
  final double textFontSize;
  final double searchBoxHeight;
  final double searchBoxWidth;
  final double iconSize;

  UIParameters(
      {required this.titleFontSize,
      required this.textFontSize,
      required this.searchBoxHeight,
      required this.searchBoxWidth,
      required this.iconSize});
}

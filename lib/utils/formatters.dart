import 'package:intl/intl.dart';

class Formatters {
  static String formatDate(String isoDate) {
    if (isoDate.isEmpty) return '';
    try {
      final date = DateTime.parse(isoDate);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return isoDate; 
    }
  }

  static String formatYear(String isoDate) {
    if (isoDate.isEmpty) return '';
    try {
      final date = DateTime.parse(isoDate);
      return DateFormat('yyyy').format(date);
    } catch (e) {
      return isoDate; 
    }
  }

  static String formatMoney(int amount) {
    if (amount <= 0) return 'N/A';
    
    if (amount >= 1000000) {
      final millions = amount / 1000000;
      final millionsStr = millions == millions.toInt() ? millions.toInt().toString() : millions.toStringAsFixed(1);
      return '\$${millionsStr}M';
    } else if (amount >= 1000) {
      final thousands = amount / 1000;
      final thousandsStr = thousands == thousands.toInt() ? thousands.toInt().toString() : thousands.toStringAsFixed(1);
      return '\$${thousandsStr}K';
    } else {
      return '\$$amount';
    }
  }

  static String formatDuration(int minutes) {
    if (minutes <= 0) return '';
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    
    if (hours > 0) {
      return '${hours}h ${remainingMinutes > 0 ? '${remainingMinutes}m' : ''}';
    }
    return '${remainingMinutes}m';
  }
  
  static String formatRating(double rating) {
    return rating.toStringAsFixed(1);
  }
}
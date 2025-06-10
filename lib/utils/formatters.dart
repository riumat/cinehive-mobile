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
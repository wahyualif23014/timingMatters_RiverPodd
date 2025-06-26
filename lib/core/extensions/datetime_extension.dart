// core/extensions/datetime_extension.dart
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  // Formatting helpers
  String get formatDate => DateFormat('dd MMM yyyy').format(this);
  String get formatTime => DateFormat('HH:mm').format(this);
  String get formatDateTime => DateFormat('dd MMM yyyy, HH:mm').format(this);
  String get formatDateShort => DateFormat('dd/MM/yy').format(this);
  String get formatTimeShort => DateFormat('HH:mm').format(this);
  String get formatDateTimeLong => DateFormat('EEEE, dd MMMM yyyy, HH:mm').format(this);
  String get formatWeekday => DateFormat('EEEE').format(this);
  String get formatMonth => DateFormat('MMMM').format(this);
  String get formatYear => DateFormat('yyyy').format(this);
  String get formatMonthYear => DateFormat('MMM yyyy').format(this);
  
  // ISO format
  String get toIsoString => toUtc().toIso8601String();
  
  // Relative time helpers
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);
    
    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '${years} year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '${months} month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
  
  String get timeUntil {
    final now = DateTime.now();
    final difference = this.difference(now);
    
    if (difference.isNegative) {
      return 'Overdue';
    }
    
    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '${years} year${years > 1 ? 's' : ''} left';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '${months} month${months > 1 ? 's' : ''} left';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} left';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} left';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} left';
    } else {
      return 'Due now';
    }
  }
  
  // Date comparison helpers
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
  
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }
  
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year && month == tomorrow.month && day == tomorrow.day;
  }
  
  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return isAfter(startOfWeek) && isBefore(endOfWeek);
  }
}
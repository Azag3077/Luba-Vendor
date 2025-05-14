import 'package:intl/intl.dart';

extension DatetimeUtils on DateTime {
  String toStr([String format = 'EEE, dd MMM yyyy']) =>
      DateFormat(format).format(this);

  String get toMonDayAndTime => DateFormat('MMM dd, hh:mm aaa').format(this);

  String get toTimeStr => DateFormat('hh:mma').format(this);

  String timeAgo([String suffix = '']) {
    final now = DateTime.now().toUtc();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return 'Now';
    } else if (difference.inMinutes < 60) {
      final mins = difference.inMinutes;
      return '$mins min${mins == 1 ? '' : 's'} $suffix';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours hr${hours == 1 ? '' : 's'} $suffix';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days day${days == 1 ? '' : 's'} $suffix';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks wk${weeks == 1 ? '' : 's'} $suffix';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months mon${months == 1 ? '' : 's'} $suffix';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years yr${years == 1 ? '' : 's'} $suffix';
    }
  }
}

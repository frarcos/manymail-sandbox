import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DateTimeUtils {
  static String localizeDateTime({
    required BuildContext context,
    DateTime? dateTime,
  }) {
    if (dateTime == null) return '';
    String locale = Localizations.localeOf(context).languageCode;
    String date = DateFormat.yMMMd(locale).format(dateTime);
    String time = DateFormat.jm(locale).format(dateTime);
    Duration difference = DateTime.now().difference(dateTime);
    String relativeTime = _getRelativeTime(difference);
    return '$date, $time ($relativeTime)';
  }

  static String _getRelativeTime(Duration difference) {
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }
}

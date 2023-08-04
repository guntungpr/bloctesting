import 'package:intl/intl.dart';

class CommonUtils {
  static String dateFormat(String pattern, DateTime date) {
    final DateFormat format = DateFormat(
      pattern,
    );
    return format.format(date);
  }
}

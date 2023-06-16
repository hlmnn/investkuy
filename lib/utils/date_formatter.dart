import 'package:intl/intl.dart';

class DateFormatter {
  static String convertToDate(String paramDate) {
    DateTime date = DateTime.parse(paramDate);
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);
    return formattedDate;
  }
}

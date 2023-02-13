import 'package:intl/intl.dart';

getTodayDate () {
  //get today date
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);
  return formattedDate;
}
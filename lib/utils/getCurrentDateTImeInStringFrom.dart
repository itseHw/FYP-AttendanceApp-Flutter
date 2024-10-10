import 'package:intl/intl.dart';

String getCurrentDateAndTimeInString(){
  DateTime currentDateTime = DateTime.now();
  DateFormat formatToString = DateFormat('yyyy-MM-dd HH:mm:ss');
  String stringForCurrentDateTime =  formatToString.format(currentDateTime);
  return stringForCurrentDateTime;
}
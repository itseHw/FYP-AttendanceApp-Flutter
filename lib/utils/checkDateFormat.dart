import 'package:intl/intl.dart';

bool checkDateFormat(String userInput){
  // I need the partern insert in database is yyyy-MM-dd
  print("Need Checking is: " + userInput);
  String regexDatePattern = r'^\d{4}-\d{2}-\d{2}$';

  RegExp checkingDateFormat = RegExp(regexDatePattern);

  if(checkingDateFormat.hasMatch(userInput)){
    return true;
  }else{
    return false;
  }
}

bool checkEndDateIsLateThanStartDate(String inputedStartDate, String inputedEndDate){
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime starting = dateFormat.parse(inputedStartDate);
  DateTime ending = dateFormat.parse(inputedEndDate);

  if(ending != null && starting != null){
    return ending.isAfter(starting);
  }

  return false;

}

bool checkLateThanToday(String inputedDateToVisit){

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime currentDate = DateTime.now();
  DateTime visitorInputDate = dateFormat.parse(inputedDateToVisit);

  if(visitorInputDate.isAfter(currentDate)){
    return true;
  }

  return false;

}
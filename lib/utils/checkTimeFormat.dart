bool checkTimeFormat(String userInput){
  // I need the partern insert in database is HH:mm:ss
  print("Need Checking is: " + userInput);
  String regexPattern = r'^([0-1][0-9|2[0-3]):([0-5][0-9]):([0-5][0-9])$';

  RegExp checkingTimeFormat = RegExp(regexPattern);

  if(checkingTimeFormat.hasMatch(userInput)){
    return true;
  }else{
    return false;
  }
}
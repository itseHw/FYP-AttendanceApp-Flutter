class DatePersonRecord{
  // used for staff attendance and vistor request
  final String date;
  final String time;
  final String staffName;
  final String accountEmail;
  final String attendanceRecord;// in or out
  final String situation;
  final String reMarks;


  DatePersonRecord({
    required this.date,
    required this.time,
    required this.staffName,
    required this.accountEmail,
    required this.attendanceRecord,
    required this.situation,
    required this.reMarks

  });
}
class PersonalAccountDetials{
  // used for staff attendance and vistor request
  String personalEmail;
  String personalPassword;
  String personalName;
  String personalAge;
  String personalContactNumber;
  String personalMemberType;
  String personalCompany;
  String personalState;



  PersonalAccountDetials({
    required this.personalEmail,
    required this.personalPassword,
    required this.personalName,
    required this.personalAge,
    required this.personalContactNumber,
    required this.personalMemberType,
    required this.personalCompany,
    required this.personalState
  });

  void clear() {
    personalEmail = "";
    personalPassword = "";
    personalName = "";
    personalAge ="";
    personalContactNumber = "";
    personalMemberType = "";
    personalCompany = "";
    personalState = "";
  }
}
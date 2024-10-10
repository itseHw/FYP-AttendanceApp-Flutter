import 'package:attendance_fyp_app/ITSSelectACManage_page.dart';
import 'package:attendance_fyp_app/changeTimeLimit_page.dart';
import 'package:attendance_fyp_app/datePicker.dart';
import 'package:attendance_fyp_app/home/login_page.dart';
import 'package:attendance_fyp_app/inputRangeOfDate_page.dart';
import 'package:attendance_fyp_app/onePersonAttendance_Page.dart';
import 'package:attendance_fyp_app/selectEmailToUpdateDetails_page.dart';
import 'package:attendance_fyp_app/selectQRCodeInOut_page.dart';
import 'package:attendance_fyp_app/selectTypeForCheckAttendance_page.dart';
import 'package:attendance_fyp_app/selectTypeToChangeTimeLimit_page.dart';
import 'package:attendance_fyp_app/selectTypeToUpdateDetail_page.dart';
import 'package:attendance_fyp_app/showTAQRCodeOut_page.dart';
import 'package:attendance_fyp_app/staffChooseOneDateToCheck_page.dart';
import 'package:attendance_fyp_app/staffSelectRangeForCheckingAttendance_page.dart';
import 'package:attendance_fyp_app/updateAccontDetailsByMyself_page.dart';
import 'package:attendance_fyp_app/updateAccontDetailsForIT_page.dart';
import 'package:attendance_fyp_app/useEmailToCheckAttendance_Page.dart';
import 'package:attendance_fyp_app/useQRCodeTA_page.dart';
import 'package:attendance_fyp_app/utils/getCurrentDateTImeInStringFrom.dart';
import 'package:attendance_fyp_app/utils/personalAccountDetails.dart';
import 'package:attendance_fyp_app/utils/visitorRequestDataSet.dart';
import 'package:attendance_fyp_app/visitRequestForm_page.dart';
import 'package:attendance_fyp_app/welcome_page.dart';
import 'package:attendance_fyp_app/createNewAccount_page.dart';
import 'package:attendance_fyp_app/showWorkerAttendance_page.dart';
import 'package:attendance_fyp_app/showVisitorRequest_page.dart';
import 'package:attendance_fyp_app/showVisitApprove_page.dart';
import 'package:attendance_fyp_app/checkVisitRequestApprove_page.dart';
import 'package:attendance_fyp_app/showTAQRCode_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:attendance_fyp_app/utils/datePersonRecord.dart';
import 'package:attendance_fyp_app/useNameCheckAttendance.dart';
import 'package:attendance_fyp_app/widgets/colorsSetting.dart';
import 'package:intl/intl.dart';

class AuthController extends GetxController{
  //AuthController.intance..
  // static AuthController instance = Get.find();
  final String apiUrl = 'http://localhost:3000/api'; // for All started api using this
  late String theEmail;
  late String theName;
  late String theMemeberType;
  late String theCompany;
  late String theContactNumber;
  late String theLateLimit;
  late String theEarlyLeaveLimit;
  String theNeedChangeTimeLimitTypeIS = "";
  List<DatePersonRecord> dataCallBack = []; // to save the data from 
  List<String> callStaffNameList = []; // to save the staff name
  List<VisitorDateRequsetRecord> callBackVisitRecord = [];
  PersonalAccountDetials acDataBack =PersonalAccountDetials(personalEmail: "", personalPassword: "", personalName: "", personalAge: "", personalContactNumber: "", personalMemberType: "", personalCompany: "", personalState: "");
  

  void clearTheNeedChangeTimeLimitTypeIS(){
    theNeedChangeTimeLimitTypeIS = "";
  }

  void clearUserData(){
    //to clear the logined user data
    theEmail = '';
    theName ='';
    theMemeberType = ''; 
    theCompany = '';
    theContactNumber = '';
    theLateLimit = '';
    theEarlyLeaveLimit = '';
  }

  void clearTimeLimit(){
    theLateLimit = '';
    theEarlyLeaveLimit = '';
  }

  void clearListData(){
    //to Clear the dataCallBack to prevent any data do not belong to the new api call back data
    dataCallBack.clear();
    // dataCallBack = [];
  }

  void clearPersonalAccountData(){
    // to Clear the dataCallBack to prevent any data do not belong to the new api call back data
    acDataBack.clear();
    // dataCallBack = [];
  }

  void clearCallStaffNameList(){
    //to clear the callStaffNameList to prevent any data do not belong to the new api call back data
    callStaffNameList.clear();
  }

  void clearVisitRecordData(){
    // to Clear the dataCallBack to prevent any data do not belong to the new api call back data
    callBackVisitRecord.clear();
    // dataCallBack = [];
  }

  //for getting the late and early leave time
  Future<void> getTimeLimitForEachTypeOfStaff(String needGetTypeIS) async{
    // String loginerType = theMemeberType;
    clearTimeLimit();
    
    try{
      final headers ={'Content-Type': 'application/json'};
      final body = json.encode({'staffTypeIs' : needGetTypeIS}); // the staffTypeIs should be Office worker or IT Support
      print(body);
      final response = await http.post(Uri.parse('$apiUrl/getTimeLimitByType'), headers: headers, body: body);
      // givebackData reponse base on different status code
      if(response.statusCode == 200){
        //get successful
        final gotLimitFor = json.decode(response.body);
        theLateLimit = gotLimitFor['lateLimit'];
        theEarlyLeaveLimit = gotLimitFor['elaryLeaveLimit'];
      }else if(response.statusCode == 401){
        final errorShow = json.decode(response.body);
        final errorMessage = errorShow['error'];
        Get.snackbar("Checking", "Checking Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Can not find",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            errorMessage.toString(),
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
      }
    }catch(error){
      //print ('Error: $error');
      Get.snackbar("Checking", "Checking Message",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Find failed",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          error.toString(),
          style: TextStyle(
              color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }

  }

  
  Future<void> loginUser(String loginEmail, String loginPassword) async{
          // print(loginEmail);
    try{
      final headers ={'Content-Type': 'application/json'};
      final body = json.encode({'email' : loginEmail,
        'password' : loginPassword});
      final response = await http.post(Uri.parse('$apiUrl/loginRequest'), headers: headers, body: body);
      // final response = await http.post(Uri.parse('$apiUrl/loginRequest'),body:{
      //   'email' : loginEmail,
      //   'password' : loginPassword,
      // });


      // login reponse base on different status code
      if(response.statusCode == 200){
        //Login successful
        final returnData = json.decode(response.body);
        theEmail = loginEmail;
        theName = returnData['name'];
        theMemeberType = returnData['memberType'];
        theCompany = returnData['company'];
        theContactNumber = returnData['contactNumber'];
        // if(theMemeberType == "Office worker"|| theMemeberType == "IT Support"){
        //   getTimeLimitForEachTypeOfStaff();
        // }
        // Future.delayed(Duration(seconds: 1),(){
          Get.off(()=>WelcomePage());
        // });
      }else if(response.statusCode == 401){
        final errorShow = json.decode(response.body);
        final errorMessage = errorShow['error'];
        Get.snackbar("Login", "Login Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Login failed",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            errorMessage.toString(),
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
      }
    }catch(error){
      //print ('Error: $error');
      Get.snackbar("Login", "Login Message",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Login failed",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          error.toString(),
          style: TextStyle(
              color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }
  }

  Future<void> visitorSignUp(String newEmail, String newPassword, String newName, String newAge, String newContactNumber, String newWorkCompany) async{
          // print(loginEmail);
    try{
      final headers ={'Content-Type': 'application/json'};
      final body = json.encode({'vsEmail' : newEmail,
        'vsPassword' : newPassword,
        'vsName' : newName,
        'vsAge' : newAge,
        'vsContactNumber' : newContactNumber,
        'vsMemberType' : 'Visitors',
        'vsCompany' : newWorkCompany,
        'vsState' : 'available'
        });
      final response = await http.post(Uri.parse('$apiUrl/createNewAccount'), headers: headers, body: body);
      // final response = await http.post(Uri.parse('$apiUrl/loginRequest'),body:{
      //   'email' : loginEmail,
      //   'password' : loginPassword,
      // });

      // Sign Up reponse base on different status code
      if(response.statusCode == 200){
        //Login successful
        // final returnVSData = json.decode(response.body);
        theEmail = newEmail;
        theName = newName;
        theMemeberType = 'Visitors';
        theCompany = newWorkCompany;
        theContactNumber = newContactNumber;
        Get.off(()=>WelcomePage());
      }else if(response.statusCode == 409){
        final errorShow = json.decode(response.body);
        final errorMessage = errorShow['error'];
        Get.snackbar("Sign Up", "Sign Up Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Sign Up failed",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            errorMessage.toString(),
            // "Email already exists",
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
      }else{
        final errorShow = json.decode(response.body);
        final errorMessage = errorShow['error'];
        Get.snackbar("Sign Up", "Sign Up Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Sign Up failed",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            errorMessage.toString(),
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
      }
    }catch(error){
      //print ('Error: $error');
      Get.snackbar("Sign Up", "Sign Up Message",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Login failed",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          error.toString(),
          style: TextStyle(
              color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }
  }

  Future<void> logOut() async{
    // if log out button clicked
    clearUserData();
    clearCallStaffNameList();
    clearListData();
    clearPersonalAccountData();
    clearVisitRecordData();
    Get.off(()=>LoginPage());
  }

  //use for go to the target page
  Future<void> backtoWelcomPage() async{
    // if clicked, back to welcomPage()
    Get.off(()=>WelcomePage());
  }

  Future<void> seeOneAttendance() async{
    // if clicked, It Support or Office Worker see thier own record
    Get.off(()=>OnePersonAttendancePage());
  }

  Future<void> showTAQRCode() async{  //TA = take attendance
    // if clicked, back to welcomPage()
    // Get.off(()=>ShowTAQRCodeInPage()); //test for In Page
    Get.off(()=>selectQRCodeInOutPage()); // move to click In Or Out QR CODE Page
  }

  Future<void> showQRCodeForStaffIn() async{
    Get.off(()=>ShowTAQRCodeInPage()); // for QR Code In Page
  }

  Future<void> showQRCodeForStaffOut() async{
    Get.off(()=>ShowTAQRCodeOutPage()); // for QR Code Out Page
  }

  Future<void> qrCodeTakeAttendance() async{
    // if clicked, It Support or Office Worker go to use camera to scan QR Code for take attandance
    if(theMemeberType == "Office worker"|| theMemeberType == "IT support"){
          getTimeLimitForEachTypeOfStaff(theMemeberType);
    }
    Future.delayed(Duration(seconds: 1),(){
      Get.off(()=>UseQRCodeTAPage());
    });
  }

  Future<void> iTSupportSelectAccountManage() async{
    // if clicked, It Support go to createNewAccountPage for create new account with the new company worker
    Get.off(()=>   selectACManagePage());
  }

  Future<void> createNewAccount() async{
    // if clicked, It Support go to createNewAccountPage for create new account with the new company worker
    Get.off(()=>   CreateNewAccountPage());
  }

  Future<void> seeAttendance() async{
    // if clicked,go to showAllWorkerAttandancePage for check worker attendance
    //boss check all staff, staff check theirself
    Get.off(()=>   ShowWorkerAttendancePage());
  }

  Future<void> selectDateForCheckingAttendance() async{
    //boss check the attendance by date
    Get.off(() => DatePickerWidget());
  }

  Future<void> changePersonalAccountDetails() async{
    //For changing the user own account details
    // Get.off(() => updateAccountDetailsByMyselfPage());
    getAccountDetailsFromApi(theEmail, "selfUpdateACData");
  }

    Future<void> goToSelectTypeCheckAttendance() async{
    //For changing the user own account details
    Get.off(() => selectTypeCheckAttendance_page());
  }


  //boss check the attendance by name
  Future<void> selectNameForCheckingAttendance() async{
    //clear the data first to prevent any over display
    clearCallStaffNameList();

    try{
      final headers ={'Content-Type': 'application/json'};
      // final body = json.encode({'checkingType' : "", 'checkingType': checkingType}); // the checkKeyWords should be date or staff name, checking type should date or name
      // print(body);
      final response = await http.post(Uri.parse('$apiUrl/getStaffName'), headers: headers);//, body: body);
      // givebackData reponse base on different status code
      if(response.statusCode == 200){
        //get successful
        final dynamic decodedResBody = json.decode(response.body);
        callStaffNameList = List<String>.from(decodedResBody);
        print(callStaffNameList);
        if(callStaffNameList.length == 0){ // ==[]
          Get.snackbar("Checking", "Checking Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "No Record",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            "No Record Find in Data base!",
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
        }else{
          Get.off(() => staffNameCheckAttendanceRecord_Page());
        }
      }else if(response.statusCode == 401){
        final errorShow = json.decode(response.body);
        final errorMessage = errorShow['error'];
        Get.snackbar("Checking", "Checking Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Can not search",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            errorMessage.toString(),
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
      }
    }catch(error){
      //print ('Error: $error');
      Get.snackbar("Checking", "Checking Message",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Check failed",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          error.toString(),
          style: TextStyle(
              color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }

  }

  Future<void> goToStaffSelectRangeForCheckingAttendacnepage () async{
    Get.off(() => staffSelectRangeForCheckingAttendance_page());
  }

  Future<void> staffGoToPickOneDate() async{
    Get.off(() => staffDatePicker_page(needCheckStaffIs: theEmail));
  }

  Future<void> goToInputRangeOfDateChecking(String needCheckEmailOrnot) async{
    await Future.delayed(Duration(seconds: 1));
    Get.off(inputRangeOfDateChecking(needCheckStaffEmailIs: needCheckEmailOrnot));
  }

  Future<void> showVisitRequest() async{
    // if clicked, Boss go to ShowVisitorRequestPage for check and approve or disagree the visitor vistit request
    bossGetVisitRequestRecordFromApi();
    await Future.delayed(Duration(seconds: 1));
    Get.off(()=>   visitRequestRecordPage());
  }

  Future<void> showVisitorApprove() async{
    // if clicked, Visitor go to ShowVisitApprovePage for showing qr code that can let visitor check the visitor
    // Get.off(()=>   ShowVisitApprovePage());
    visitorGetVisitRequestRecordFromApi();
    await Future.delayed(Duration(seconds: 1));
    Get.off(()=>   ShowVisitApprovePage());
  }

  Future<void> showVisitApplicationForm() async{
    // if clicked, Visitor go to ShowVisitApprovePage for showing qr code that can let visitor check the visitor
    Get.off(()=>   visitRequestFromPage());
  }


  // Future<void> showVisitRequestApproveRecord() async{
  //   // if clicked, Boss go to ShowVisitorRecoredPage for visiotr check the request approve or disagreed by the Boss
  //   Get.off(()=>   ShowVisitRequestApprovePage());
  // }

  Future<void> selectNeedUpdateDetailsAccountType() async{
    // if clicked, Boss go to ShowVisitorRecoredPage for visiotr check the request approve or disagreed by the Boss
    Get.off(()=>   selectTypeUpdateDetailPage());
  }

  // Future<void> selectNameToUpdateDetails (String selectedType) async{
  //   Get.off(() => selectNameToUpdateDetailsPage());
  // }

  //end of go to target page


  //boss check staff attendance or staff check it own attendance
  //boss can check all staff attendance, staff only check their own attendance
  Future<void> getStaffAttendanceFromApi(String checkForWhat, String checkingType) async{
    //clear the data first to prevent any over display
    clearListData();
    try{
      final headers ={'Content-Type': 'application/json'};
      final body = json.encode({'checkWordsForWhat' : checkForWhat, 'checkingType': checkingType}); // the checkKeyWords should be date or staff name, checking type should date or name
      print(body);
      final response = await http.post(Uri.parse('$apiUrl/checkStaffAttendance'), headers: headers, body: body);
      // givebackData reponse base on different status code
      if(response.statusCode == 200){
        //get successful
        final returnDPData = json.decode(response.body);
        print(returnDPData);
        dataCallBack = _parseData(returnDPData);
        print(dataCallBack);
        if(dataCallBack.length == 0){ // ==[]
          Get.snackbar("Checking", "Checking Message",
          // backgroundColor: Colors.redAccent,
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "No Record",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            "No Record Find in Data base!",
            style: TextStyle(
                // color:  Colors.grey
                color:  MyAppColorSetting.getMessageTextColor(),
            ),
          )
        );
        }else{
          Get.off(()=>OnePersonAttendancePage());
        }
      }else if(response.statusCode == 401){
        final errorShow = json.decode(response.body);
        final errorMessage = errorShow['error'];
        Get.snackbar("Checking", "Checking Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Can not search",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            errorMessage.toString(),
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
      }
    }catch(error){
      //print ('Error: $error');
      Get.snackbar("Checking", "Checking Message",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Check failed",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          error.toString(),
          style: TextStyle(
              color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }

  }

  //Staff check attendance in one date or range of Date
  Future<void> getStaffAttendanceinRangeDateFromApi(String checkingPersonEmailIs, String checkingStarDate, String checkingEndDate) async{
    //clear the data first to prevent any over display
    clearListData();
    try{
      final headers ={'Content-Type': 'application/json'}; 
      final body = json.encode({'checkingTheEmail' : checkingPersonEmailIs, 'checkStartDate': checkingStarDate, 'checkEndDate' : checkingEndDate}); // the checkKeyWords should be date or staff name, checking type should date or name
      print(body);
      final response = await http.post(Uri.parse('$apiUrl/checkStaffInRangeDate'), headers: headers, body: body);
      // givebackData reponse base on different status code
      if(response.statusCode == 200){
        //get successful
        final returnDPData = json.decode(response.body);
        print(returnDPData);
        dataCallBack = _parseData(returnDPData);
        print(dataCallBack);
        if(dataCallBack.length == 0){ // ==[]
          Get.snackbar("Checking", "Checking Message",
          // backgroundColor: Colors.redAccent,
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "No Record",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            "No Record Find in Data base!",
            style: TextStyle(
                // color:  Colors.grey
                color:  MyAppColorSetting.getMessageTextColor(),
            ),
          )
        );
        }else{
          Get.off(()=>OnePersonAttendancePage());
        }
      }else if(response.statusCode == 401){
        final errorShow = json.decode(response.body);
        final errorMessage = errorShow['error'];
        Get.snackbar("Checking", "Checking Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Can not search",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            errorMessage.toString(),
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
      }
    }catch(error){
      //print ('Error: $error');
      Get.snackbar("Checking", "Checking Message",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Check failed",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          error.toString(),
          style: TextStyle(
              color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }

  }

  // For IT support to create account
  Future<void> itSupportCreateAccount(String newEmail, String newPassword, String newName, String newAge, String newContactNumber, String newMemberType, String newWorkCompany) async{ // Company may change name
          // print(loginEmail);
    try{
      final headers ={'Content-Type': 'application/json'};
      final body = json.encode({'vsEmail' : newEmail,
        'vsPassword' : newPassword,
        'vsName' : newName,
        'vsAge' : newAge,
        'vsContactNumber' : newContactNumber,
        'vsMemberType' : newMemberType,
        'vsCompany' : newWorkCompany,
        'vsState' : 'available'
        });
      final response = await http.post(Uri.parse('$apiUrl/createNewAccount'), headers: headers, body: body);

      // Sign Up reponse base on different status code
      if(response.statusCode == 200){
        Get.off(()=>WelcomePage()); 
        // a message for create successful?
      }else if(response.statusCode == 409){
        final errorShow = json.decode(response.body);
        final errorMessage = errorShow['error'];
        Get.snackbar("Create account", "Create Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Create failed",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            errorMessage.toString(),
            // "Email already exists",
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
      }else{
        final errorShow = json.decode(response.body);
        final errorMessage = errorShow['error'];
        Get.snackbar("Create Account", "Sign Up Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Sign Up failed",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            errorMessage.toString(),
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
      }
    }catch(error){
      //print ('Error: $error');
      Get.snackbar("Create Account", "Create Message",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Create failed",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          error.toString(),
          style: TextStyle(
              color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }
  }

  //For Boss go to select Type to change the Time Limit
  Future<void> selectTypeToChangeTimeLimit() async{
    Get.off(()=>   selectTypeChangeTimeLimit_page());
  }

  //For Boss select type to change time limt and call API to get the time limit and go To changeTimeLimit Page
  Future<void> goToChangeTimeLimitPage(String selectedAccountType) async{
    //clear the data first to prevent any over display
    // clearTimeLimit();
    clearTheNeedChangeTimeLimitTypeIS();
    theNeedChangeTimeLimitTypeIS = selectedAccountType;

    getTimeLimitForEachTypeOfStaff(selectedAccountType);

    Future.delayed(Duration(seconds: 1),(){
      Get.off(()=>ChangeTimeLimit_page());
    });
    
  }

  //For Boss change the timelimit and Call API
  Future<void> bossChangeTimeLimit(String needChangeLimitTypeIS, String changedLateLimit, String changedEarlyLeaveLimit) async{
    // print(loginEmail);
    String changeLimitRemarks = "Change on " + getCurrentDateAndTimeInString();
    try{
      final headers ={'Content-Type': 'application/json'};
      final body = json.encode({'staffTypeIs' : needChangeLimitTypeIS,
        'changedLateLimit' : changedLateLimit,
        'changedEarlyLeaveLimit' : changedEarlyLeaveLimit,
        'changedRemarks' : changeLimitRemarks,
        });
      final response = await http.post(Uri.parse('$apiUrl/changeTimeLimitByBoss'), headers: headers, body: body);

      // Sign Up reponse base on different status code
      if(response.statusCode == 200){
        Get.off(() => WelcomePage());
      }else{
        final errorShow = json.decode(response.body);
        final errorMessage = errorShow['error'];
        Get.snackbar("Change Time Limit", "Change Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Change Time Limit failed",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            errorMessage.toString(),
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
      }
    }catch(error){
      //print ('Error: $error');
      Get.snackbar("Change Time Limit", "Change Message",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Change Time Limit failed",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          error.toString(),
          style: TextStyle(
              color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }
  }


  Future<void> staffUseQrCodeCallAPIToTakeAttendance(String newRecDate, String newRecTime, String newRecStaffName, String newRecAccountEmail, String newRecAttendanceRecord, String newRecSituation, String newRecReMarks) async{
          // print(loginEmail);
    try{
      final headers ={'Content-Type': 'application/json'};
      final body = json.encode({'sDate' : newRecDate,
        'sTime' : newRecTime,
        'sStaffName' : newRecStaffName,
        'sEmail' : newRecAccountEmail,
        'sAttendanceRecord' : newRecAttendanceRecord,
        'sSituation' : newRecSituation,
        'sReMarks' : newRecReMarks
        });
      final response = await http.post(Uri.parse('$apiUrl/insertAttendanceRecord'), headers: headers, body: body);
      // final response = await http.post(Uri.parse('$apiUrl/loginRequest'),body:{
      //   'email' : loginEmail,
      //   'password' : loginPassword,
      // });

      // Sign Up reponse base on different status code
      if(response.statusCode == 200){
        //Login successful
        // final returnVSData = json.decode(response.body);
        // Get.off(()=>getStaffAttendanceFromApi(newRecStaffName, "checkStaffName"));
        Get.off(() => WelcomePage());
      }else{
        final errorShow = json.decode(response.body);
        final errorMessage = errorShow['error'];
        Get.snackbar("Sign Up", "Sign Up Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Insert Record failed",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            errorMessage.toString(),
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
      }
    }catch(error){
      //print ('Error: $error');
      Get.snackbar("Sign Up", "Sign Up Message",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Login failed",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          error.toString(),
          style: TextStyle(
              color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }
  }

  //For Boss get Email, for select Email ToCheck Attendance Page
  Future<void> goToSelectEmailToCheckPage(String selectedAccountType) async{
    //clear the data first to prevent any over display
    clearCallStaffNameList();

    try{
      final headers ={'Content-Type': 'application/json'};
      final body = json.encode({'memberType': selectedAccountType}); //  checking type should be Office worker, IT support, Boss, Visitors
      print(body);
      final response = await http.post(Uri.parse('$apiUrl/getAccountEmailByType'), headers: headers, body: body);

      if(response.statusCode == 200){
        //get successful
        final dynamic decodedResBody = json.decode(response.body);
        callStaffNameList = List<String>.from(decodedResBody);
        print(callStaffNameList);
        if(callStaffNameList.length == 0){ // ==[]
          Get.snackbar("Checking", "Checking Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "No Record",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            "No Record Find in Data base!",
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
        }else{
          Get.off(() => staffEmailCheckAttendanceRecord_Page());
        }
      }else if(response.statusCode == 401){
        final errorShow = json.decode(response.body);
        final errorMessage = errorShow['error'];
        Get.snackbar("Checking", "Checking Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Can not find",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            errorMessage.toString(),
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
      }
    }catch(error){
      //print ('Error: $error');
      Get.snackbar("Checking", "Checking Message",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Check failed",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          error.toString(),
          style: TextStyle(
              color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }
  }

  //For IT support get Name, for selectNameToUpdateDetailsPage
  Future<void> goToSelectEmailToUpdateDetailsPage(String selectedAccountType) async{
    //clear the data first to prevent any over display
    clearCallStaffNameList();

    try{
      final headers ={'Content-Type': 'application/json'};
      final body = json.encode({'memberType': selectedAccountType}); //  checking type should be Office worker, IT support, Boss, Visitors
      print(body);
      final response = await http.post(Uri.parse('$apiUrl/getAccountEmailByType'), headers: headers, body: body);

      if(response.statusCode == 200){
        //get successful
        final dynamic decodedResBody = json.decode(response.body);
        callStaffNameList = List<String>.from(decodedResBody);
        print(callStaffNameList);
        if(callStaffNameList.length == 0){ // ==[]
          Get.snackbar("Checking", "Checking Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "No Record",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            "No Record Find in Data base!",
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
        }else{
          Get.off(() => selectEmailToUpdateDetailsPage());
        }
      }else if(response.statusCode == 401){
        final errorShow = json.decode(response.body);
        final errorMessage = errorShow['error'];
        Get.snackbar("Checking", "Checking Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Can not find",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            errorMessage.toString(),
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
      }
    }catch(error){
      //print ('Error: $error');
      Get.snackbar("Checking", "Checking Message",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Check failed",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          error.toString(),
          style: TextStyle(
              color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }
  }

  //get the account details, if successful
  Future<void> getAccountDetailsFromApi(String checkKeyWords, String actionTo) async{
    //clear the data first to prevent any overlap
    clearPersonalAccountData();

    try{
      final headers ={'Content-Type': 'application/json'};
      final body = json.encode({'email' : checkKeyWords}); // the checkKeyWords should be email
      print(body);
      final response = await http.post(Uri.parse('$apiUrl/findAccountDetailsByEmail'), headers: headers, body: body);
      // givebackData reponse base on different status code
      if(response.statusCode == 200){
        //get successful
        final dynamic retrunRecord = json.decode(response.body);
        print(retrunRecord);
        acDataBack = _parseDataToPersonal(retrunRecord);
        print(acDataBack);
        if(actionTo == "itUpdateACData"){
          Get.off(()=>updateAccountDetailsForITPage());
        }else if(actionTo == "selfUpdateACData"){
          Get.off(()=>updateAccountDetailsByMyselfPage());
        }else{
          Get.snackbar("Checking", "Checking Message",
            backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
              "Check failed",
              style: TextStyle(
                color: MyAppColorSetting.getMessageTitleColor()
              ),
            ),
            messageText: Text(
              "error here!",
              style: TextStyle(
                  color:  MyAppColorSetting.getMessageTextColor()
              ),
            )
          );
        }
      }else if(response.statusCode == 401){
        final errorShow = json.decode(response.body);
        final errorMessage = errorShow['error'];
        Get.snackbar("Checking", "Checking Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Can not search",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            errorMessage.toString(),
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
      }
    }catch(error){
      //print ('Error: $error');
      Get.snackbar("Checking", "Checking Message",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Check failed",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          error.toString(),
          style: TextStyle(
              color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }
  }

  
  //all people can change the details without the email for their account, IT support can help others changing without email
  Future<void> callAPIToUpdateAccountDetails(String needChaEmail, String needChaPassword, String needChaName, String needChaAge, String needChaContactNumber,String needChaMemberType, String needChaWorkCompany, String needChaState, String changeFromWhichPage) async{    
    try{
      final headers ={'Content-Type': 'application/json'};
      final body = json.encode({'chaEmail' : needChaEmail,
                                'chaPassword' : needChaPassword,
                                'chaName' : needChaName,
                                'chaAge' : needChaAge,
                                'chaContactNumber' : needChaContactNumber,
                                'chaMemberType' : needChaMemberType,
                                'chaCompany' : needChaWorkCompany,
                                'chaState' : needChaState
        });
      final response = await http.post(Uri.parse('$apiUrl/changeAccountDetails'), headers: headers, body: body);

      if(response.statusCode == 200){
        //change successful
        // final returnVSData = json.decode(response.body);
        if(changeFromWhichPage == "notFromITStaffChangePage"){
          theName = needChaName;
        }
        Get.off(()=>WelcomePage());
      }else if(response.statusCode == 409){
        final errorShow = json.decode(response.body);
        final errorMessage = errorShow['error'];
        Get.snackbar("Change Data", "Change Account Details Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Change failed",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            errorMessage.toString(),
            // "Email already exists",
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
      }else{
        final errorShow = json.decode(response.body);
        final errorMessage = errorShow['error'];
        Get.snackbar("Change Details", "Change Account Details Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Change Details failed",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            errorMessage.toString(),
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
      }
    }catch(error){
      //print ('Error: $error');
      Get.snackbar("Change Details", "Change Account Details Message",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Change failed",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          error.toString(),
          style: TextStyle(
              color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }
  }


  // used for boss check staff attendance; staff check attendance
  List<DatePersonRecord> _parseData(dynamic returnDPData){
    List<DatePersonRecord> itemList = [];
    
    // reversed data and create DatePersonRecord object
    for( var recordData in returnDPData.reversed){ //because the new record get from Microsoft AZURE Cosmos DB is the last one, I want the new one be the first one to show.fv
      var record = DatePersonRecord(
        date:recordData['date'],
        time: recordData['time'],
        staffName: recordData['staffName'],
        accountEmail: recordData['accountEmail'],
        attendanceRecord: recordData['attendanceRecord'],
        situation: recordData['situation'],
        reMarks: recordData['reMarks']
      );
        
        itemList.add(record); //
    }//;
    return itemList;
  }

  //for change account data use
  PersonalAccountDetials _parseDataToPersonal(dynamic returnPersonalData){
    List<DatePersonRecord> itemList = [];
    
      PersonalAccountDetials _ParseRecord  = PersonalAccountDetials(
        personalEmail: returnPersonalData["email"],
        personalPassword: returnPersonalData["password"],
        personalName: returnPersonalData["name"],
        personalAge: returnPersonalData["age"],
        personalContactNumber: returnPersonalData["contactNumber"],
        personalMemberType: returnPersonalData["memberType"],
        personalCompany: returnPersonalData["company"],
        personalState: returnPersonalData["state"]
       );
        print("changed!!!");
    return _ParseRecord;
  }

  //Visitor Application Form call api to insert the request
  Future<void> visitorApplictionCallAPIRequest(String formInputedVisitDate,String formInputedVisitTime, String formInputerEmail, String formInputerName, String formInputerContactNumber, String formInputerCompany, String formApplicationDate) async{
          // print(loginEmail);
    try{
      final headers ={'Content-Type': 'application/json'};
      final body = json.encode({'newVisitDate' : formInputedVisitDate,
                                'newVisitTime' : formInputedVisitTime,
                                'newBookerEmail' : formInputerEmail,
                                'newBookerName' : formInputerName,
                                'newBookerContactNumber' : formInputerContactNumber,
                                'newBookerCompany' : formInputerCompany,
                                'newBookingDate' : formApplicationDate,
                                'newRequestState' : "Waiting Approve"                               
                              });
      final response = await http.post(Uri.parse('$apiUrl/insertVisitRequest'), headers: headers, body: body); // need produce api

      if(response.statusCode == 200){
        //Login successful
        // Get.off(()=>ShowVisitApprovePage());
        Get.off(()=>WelcomePage());
      }else if(response.statusCode == 401){
        final errorShow = json.decode(response.body);
        final errorMessage = errorShow['error'];
        Get.snackbar("Application", "Application Message",
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Applicatino failed",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            errorMessage.toString(),
            style: TextStyle(
                color:  MyAppColorSetting.getMessageTextColor()
            ),
          )
        );
      }
    }catch(error){
      //print ('Error: $error');
      Get.snackbar("Application", "Application Message",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Application failed",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          error.toString(),
          style: TextStyle(
              color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }
  }

  //get the visit request record, if successful
  Future<void> visitorGetVisitRequestRecordFromApi() async{
    //clear the data first to prevent any overlap
     clearVisitRecordData();
    try{
      final headers ={'Content-Type': 'application/json'};
      final body = json.encode({'whoChecking' : theEmail}); // the checkKeyWords should be date or staff name, checking type should date or name
      print(body);
      final response = await http.post(Uri.parse('$apiUrl/checkVisitRecord'), headers: headers, body: body);
      // givebackData reponse base on different status code
      if(response.statusCode == 200){
        //get successful
        final returnVVistorRecord = json.decode(response.body);
        // print(returnVVistorRecord);
        callBackVisitRecord = _parseVisitorRecord(returnVVistorRecord);
        print(callBackVisitRecord);
        if(callBackVisitRecord.length == 0){ // ==[]
          Get.snackbar("Checking", "Checking Message",
          // backgroundColor: Colors.redAccent,
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Visit Request No Record",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            "No Record Find in Data base!",
            style: TextStyle(
                // color:  Colors.grey
                color:  MyAppColorSetting.getMessageTextColor(),
            ),
          )
        );
        }else{
          // Get.off(()=>showVisitorApprove());
          print("Successful get");
        }
      }
    }catch(error){
      //print ('Error: $error');
      Get.snackbar("Checking", "Checking Message",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Check failed",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          error.toString(),
          style: TextStyle(
              color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }
  }

   //get the visit request record, if successful By Boss
  Future<void> bossGetVisitRequestRecordFromApi() async{
    //clear the data first to prevent any overlap
     clearVisitRecordData();
    try{
      final headers ={'Content-Type': 'application/json'};
      final body = json.encode({'whoChecking' : "Boss"}); // the checkKeyWords should be date or staff name, checking type should date or name
      print(body);
      final response = await http.post(Uri.parse('$apiUrl/checkVisitRecord'), headers: headers, body: body);
      // givebackData reponse base on different status code
      if(response.statusCode == 200){
        //get successful
        final returnVVistorRecord = json.decode(response.body);
        // print(returnVVistorRecord);
        callBackVisitRecord = _parseVisitorRecord(returnVVistorRecord);
        print(callBackVisitRecord);
        if(callBackVisitRecord.length == 0){ // ==[]
          Get.snackbar("Checking", "Checking Message",
          // backgroundColor: Colors.redAccent,
          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Visit Request No Record",
            style: TextStyle(
              color: MyAppColorSetting.getMessageTitleColor()
            ),
          ),
          messageText: Text(
            "No Record Find in Data base!",
            style: TextStyle(
                // color:  Colors.grey
                color:  MyAppColorSetting.getMessageTextColor(),
            ),
          )
        );
        }else{
          // Get.off(()=>showVisitorApprove());
          print("Successful get");
        }
      }
    }catch(error){
      //print ('Error: $error');
      Get.snackbar("Checking", "Checking Message",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Check failed",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          error.toString(),
          style: TextStyle(
              color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }
  }

  List<VisitorDateRequsetRecord> _parseVisitorRecord(dynamic returnVRData){
    List<VisitorDateRequsetRecord> visitRecordList = [];
    print(returnVRData);
    // reversed data and create DatePersonRecord object
    for( var returnVRData in returnVRData.reversed){ //because the new record get from Microsoft AZURE Cosmos DB is the last one, I want the new one be the first one to show.
      var vRecord = VisitorDateRequsetRecord(
        visitDate:returnVRData['visitDate'],
        visitTime: returnVRData['visitTime'],
        bookerEmail: returnVRData['bookerEmail'],
        bookerName: returnVRData['bookerName'],
        bookerContactNumber: returnVRData['bookerContactNumber'],
        bookerCompany: returnVRData['bookerCompany'],
        bookingDate: returnVRData['bookingDate'],
        requestState: returnVRData['requestState']
      );
        
        visitRecordList.add(vRecord); //
    }//;
    return visitRecordList;
  }

}
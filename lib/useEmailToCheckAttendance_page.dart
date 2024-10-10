import 'package:attendance_fyp_app/widgets/colorsSetting.dart';
import 'package:attendance_fyp_app/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:get/get.dart';
import 'package:attendance_fyp_app/utils/dimensions.dart';

final AuthController authController = Get.find<AuthController>();

class staffEmailCheckAttendanceRecord_Page extends StatefulWidget{
  @override
  staffEmailCheckAttendanceRecord_PageState createState() => staffEmailCheckAttendanceRecord_PageState();
}

class staffEmailCheckAttendanceRecord_PageState extends State<staffEmailCheckAttendanceRecord_Page>{

  List<String> checkStaffEmailList = [];
  // authController.callStaffNameList;
 //["ABC1", "2BCD2", "CHAN DA MAN"];
  String emailSelected = "";

  void _onDropdownItemSelected(String? selectedItem){ //when boss choose the name, nameSelected should changed, selectedItem is boss clicked the name
    setState(() {
      emailSelected = selectedItem!;
      print(emailSelected);
    });
  }
  

  void checkStaffEmailAllRecordButtonClicked(){
    if(emailSelected != ""){
      print("button clicked: "+ emailSelected);
      authController.getStaffAttendanceFromApi(emailSelected, "checkStaff");
    }else{
      Get.snackbar("Date", "Date select",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "No Name selected",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          'Please select a Name!',
          style: TextStyle(
            color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }
  }

  
  void checkStaffEmailRecordInDateRangeButtonClicked(){
    if(emailSelected != ""){
      print("button clicked: "+ emailSelected);
      authController.goToInputRangeOfDateChecking(emailSelected);
      // authController.getStaffAttendanceFromApi(emailSelected, "checkStaff");
    }else{
      Get.snackbar("Date", "Date select",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "No Name selected",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          'Please select a Name!',
          style: TextStyle(
            color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }
  }

  
  @override
  void initState(){
    super.initState();
    initialDropdownItems();
  }

  Future<void> initialDropdownItems() async {

    // await Future.delayed(Duration(seconds: 5));
    checkStaffEmailList =  authController.callStaffNameList;
    emailSelected = checkStaffEmailList.first;
    // nameSelected = checkStaffNameList.isNotEmpty ? checkStaffNameList.first :'';

    setState(() {
      //to update state
    });
  }

  @override
  Widget build(BuildContext context){
    // _itemSelected = checkStaffNameList.first;
    return WillPopScope(
      onWillPop: ()async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Choose a Name!',
                        style: TextStyle(
                              color: MyAppColorSetting.getAppBarTextColor()
                        ) 
                      ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                hint: Text("Select A Name", style: TextStyle(fontSize: Dimensions.font20),),
                value: emailSelected,
                onChanged: _onDropdownItemSelected,
                items: checkStaffEmailList.map((String item){
                  return DropdownMenuItem<String>(
                    value: item, 
                    child: Text(item, style: TextStyle(fontSize: Dimensions.font20)),
                  );
                }).toList(),
              ),
              SizedBox(height: Dimensions.heihgt15,),
              ElevatedButton(
                onPressed: checkStaffEmailAllRecordButtonClicked,
                child: Text('Check All Record!')),
              SizedBox(height: Dimensions.heihgt15,),
              ElevatedButton(
                onPressed: checkStaffEmailRecordInDateRangeButtonClicked,
                child: Text('Check in range of Date!'))
            ],
          )
        ),
        bottomNavigationBar: loggedInTypeNavigationBar(authController.theMemeberType)
      )
    ); 
  }
}
import 'package:attendance_fyp_app/widgets/colorsSetting.dart';
import 'package:attendance_fyp_app/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:get/get.dart';
import 'package:attendance_fyp_app/utils/dimensions.dart';

final AuthController authController = Get.find<AuthController>();
//For Staff Checking one Date attendance
class staffDatePicker_page extends StatefulWidget{
  final String needCheckStaffIs;

  staffDatePicker_page({required this.needCheckStaffIs});
  @override
  staffDatePicker_pageState createState() => staffDatePicker_pageState();
}

class staffDatePicker_pageState extends State<staffDatePicker_page>{
  DateTime?isSelectedDate;
  late String checkingPersonEmail;

  void keepCheckingEmailIs(){
    String needCheckStaffIs = widget.needCheckStaffIs;
  }

  Future<void> staffSelectCheckDate() async{
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: isSelectedDate?? DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime.now(),
      );
 

    if(pickedDate != null && pickedDate !=isSelectedDate){
      setState(() {
        isSelectedDate = pickedDate;
      });
    }
  }

  void DateButtonCheckClicked(){
    if(isSelectedDate != null){
      // String passFormatDate = DateFormat('yyyyMMdd').format(selectedDate!);
      String passFormatDate = DateFormat('yyyy-MM-dd').format(isSelectedDate!);
      print(passFormatDate);
      authController.getStaffAttendanceinRangeDateFromApi(widget.needCheckStaffIs, passFormatDate, passFormatDate);
    }else{
      Get.snackbar("Date", "Date select",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Null Date",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          'Please select the Date!',
          style: TextStyle(
            color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: ()async => false,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Date Pick'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: staffSelectCheckDate,
                  child: Text(
                    'Please select one day to check attendance!'
                  ),
                ),
                SizedBox(height: Dimensions.heihgt15,),
                Text(
                  isSelectedDate != null ? DateFormat('yyyy-MM-dd').format(isSelectedDate!) : 'Date do not selected!', // if not null, show the Date, null show Date do not selected!
                ),
                SizedBox(height: Dimensions.heihgt15,),
                ElevatedButton(
                  onPressed: DateButtonCheckClicked,
                  child: Text('Check it!'))
              ],
            )
          ),
        bottomNavigationBar: loggedInTypeNavigationBar(authController.theMemeberType)
      )
    ); 
  }

}
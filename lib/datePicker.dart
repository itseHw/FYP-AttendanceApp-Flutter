import 'package:attendance_fyp_app/widgets/colorsSetting.dart';
import 'package:attendance_fyp_app/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:get/get.dart';
import 'package:attendance_fyp_app/utils/dimensions.dart';

final AuthController authController = Get.find<AuthController>();
//For Boss Checking one Date attendance
class DatePickerWidget extends StatefulWidget{
  @override
  DatePickerWidgetState createState() => DatePickerWidgetState();
}

class DatePickerWidgetState extends State<DatePickerWidget>{
  DateTime?selectedDate;

  Future<void> selectCheckDate() async{
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate?? DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime.now(),
      );
 

    if(picked != null && picked !=selectedDate){
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void checkDateButtonClicked(){
    if(selectedDate != null){
      // String passFormatDate = DateFormat('yyyyMMdd').format(selectedDate!);
      String passFormatDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
      print(passFormatDate);
      authController.getStaffAttendanceFromApi(passFormatDate, "checkingDate");
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
                  onPressed: selectCheckDate,
                  child: Text(
                    'Please select the day to check attendance!'
                  ),
                ),
                SizedBox(height: Dimensions.heihgt15,),
                Text(
                  selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate!) : 'Date do not selected!', // if not null, show the Date, null show Date do not selected!
                ),
                SizedBox(height: Dimensions.heihgt15,),
                ElevatedButton(
                  onPressed: checkDateButtonClicked,
                  child: Text('Check it!'))
              ],
            )
          ),
        bottomNavigationBar: loggedInTypeNavigationBar(authController.theMemeberType)
      )
    ); 
  }

}
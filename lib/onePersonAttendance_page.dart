import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:attendance_fyp_app/utils/dimensions.dart';
import 'package:attendance_fyp_app/widgets/colorsSetting.dart';
import 'package:attendance_fyp_app/widgets/make_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:azure_cosmosdb/azure_cosmosdb.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:attendance_fyp_app/widgets/navigation_bar.dart';


// staff check theirself, and boss may check on date or person
class OnePersonAttendancePage extends StatelessWidget {
final AuthController authController = Get.find<AuthController>();
  // List<DatePersonRecord> staffRecord =authController.dataCallBack;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width; //for width
    double h = MediaQuery.of(context).size.height; //for height
    // int totalRecordCount = getAllRecordCount();
    // int lateRecordCount = getLateRecordCount();
    // int earlyLeaveRecordCount = getearlyLeaveRecordCount();
    
    return WillPopScope(
      onWillPop: () async => false,
      child:Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Staff Attendance List'),
        ),
        
        body: Column(
          children: [
            ElevatedButton(
              onPressed: (){
                // int numberOfRecordBack = getAllRecordCount();
                Map<String, int> counts = getAllRecordCount();
                String messageShowing = '';
                counts.forEach((key, value) {
                  messageShowing +='$key: $value\n';
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(messageShowing, style: TextStyle(color: MyAppColorSetting.getMessageTextColor())),
                    backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
                    duration: const Duration(seconds: 6), // keep to show message in 6 seconds
                  )
                );
              }, child: Text('Total Number'), 
            ),
            SizedBox(height: Dimensions.heihgt15,),
            Expanded(
              child: ListView.builder(
                itemCount: authController.dataCallBack.length,
                itemBuilder: (context, index){
                  Color specialTextColor = authController.dataCallBack[index].situation == "Late" || authController.dataCallBack[index].situation ==  "Early leave" ? MyAppColorSetting.getRecordSitSpecialInCardTextColor() : MyAppColorSetting.getRecordSitNormalInCardTextColor();
                  return Card(
                    child:ListTile(
                      title:Column(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Name: " + authController.dataCallBack[index].staffName),
                          Text("Date: " + authController.dataCallBack[index].date),
                          Text("Time: " + authController.dataCallBack[index].time),
                          Text("Email: " + authController.dataCallBack[index].accountEmail),
                          Text("Record: " + authController.dataCallBack[index].attendanceRecord),
                          Text("situation: " + authController.dataCallBack[index].situation, style: TextStyle(color: specialTextColor)),
                          Text("Remarks: " + authController.dataCallBack[index].reMarks),
                        ],
                      ),
                    ),
                  );
                }     
              ),
            )
          ],
        ),
        // body: ListView.builder(
        //   itemCount: authController.dataCallBack.length,
        //   itemBuilder: (context, index){
        //     return Card(
        //       child:ListTile(
        //         title:Column(mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             Text("Name: " + authController.dataCallBack[index].staffName),
        //             Text("Date: " + authController.dataCallBack[index].date),
        //             Text("Time: " + authController.dataCallBack[index].time),
        //             Text("Email: " + authController.dataCallBack[index].accountEmail),
        //             Text("Record: " + authController.dataCallBack[index].attendanceRecord),
        //             Text("situation: " + authController.dataCallBack[index].situation),
        //             Text("Remarks: " + authController.dataCallBack[index].reMarks),
        //           ],
        //         ),
        //       ),
        //     );
        //   }     
        // ),
        bottomNavigationBar: loggedInTypeNavigationBar(authController.theMemeberType),
      ) 
    );   
  }
  
  // int getAllRecordCount() { // for getting total, normal, Late, elarylevae record.
    Map<String, int> getAllRecordCount(){
    int totalCount =0;
    int normalCount = 0;
    int lateCount = 0;
    int earlyLeaveRecordCount = 0;
    // count = authController.dataCallBack.where((data) => data.situation == 'Normal').length;
    totalCount = authController.dataCallBack.length;
    normalCount = authController.dataCallBack.where((data) => data.situation == 'Normal').length;
    lateCount = authController.dataCallBack.where((data) => data.situation == 'Late').length;
    earlyLeaveRecordCount = authController.dataCallBack.where((data) => data.situation == 'Early leave').length;
    return {
      'Total Record' : totalCount,
      'Normal Record' : normalCount,
      'Late Record' : lateCount,
      'EarlyLeave Record' : earlyLeaveRecordCount 
    };
  }
}
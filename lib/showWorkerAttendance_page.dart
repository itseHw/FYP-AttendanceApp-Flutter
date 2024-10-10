import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:attendance_fyp_app/utils/dimensions.dart';
import 'package:attendance_fyp_app/widgets/make_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:azure_cosmosdb/azure_cosmosdb.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:attendance_fyp_app/widgets/navigation_bar.dart';
import 'package:attendance_fyp_app/utils/DatePersonRecord.dart';


//for boss, so may need update record , extends StatefulWiget?
class ShowWorkerAttendancePage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  // List<DatePersonRecord> staffRecord =authController.dataCallBack;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width; //for width
    double h = MediaQuery.of(context).size.height; //for height
    
    return WillPopScope(
      onWillPop: ()async => false,
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Pleace choose check date or staff'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child:Column(
                children: [
                  ElevatedButton(onPressed:(){authController.selectDateForCheckingAttendance();} , child: Text("One Date Checking")), // go to let boss choose date to check
                  SizedBox(height: Dimensions.heihgt15,),
                  ElevatedButton(onPressed:(){authController.goToInputRangeOfDateChecking("All");} , child: Text("Range of Date Checking")), // go to let boss choose date to check
                  SizedBox(height: Dimensions.heihgt15,),
                  // ElevatedButton(onPressed:(){authController.selectNameForCheckingAttendance();} , child: Text("Staff Checking")), // go to let boss choose staff name to check 
                  ElevatedButton(onPressed:(){authController.goToSelectTypeCheckAttendance();} , child: Text("Staff Checking")),
                  SizedBox(height: Dimensions.heihgt15,),
                  ElevatedButton(onPressed:(){authController.selectTypeToChangeTimeLimit();} , child: Text("Change Time Limit")), // go to let boss choose which type of staff need to change time limit
                ],
              )
            ),
        ]
      ),

        bottomNavigationBar: loggedInTypeNavigationBar(authController.theMemeberType),
    )
    );
  }
}
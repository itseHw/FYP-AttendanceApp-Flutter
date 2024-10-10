import 'package:attendance_fyp_app/home/login_page.dart';
import 'package:attendance_fyp_app/utils/checkDateFormat.dart';
import 'package:attendance_fyp_app/utils/checkTimeFormat.dart';
import 'package:attendance_fyp_app/utils/dimensions.dart';
import 'package:attendance_fyp_app/widgets/colorsSetting.dart';
import 'package:attendance_fyp_app/widgets/navigation_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:intl/intl.dart';

//For Boss check visit request record
class visitRequestRecordPage extends StatelessWidget {
final AuthController authController = Get.find<AuthController>();
  // List<DatePersonRecord> staffRecord =authController.dataCallBack;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width; //for width
    double h = MediaQuery.of(context).size.height; //for height
    
    return WillPopScope(
      onWillPop: () async => false,
      child:Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Visit Request'),
        ),
        body: ListView.builder(
          itemCount: authController.callBackVisitRecord.length,
          itemBuilder: (context, index){
            return Card(
              child:ListTile(
                title:Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Visit Date: " + authController.callBackVisitRecord[index].visitDate),
                    Text("Visit Time: " + authController.callBackVisitRecord[index].visitTime),
                    Text("Email: " + authController.callBackVisitRecord[index].bookerEmail),
                    Text("Name: " + authController.callBackVisitRecord[index].bookerName),
                    Text("Contact: " + authController.callBackVisitRecord[index].bookerContactNumber),
                    Text("Company: " + authController.callBackVisitRecord[index].bookerCompany),
                    Text("Date for booking: " + authController.callBackVisitRecord[index].bookingDate),
                    Text("Record: " + authController.callBackVisitRecord[index].requestState),
                  ],
                ),
              ),
            );
          }     
        ),
        bottomNavigationBar: loggedInTypeNavigationBar(authController.theMemeberType),
      ) 
    );   
  }
}
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


//welcomePage no need dynamic updates or internal state management
class selectACManagePage extends StatelessWidget {
  // const WelcomePage({Key? key}) : super(key: key);
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width; //for width
    double h = MediaQuery.of(context).size.height; //for height
    
    return WillPopScope(
      onWillPop: ()async => false,
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: Column(
          children:[
            Container(
              width: w,
              height: h*0.35,
              decoration: BoxDecoration(
                image:DecorationImage(
                  image: AssetImage(
                    "assets/images/bg.png" //may be change to company logo and background image
                    ),
                    fit: BoxFit.cover 
                )
              ),
              // child: Column(
              // ),
            ),
          SizedBox(height: Dimensions.heihgt30,), //To make the space between Container and text
          Container(
            width: w,
            margin: EdgeInsets.only(left: Dimensions.width15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MakeText(text: "Please select!", color: MyAppColorSetting.getContextTitleColor(), size:Dimensions.font20),
              ],
            )
          ),
          SizedBox(height: Dimensions.heihgt60,),
            ElevatedButton(onPressed:(){authController.createNewAccount();} , child: Text("Create New Account")), // go to create a new account page
            SizedBox(height: Dimensions.heihgt15,),
            ElevatedButton(onPressed:(){authController.selectNeedUpdateDetailsAccountType();} , child: Text("Update account detail")), // go to select need update account type page
          ],
        ),
        // bottomNavigationBar: Container(
        //   color:Colors.blue,
        //   child: loggedInTypeNavigationBar(authController.theMemeberType)
        // )
        bottomNavigationBar: loggedInTypeNavigationBar(authController.theMemeberType),
      )
    );
  }
}
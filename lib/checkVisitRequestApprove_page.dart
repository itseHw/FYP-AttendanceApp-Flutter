import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:attendance_fyp_app/utils/dimensions.dart';
import 'package:attendance_fyp_app/widgets/colorsSetting.dart';
import 'package:attendance_fyp_app/widgets/make_text.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:azure_cosmosdb/azure_cosmosdb.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:attendance_fyp_app/widgets/navigation_bar.dart';

class howVisitRequestApprovePage extends StatelessWidget {
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
              child: Column(
                children: [
                  SizedBox(height: h*0.1,),
                  CircleAvatar(
                    radius: Dimensions.radius60,
                    backgroundImage: AssetImage(
                      "assets/images/signup_Icon2.png"
                    ),
                  )
                ],
              ),
            ),
          SizedBox(height: Dimensions.heihgt30,), //To make the space between Container and text
          Container(
            width: w,
            margin: EdgeInsets.only(left: Dimensions.width15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MakeText(text: "This is ${authController.theName} Check visit request approve Page", color: MyAppColorSetting.getContextTitleColor(), size:Dimensions.font40)
              ],
            )
          ),
          SizedBox(height: Dimensions.heihgt60,),
          GestureDetector(
            onTap: (){
              authController.logOut();
            },
            child: Container(
            width: w*0.3,
            height: h*0.07,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius60),
              image:DecorationImage(
                image: AssetImage(
                  "assets/images/bg.png" //if changed below, there should be change too
                  ),
                  fit: BoxFit.cover 
              )
            ),
            child:Center(
              child: 
                Text(
                  "Log out!",
                  style: TextStyle(
                    fontSize: Dimensions.font20,
                    fontWeight: FontWeight.bold,
                    color: MyAppColorSetting.getTextInBGImageColor()
                  ),
                ),
            )
            ),
          ),
          ],
        ),
        bottomNavigationBar: loggedInTypeNavigationBar(authController.theMemeberType),
      )
    );
  }
}
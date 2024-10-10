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
class WelcomePage extends StatelessWidget {
  // const WelcomePage({Key? key}) : super(key: key);
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width; //for width
    double h = MediaQuery.of(context).size.height; //for height
    
    return WillPopScope(
      onWillPop: ()async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyAppColorSetting.getAppBarBackGroundColor(),
          title: Text("HomePage", 
                      style: TextStyle(
                              color: MyAppColorSetting.getAppBarTextColor()
                              )
                      ),
          leading: IconButton(
              icon: Icon(Theme.of(context).brightness == Brightness.light ? Icons.light_mode : Icons.dark_mode),
              onPressed: (){
                print('Dark mode button Clicked!');
                Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark()); // to set for dark mode or light mode
              },
            ),  
        ),
        // backgroundColor: Colors.white,
        body: Column(
          children:[
            Container(
              width: w,
              height: h*0.33,
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
                MakeText(text: "Welcome!", color: MyAppColorSetting.getContextTitleColor(), size:Dimensions.font40),
                // MakeText(text: "${authController.theName}, ${authController.theCompany}", color: MyAppColorSetting.getContextSecondTitleColor(), size:Dimensions.font20),
                MakeText(text: authController.theName, color: MyAppColorSetting.getContextSecondTitleColor(), size:Dimensions.font20),
                // MakeText(text: authController.theEarlyLeaveLimit, color: MyAppColorSetting.getContextSecondTitleColor(), size:Dimensions.font20),
                // MakeText(text: authController.theLateLimit, color: MyAppColorSetting.getContextSecondTitleColor(), size:Dimensions.font20),
              ],
            )
          ),
          SizedBox(height: Dimensions.heihgt30,),
          ElevatedButton(onPressed:(){authController.changePersonalAccountDetails();} , child: Text("Change My Personal Data")), // go to let boss choose date to check
          SizedBox(height: Dimensions.heihgt30,),
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
        // bottomNavigationBar: Container(
        //   color:Colors.blue,
        //   child: loggedInTypeNavigationBar(authController.theMemeberType)
        // )
        bottomNavigationBar: loggedInTypeNavigationBar(authController.theMemeberType),
      )
    );
  }
}
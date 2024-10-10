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

class visitRequestFromPage extends StatelessWidget {
  // const SignUpPage({Key? key}) : super(key: key);
  var visitDateController = TextEditingController();
  var vistiTimeContorller = TextEditingController();

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    DateTime todayIs = DateTime.now();
    String parseTodayIs = DateFormat('yyyy-MM-dd').format(todayIs);
    double w = MediaQuery.of(context).size.width; //for width
    double h = MediaQuery.of(context).size.height; //for height
    
      return WillPopScope(
        onWillPop: ()async => false,
        child: Scaffold(
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child:Column(
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
                // children: [
                //   SizedBox(height: h*0.1,),
                //   CircleAvatar(
                //     radius: Dimensions.radius60,
                //     backgroundImage: AssetImage(
                //       "assets/images/signup_Icon2.png"
                //     ),
                //   )
                // ],
              ),
            ),
          SizedBox(height: Dimensions.heihgt30,), //To make the space between Container and text
              Container(
                width: w,
                margin: EdgeInsets.only(left:Dimensions.width15, right: Dimensions.width15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:Dimensions.heihgt30,), //To make the space between Please to TextField
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: Dimensions.radius10,
                            spreadRadius: Dimensions.radius5,
                            offset: Offset(1, 1),
                            color: MyAppColorSetting.getTextBoxShadowColor()
                          )
                        ]
                      ),
                      child: TextField(
                        controller: visitDateController,
                        decoration: InputDecoration(
                          hintText: "Visit Date example: 2024-03-26",
                          prefixIcon: Icon(Icons.man_2_outlined, color: MyAppColorSetting.getTextBoxIconColor(),),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius30),
                            borderSide: BorderSide(
                              color: MyAppColorSetting.getTextBoxBorderColor(),
                              width: 1.0
                            )
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius30),
                            borderSide: BorderSide(
                              color: MyAppColorSetting.getTextBoxBorderColor(),
                              width: 1.0
                            )
                          ),
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius30)
                          )
                        ),
                      )
                    ),
                    SizedBox(height: Dimensions.heihgt15,), //To make the space between two Container
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: Dimensions.radius10,
                            spreadRadius: Dimensions.radius5,
                            offset: Offset(1, 1),
                            color: MyAppColorSetting.getTextBoxShadowColor()
                          )
                        ]
                      ),
                      child: TextField(
                        controller: vistiTimeContorller,
                        decoration: InputDecoration(
                          hintText: "Visit Time example: 13:00:00",
                          prefixIcon: Icon(Icons.password_rounded, color: MyAppColorSetting.getTextBoxIconColor(),),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius30),
                            borderSide: BorderSide(
                              color: MyAppColorSetting.getTextBoxBorderColor(),
                              width: 1.0
                            )
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius30),
                            borderSide: BorderSide(
                              color: MyAppColorSetting.getTextBoxBorderColor(),
                              width: 1.0
                            )
                          ),
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius30)
                          )
                        ),
                      )
                    ),
                    SizedBox(height: Dimensions.heihgt15,), //To make the space between Container and text      
                  ],
                ),
              ),
              SizedBox(height: Dimensions.heihgt30,), //To make the space between Container and text
              GestureDetector(
                onTap: (){
                  final visitDateInputed = visitDateController.text;
                  final visitTimeInputed = vistiTimeContorller.text;

                  print( visitDateInputed +" " + visitTimeInputed);
                  if(visitDateInputed.isEmpty || visitTimeInputed.isEmpty ){
                    Get.snackbar("Visit application", "Application Message",
                        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
                        snackPosition: SnackPosition.BOTTOM,
                        titleText: Text(
                          "Applicatioin failed",
                          style: TextStyle(
                            color: MyAppColorSetting.getMessageTitleColor()
                          ),
                        ),
                        messageText: Text(
                          "Please input all information!",
                          style: TextStyle(
                              color:  MyAppColorSetting.getMessageTextColor()
                          ),
                        )
                      );
                  }else{
                    if(checkDateFormat(visitDateInputed) && checkTimeFormat(visitTimeInputed)){
                      if(checkLateThanToday(visitDateInputed)){
                        authController.visitorApplictionCallAPIRequest(visitDateInputed, visitTimeInputed, authController.theEmail, authController.theName, authController.theContactNumber, authController.theCompany, parseTodayIs);
                        print("clicked, time: " + visitTimeInputed +" date: " + visitDateInputed);
                      }else{
                        Get.snackbar("Check Date and Time", "Check Message",
                          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
                          snackPosition: SnackPosition.BOTTOM,
                          titleText: Text(
                            "Request failed",
                            style: TextStyle(
                              color: MyAppColorSetting.getMessageTitleColor()
                            ),
                          ),
                          messageText: Text(
                            "Visit Date should be after today",
                            style: TextStyle(
                                color:  MyAppColorSetting.getMessageTextColor()
                            ),
                          )
                        );
                      }
                    }else{
                      Get.snackbar("Check Date and Time", "Check Message",
                        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
                        snackPosition: SnackPosition.BOTTOM,
                        titleText: Text(
                          "Request failed",
                          style: TextStyle(
                            color: MyAppColorSetting.getMessageTitleColor()
                          ),
                        ),
                        messageText: Text(
                          "Date Format should be dd-MM-yyyy\n Time Format should be hh:mm:ss",
                          style: TextStyle(
                              color:  MyAppColorSetting.getMessageTextColor()
                          ),
                        )
                      );
                    }
                  }
                  // }
                },
                child: Container(
                width: w*0.3,
                height: h*0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  image:DecorationImage(
                    image: AssetImage(
                      "assets/images/bg.png" //if changed upside, there should be change too
                      ),
                      fit: BoxFit.cover 
                  )
                ),
                child:Center(
                  child: 
                  Text(
                      "Application",
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
      ),
        bottomNavigationBar: loggedInTypeNavigationBar(authController.theMemeberType),
      )
    );
  }
}
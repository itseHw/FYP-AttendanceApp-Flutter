import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:attendance_fyp_app/utils/checkTimeFormat.dart';
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

  final AuthController authController = Get.find<AuthController>();
// staff check theirself, and boss may check on date or person
class ChangeTimeLimit_page extends StatelessWidget {
  var changeTypeTimeLimitController = TextEditingController(text: authController.theNeedChangeTimeLimitTypeIS);
  var changeLateLimitController = TextEditingController(text: authController.theLateLimit);
  var changeEarlyLeaveLimitController = TextEditingController(text: authController.theEarlyLeaveLimit);


  @override
  Widget build(BuildContext context) {
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
                        controller: changeTypeTimeLimitController,
                        enabled: false,
                        decoration: InputDecoration(
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
                        controller: changeLateLimitController,
                        decoration: InputDecoration(
                          hintText: "HH:mm:ss",
                          // prefixIcon: Icon(Icons.password_rounded, color: Colors.purple,),
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
                    //end of text field
                    //make text field
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
                        controller: changeEarlyLeaveLimitController,
                        decoration: InputDecoration(
                          hintText: "HH:mm:ss",
                          // prefixIcon: Icon(Icons.age, color: Colors.purple,),
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
                    //end of text field
                    //make text field
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
                    ),
                    SizedBox(height: Dimensions.heihgt15,), //To make the space between Container and text
                    //end of text field            
                  ],
                ),
              ),
              SizedBox(height: Dimensions.heihgt30,), //To make the space between Container and text
              
              GestureDetector(
                onTap: (){
                  final needChangeMemberType = changeTypeTimeLimitController.text;
                  final updatedLateLimit = changeLateLimitController.text;
                  final updatedEarlyLeaveLimit = changeEarlyLeaveLimitController.text;
                  print(needChangeMemberType + " " + updatedLateLimit +" " + updatedEarlyLeaveLimit);
                  if(needChangeMemberType.isEmpty || updatedLateLimit.isEmpty || updatedEarlyLeaveLimit.isEmpty){
                    Get.snackbar("Change Time Limit", "Change Message",
                        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
                        snackPosition: SnackPosition.BOTTOM,
                        titleText: Text(
                          "Change failed",
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
                    if(checkTimeFormat(updatedLateLimit) && checkTimeFormat(updatedEarlyLeaveLimit)){
                      authController.bossChangeTimeLimit(needChangeMemberType, updatedLateLimit, updatedEarlyLeaveLimit);
                    }else{
                      Get.snackbar("Change Time Limit", "Change Message",
                        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
                        snackPosition: SnackPosition.BOTTOM,
                        titleText: Text(
                          "Change Time limit failed",
                          style: TextStyle(
                            color: MyAppColorSetting.getMessageTitleColor()
                          ),
                        ),
                        messageText: Text(
                          "The time format should be HH:mm:ss! e.g. 18:30:00",
                          style: TextStyle(
                              color:  MyAppColorSetting.getMessageTextColor()
                          ),
                        )
                      );
                    }
                  }
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
                        "Update!",
                        style: TextStyle(
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                          color: MyAppColorSetting.getTextInBGImageColor()
                        ),
                    ),
                  )
              ),
              ),
              SizedBox(height: h*0.08),
            ],
        ),
        ),
        bottomNavigationBar: loggedInTypeNavigationBar(authController.theMemeberType),
      )
    );
  }
}

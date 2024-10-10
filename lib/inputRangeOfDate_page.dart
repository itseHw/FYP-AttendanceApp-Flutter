import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:attendance_fyp_app/utils/checkDateFormat.dart';
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
class inputRangeOfDateChecking extends StatelessWidget {
  final String needCheckStaffEmailIs;

  final TextEditingController wantCheckPersonController;

  inputRangeOfDateChecking({required this.needCheckStaffEmailIs}) : wantCheckPersonController = TextEditingController(text: needCheckStaffEmailIs);
  var needStartDateController = TextEditingController();
  var needEndDateController = TextEditingController();


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
                        controller: wantCheckPersonController,
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
                        controller: needStartDateController,
                        decoration: InputDecoration(
                          hintText: "Start Date: e.g. 2024-03-01",
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
                        controller: needEndDateController,
                        decoration: InputDecoration(
                          hintText: "End Date: e.g. 2024-03-01",
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
                  final needCheckStaffEmailHere = wantCheckPersonController.text;
                  final needCheckStartDateHere = needStartDateController.text;
                  final needCheckEndDateHere = needEndDateController.text;
                  print(needCheckStaffEmailHere + " " + needCheckStartDateHere +" " + needCheckEndDateHere);
                  if(needCheckStaffEmailHere.isEmpty || needCheckStartDateHere.isEmpty || needCheckEndDateHere.isEmpty){
                    Get.snackbar("Check Range Date Limit", "Check Message",
                        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
                        snackPosition: SnackPosition.BOTTOM,
                        titleText: Text(
                          "Check failed",
                          style: TextStyle(
                            color: MyAppColorSetting.getMessageTitleColor()
                          ),
                        ),
                        messageText: Text(
                          "Please input start date and end Date!",
                          style: TextStyle(
                              color:  MyAppColorSetting.getMessageTextColor()
                          ),
                        )
                      );
                  }else{
                    if(checkDateFormat(needCheckStartDateHere) && checkDateFormat(needCheckEndDateHere)){
                      if(checkEndDateIsLateThanStartDate(needCheckStartDateHere, needCheckEndDateHere)){
                        authController.getStaffAttendanceinRangeDateFromApi(needCheckStaffEmailHere, needCheckStartDateHere, needCheckEndDateHere);
                      }else{
                        Get.snackbar("Check Date", "Check Message",
                          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
                          snackPosition: SnackPosition.BOTTOM,
                          titleText: Text(
                            "Check Attendanc failed",
                            style: TextStyle(
                              color: MyAppColorSetting.getMessageTitleColor()
                            ),
                          ),
                          messageText: Text(
                            "The Starting Date should be early than End Date",
                            style: TextStyle(
                                color:  MyAppColorSetting.getMessageTextColor()
                            ),
                          )
                        );
                      }
                    }else{
                      Get.snackbar("Check Date", "Check Message",
                        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
                        snackPosition: SnackPosition.BOTTOM,
                        titleText: Text(
                          "Check Attendanc failed",
                          style: TextStyle(
                            color: MyAppColorSetting.getMessageTitleColor()
                          ),
                        ),
                        messageText: Text(
                          "The Date format should be yyyy-MM-dd! e.g. 2024-03-01",
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
                        "Check!",
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

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

  final AuthController authController = Get.find<AuthController>();
// staff check theirself, and boss may check on date or person
class updateAccountDetailsForITPage extends StatelessWidget {
  // final AuthController authController = Get.find<AuthController>();
 // const SignUpPage({Key? key}) : super(key: key);
  var updateUserEmailController = TextEditingController(text: authController.acDataBack.personalEmail);
  var updateUserPasswordController = TextEditingController(text: authController.acDataBack.personalPassword);
  var updateUserConformPassWordController = TextEditingController(text: authController.acDataBack.personalPassword);
  var updateUserNameController = TextEditingController(text: authController.acDataBack.personalName);
  var updateUserAgeController = TextEditingController(text: authController.acDataBack.personalAge);
  var updateUserContactNumberController = TextEditingController(text: authController.acDataBack.personalContactNumber);
  var updateUserMemberTypeController = TextEditingController(text: authController.acDataBack.personalMemberType);
  var updateUserWorkCompanyController = TextEditingController(text: authController.acDataBack.personalCompany);
  var updateUserStateController = TextEditingController(text: authController.acDataBack.personalState);

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
                        controller: updateUserEmailController,
                        enabled: false,
                        decoration: InputDecoration(
                          // hintText: "New account email",
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
                        controller: updateUserPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "User Password",
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
                        controller: updateUserConformPassWordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
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
                        controller: updateUserNameController,
                        decoration: InputDecoration(
                          hintText: "New Staff Name",
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
                        controller: updateUserAgeController,
                        decoration: InputDecoration(
                          hintText: "New User Age",
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
                      child: TextField(
                        controller: updateUserContactNumberController,
                        decoration: InputDecoration(
                          hintText: "Contact Number without space",
                          prefixIcon: Icon(Icons.phone, color: MyAppColorSetting.getTextBoxIconColor(),),
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
                        controller: updateUserMemberTypeController,
                        decoration: InputDecoration(
                          hintText: "New User Member Type",
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
                        controller: updateUserWorkCompanyController,
                        decoration: InputDecoration(
                          hintText: "Company Name",
                          // prefixIcon: Icon(Icons.Company, color: Colors.purple,),
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
                        controller: updateUserStateController,
                        decoration: InputDecoration(
                          hintText: "available or unavailable",
                          // prefixIcon: Icon(Icons.Company, color: Colors.purple,),
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
                  ],
                ),
              ),
              SizedBox(height: Dimensions.heihgt30,), //To make the space between Container and text
              
              GestureDetector(
                onTap: (){
                  final updatedUserEmail = updateUserEmailController.text;
                  final updatedUserPassword = updateUserPasswordController.text;
                  final updatedConformPassword = updateUserConformPassWordController.text;
                  final updatedUserName = updateUserNameController.text;
                  final updatedUserAge = updateUserAgeController.text;
                  final updatedUserContactNumber = updateUserContactNumberController.text;
                  final updatedUserMemberType = updateUserMemberTypeController.text;
                  final updatedUserWorkCompany = updateUserWorkCompanyController.text;
                  final updatedUserState = updateUserStateController.text;
                  print(updatedUserEmail + " " + updatedUserPassword +" " + updatedConformPassword + " " + updatedUserName + " " + updatedUserAge + " " + updatedUserContactNumber + " " + updatedUserMemberType +  " " + updatedUserWorkCompany + " " + updatedUserState);
                  if(updatedUserEmail.isEmpty || updatedUserPassword.isEmpty || updatedConformPassword.isEmpty || updatedUserName.isEmpty || updatedUserAge.isEmpty || updatedUserContactNumber.isEmpty || updatedUserMemberType.isEmpty || updatedUserWorkCompany.isEmpty || updatedUserState.isEmpty){
                    Get.snackbar("Update Account details", "Update Message",
                        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
                        snackPosition: SnackPosition.BOTTOM,
                        titleText: Text(
                          "Update failed",
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
                    if(updatedUserPassword == updatedConformPassword){
                      if(updatedUserMemberType == "Office worker"|| updatedUserMemberType == "IT support" || updatedUserMemberType == "Boss" || updatedUserMemberType == "Visitors"){
                        if(updatedUserState == "available" || updatedUserState == "unavailable"){
                          authController.callAPIToUpdateAccountDetails(updatedUserEmail, updatedUserPassword, updatedUserName, updatedUserAge, updatedUserContactNumber, updatedUserMemberType, updatedUserWorkCompany, updatedUserState, "isFromITStaffChangePage");
                        }else{
                          Get.snackbar("Update account details", "Update Message",
                            backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
                            snackPosition: SnackPosition.BOTTOM,
                            titleText: Text(
                              "Update account details failed",
                              style: TextStyle(
                                color: MyAppColorSetting.getMessageTitleColor()
                              ),
                            ),
                            messageText: Text(
                              "State should be available or unavailable",
                              style: TextStyle(
                                  color:  MyAppColorSetting.getMessageTextColor()
                              ),
                            )
                          );
                        } 
                      }else{
                        Get.snackbar("Update account details", "Update Message",
                          backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
                          snackPosition: SnackPosition.BOTTOM,
                          titleText: Text(
                            "Update account details failed",
                            style: TextStyle(
                              color: MyAppColorSetting.getMessageTitleColor()
                            ),
                          ),
                          messageText: Text(
                            "MemberType should be Office worker or IT support or Boss or Visitors",
                            style: TextStyle(
                                color:  MyAppColorSetting.getMessageTextColor()
                            ),
                          )
                        );
                      } 
                    }else{
                      Get.snackbar("Update account details", "Update Message",
                        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
                        snackPosition: SnackPosition.BOTTOM,
                        titleText: Text(
                          "Update account details failed",
                          style: TextStyle(
                            color: MyAppColorSetting.getMessageTitleColor()
                          ),
                        ),
                        messageText: Text(
                          "The two Inputed Password is not same!",
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
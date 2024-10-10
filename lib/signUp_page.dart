import 'package:attendance_fyp_app/home/login_page.dart';
import 'package:attendance_fyp_app/utils/dimensions.dart';
import 'package:attendance_fyp_app/widgets/colorsSetting.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance_fyp_app/utils/auth_controller.dart';

//image downloaf from https://icon-library.com/icon/sign-up-icon-png-21.html

class SignUpPage extends StatelessWidget {
  // const SignUpPage({Key? key}) : super(key: key);
  var signEmailController = TextEditingController();
  var signPasswordController = TextEditingController();
  var conformPassWordController = TextEditingController();
  var userNameController = TextEditingController();
  var userAgeController = TextEditingController();
  var userContactNumberController = TextEditingController();
  var userWorkCompanyController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

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
                        controller: signEmailController,
                        decoration: InputDecoration(
                          hintText: "Your account email",
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
                        controller: signPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Your Password",
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
                        controller: conformPassWordController,
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
                        controller: userNameController,
                        decoration: InputDecoration(
                          hintText: "Your Name",
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
                        controller: userAgeController,
                        decoration: InputDecoration(
                          hintText: "Your Age",
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
                        controller: userContactNumberController,
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
                        controller: userWorkCompanyController,
                        decoration: InputDecoration(
                          hintText: "Your Company",
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
                  final vsUserEmail = signEmailController.text;
                  final vsUserPassword = signPasswordController.text;
                  final vsConformPassword = conformPassWordController.text;
                  final vsUserName = userNameController.text;
                  final vsUserAge = userAgeController.text;
                  final vsUserContactNumber = userContactNumberController.text;
                  final vsUserWorkCompany = userWorkCompanyController.text;
                  print(vsUserEmail +" " + vsUserPassword +" " + vsConformPassword +" " + vsUserName +" " + vsUserAge +" " + vsUserContactNumber +" " + vsUserWorkCompany);
                  if(vsUserEmail.isEmpty || vsUserPassword.isEmpty || vsConformPassword.isEmpty || vsUserName.isEmpty || vsUserAge.isEmpty || vsUserContactNumber.isEmpty || vsUserWorkCompany.isEmpty){
                    Get.snackbar("Sign Up", "Sign UP Message",
                        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
                        snackPosition: SnackPosition.BOTTOM,
                        titleText: Text(
                          "Sign Up failed",
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
                    if(vsUserPassword == vsConformPassword){
                      authController.visitorSignUp(vsUserEmail, vsUserPassword, vsUserName, vsUserAge, vsUserContactNumber,vsUserWorkCompany);
                    }else{
                      Get.snackbar("Sign Up", "Sign Up Message",
                        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
                        snackPosition: SnackPosition.BOTTOM,
                        titleText: Text(
                          "Sign Up failed",
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
                      "Sign up",
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
              RichText(text: TextSpan(
                text:"Already have account?",
                style: TextStyle(
                  color: MyAppColorSetting.getRichTextSignINUPColor(),
                  fontSize: Dimensions.font20  
                ),
                children:[
                  TextSpan(
                    text:" Sign in Now!",
                    style: TextStyle(
                      color: MyAppColorSetting.getRichTextClickColor(),
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.bold
                    ),
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>LoginPage())
                  )
                ] 
              ),
          )
            ],
        ),
        )
      )
    );
  }
}
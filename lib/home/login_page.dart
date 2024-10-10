import 'package:attendance_fyp_app/signUp_page.dart';
import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:attendance_fyp_app/utils/dimensions.dart';
import 'package:attendance_fyp_app/widgets/colorsSetting.dart';
import 'package:attendance_fyp_app/widgets/make_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:azure_cosmosdb/azure_cosmosdb.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:attendance_fyp_app/utils/auth_controller.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}): super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Color myColor;
  late Size mediaSize;
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool remeberUser = false;
  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    //print("current height is " + MediaQuery.of(context).size.height.toString()); //for finding height
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    double w = MediaQuery.of(context).size.width; //for width
    double h = MediaQuery.of(context).size.height; //for height
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
    //return Scaffold(
      // backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child:Column(
      // body: Column(
          children:[
            Container(
              width: w,
              height: h*0.3,
              decoration: BoxDecoration(
                image:DecorationImage(
                  image: AssetImage(
                    "assets/images/bg.png" //may be change to company logo and background image
                    ),
                    fit: BoxFit.cover 
                )
              ),
            ),
          Container(
            width: w,
            margin: EdgeInsets.only(left:Dimensions.width15, right: Dimensions.width15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome!",
                  style: TextStyle(
                    fontSize: Dimensions.font40,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Please login your own account!",
                  style: TextStyle(
                    fontSize: Dimensions.font20,
                    color:MyAppColorSetting.getAlterTextColor()
                  ),
                ),
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
                    controller: emailController,
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
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Your Password",
                      prefixIcon: Icon(Icons.password_rounded, color: MyAppColorSetting.getTextBoxIconColor(),),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        borderSide: BorderSide(
                          color: MyAppColorSetting.getTextBoxShadowColor(),
                          width: 1.0
                        )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        borderSide: BorderSide(
                          color: MyAppColorSetting.getTextBoxShadowColor(),
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
                // Row(
                //   children: [
                //     Expanded(child: Container(),),
                //     Text(
                //       "Forget Password?",
                //       style: TextStyle(
                //         fontSize: Dimensions.font20,
                //         color:Colors.grey
                //       ),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.heihgt30,), //To make the space between Container and text
          GestureDetector(
            onTap: (){
              final needCheckEmail = emailController.text;
              final needCheckPassword = passwordController.text;
              print(needCheckEmail +" " + needCheckPassword);
              if(needCheckEmail.isEmpty|| needCheckPassword.isEmpty){
                Get.snackbar("Login", "Login Message",
                  backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
                  snackPosition: SnackPosition.BOTTOM,
                  titleText: Text(
                    "Login failed",
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
                authController.loginUser(needCheckEmail, needCheckPassword);
              }

            },
            child: Container(
            width: w*0.3,
            height: h*0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
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
                  "Sign in",
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
            text:"Don\'t have account?",
            style: TextStyle(
              color: MyAppColorSetting.getRichTextSignINUPColor(),
              fontSize: Dimensions.font20  
            ),
            children:[
              TextSpan(
                text:" Create",
                style: TextStyle(
                  color: MyAppColorSetting.getRichTextClickColor(),
                  fontSize: Dimensions.font20,
                  fontWeight: FontWeight.bold
                ),
                recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage())
              )
            ] 
          )
          )
          ],
        ),
      )
    // );
      )
    );
  }
}
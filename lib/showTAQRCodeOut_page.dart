import 'dart:async';
// import 'dart:html';
import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:attendance_fyp_app/utils/dimensions.dart';
import 'package:attendance_fyp_app/widgets/make_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:azure_cosmosdb/azure_cosmosdb.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:attendance_fyp_app/widgets/navigation_bar.dart';
import 'package:intl/intl.dart';
import 'package:attendance_fyp_app/utils/qrCodeState.dart';

final AuthController authController = Get.find<AuthController>();

class ShowTAQRCodeOutPage extends StatefulWidget {
  @override
  showTaQRCodeOutPageState createState() => showTaQRCodeOutPageState();
}

class showTaQRCodeOutPageState extends State<ShowTAQRCodeOutPage>{
  QrCodeGenerator qrCodeGenerator = QrCodeGenerator();

  @override
  void initState(){
    super.initState();
    qrCodeGenerator.startTimer(updateQrCode);
  }

  @override
  void dispose(){  // used for ?
    qrCodeGenerator.dispose();
    super.dispose();
  }

  void updateQrCode(){
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width; //for width
    double h = MediaQuery.of(context).size.height; //for height
    
    return WillPopScope(
      onWillPop: ()async => false,
      child: Scaffold(
        appBar: AppBar(title: Text("Take attenadance code")
        ),
      // backgroundColor: Colors.white,
      body: Column(
        children:[
          // Container(
          //   width: w,
          //   margin: EdgeInsets.only(left: Dimensions.width15),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       MakeText(text: "This is ${authController.theName} Show TA QR COde Page", color: Colors.green, size:Dimensions.font40)
          //     ],
          //   )
          // ),
          SizedBox(height: Dimensions.heihgt30,), //To make the space between Container and text
          Expanded(
              child:  QrImageView(
              data: qrCodeGenerator.generateQRCodedata("StaffOut"),
              version: QrVersions.auto,
              size: Dimensions.imageSize200,
              ),
            ),
        ],
      ),
      bottomNavigationBar: loggedInTypeNavigationBar(authController.theMemeberType),
    ),
      );
      // )
  }
}
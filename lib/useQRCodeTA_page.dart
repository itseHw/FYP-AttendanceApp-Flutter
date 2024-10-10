import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:attendance_fyp_app/utils/dimensions.dart';
import 'package:attendance_fyp_app/widgets/colorsSetting.dart';
import 'package:attendance_fyp_app/widgets/make_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:azure_cosmosdb/azure_cosmosdb.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:attendance_fyp_app/widgets/navigation_bar.dart';
import 'package:attendance_fyp_app/utils/qrCodeScanner.dart';

class UseQRCodeTAPage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  String qrReturnData = "";

  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: ()async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyAppColorSetting.getAppBarBackGroundColor(),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              //Navigator.push?
              authController.backtoWelcomPage(); // let user go to welcome page
            },
          ),
          title: Text('QRCODE SCANNER!', 
                      style: TextStyle(
                                color: MyAppColorSetting.getAppBarTextColor()
                              )),
        ),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height:MediaQuery.of(context).size.height * 0.7,
              child: QRCodeScanner(),
            )
          ],
        ),
      ) 
    );
  }
}

  

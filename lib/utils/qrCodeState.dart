import 'dart:async';
import 'package:attendance_fyp_app/home/login_page.dart';
import 'package:attendance_fyp_app/onePersonAttendance_Page.dart';
import 'package:attendance_fyp_app/useQRCodeTA_page.dart';
import 'package:attendance_fyp_app/welcome_page.dart';
import 'package:attendance_fyp_app/createNewAccount_page.dart';
import 'package:attendance_fyp_app/showWorkerAttendance_page.dart';
import 'package:attendance_fyp_app/showVisitorRequest_page.dart';
import 'package:attendance_fyp_app/showVisitApprove_page.dart';
import 'package:attendance_fyp_app/checkVisitRequestApprove_page.dart';
import 'package:attendance_fyp_app/showTAQRCode_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import 'package:attendance_fyp_app/utils/dimensions.dart';
import 'package:flutter/widgets.dart';

class QrCodeGenerator{
  Timer? timer;
  int limitSeconds = 7; //(I want 7 seconds to change qr code one time)
  String qrCodeData = "";
  String needAction="";

  String generateQRCodedata(String needAction){ // for return the qr code data
    this.needAction = needAction;
    DateTime currentTime = DateTime.now();
    // String formatDate = DateFormat('yyyy-MM-dd').format(currentTime);
    // String formatTime = DateFormat('HH:mm:ss').format(currentTime);
    if(needAction == "StaffIn"){
      // return "Action: StaffIn\nDate: $formatDate\nTime: $formatTime";
      return "Action: StaffIn\nDatetime: $currentTime\nBelongs: ''";
    }else if(needAction == "StaffOut"){
      // return "Action: StaffOut\nDate: $formatDate\nTime: $formatTime";
      return "Action: StaffOut\nDatetime: $currentTime\nBelongs: ''";
    }else if(needAction == "VisitorCheck"){
      // return "Action: VisitorCheck\nDate: $formatDate\nTime: $formatTime\nBelongs: ''"; //Belongs is use theEmail, let scanner check who
      return "";
    }else{
      return "";
    }
  }

  // Widget generateQRCode(String needAction){
  //   String qrCodeData = generateQRCodedata(needAction);
  //     return QrImageView(
  //         data: qrCodeData,
  //         version: QrVersions.auto,
  //         size: Dimensions.imageSize200,
  //     );
  // }

  void startTimer(Function() qrCodeUpdateToCall){
    timer = Timer.periodic(Duration(seconds: 1),(timer){
      if(limitSeconds == 1){
        qrCodeData = generateQRCodedata(needAction);
        qrCodeUpdateToCall();
        limitSeconds= 7; // reset to 7 seconds
      }else{
        limitSeconds --; // duration is 1 so minius 
      }
    });
  }

  void dispose(){
    timer?.cancel();
  }

}

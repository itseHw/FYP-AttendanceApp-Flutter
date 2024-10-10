import 'dart:async';
import 'dart:io';
import 'package:attendance_fyp_app/home/login_page.dart';
import 'package:attendance_fyp_app/onePersonAttendance_Page.dart';
import 'package:attendance_fyp_app/useQRCodeTA_page.dart';
import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:attendance_fyp_app/welcome_page.dart';
import 'package:attendance_fyp_app/createNewAccount_page.dart';
import 'package:attendance_fyp_app/showWorkerAttendance_page.dart';
import 'package:attendance_fyp_app/showVisitorRequest_page.dart';
import 'package:attendance_fyp_app/showVisitApprove_page.dart';
import 'package:attendance_fyp_app/checkVisitRequestApprove_page.dart';
import 'package:attendance_fyp_app/showTAQRCode_page.dart';
import 'package:attendance_fyp_app/widgets/colorsSetting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import 'package:attendance_fyp_app/utils/dimensions.dart';
import 'package:flutter/widgets.dart';


class QRCodeScanner extends StatefulWidget{

  @override
  // _QRCState createState() => _QRCState();
  State<StatefulWidget> createState(){
    return _QRCState();
  }
}

class _QRCState extends State<QRCodeScanner>{
  String scanedQrCodeData = "";
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");
  // Barcode? result;
  QRViewController? controller;
  bool scannNow = true;
  bool runApiCalled = false;
  final AuthController authController = Get.find<AuthController>();
  // String lateTime = "09:35:00";
  // String earlyLeaveTime = "17:00:00";
  // final DateFormat formatIs = DateFormat('HH:mm:ss');
  

  @override
  void reassemble(){
    super.reassemble();
    if(Platform.isAndroid){
      controller!.pauseCamera();
    }else if (Platform.isIOS){
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context){
    // DateTime testnowtime = DateTime.now();
    return Column(
      children: [
        Expanded(
          flex : 5,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: scannNow ? Text("Scan Progressing...") :
                    ElevatedButton(onPressed: (){
                      setState(() {
                        scannNow = true;
                      });
                      controller!.resumeCamera();
                      scanedQrCodeData ="";
                      runApiCalled = false;
                    },
                    child: Text("Please Scan again!")
                  ), 
          )
        ),
        Expanded(
          child: Text(scanedQrCodeData, style: TextStyle(fontSize: Dimensions.heihgt15),)
        ),
        // Expanded(
        //   child: Text("Phone time: $testnowtime", style: TextStyle(fontSize: Dimensions.heihgt15),)
        // ),
      ],
    );
  }

  Widget buildQRView(BuildContext context){
    var scaningArea = (MediaQuery.of(context).size.width < 390 ||
        MediaQuery.of(context).size.height < 390) ?250.0 : 300.0; //250, 300 need to adject
        return QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: Colors.white,
            borderRadius: Dimensions.radius10,
            borderLength: Dimensions.heihgt30,
            borderWidth: Dimensions.heihgt15,
            cutOutSize: scaningArea),
        );
  }

  void _onQRViewCreated(QRViewController controller){
    this.controller = controller;
    
    // bool notShowAlt = false;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scannNow = false;
        scanedQrCodeData = scanData.code!;
      });

      // String? scanedQrCodeData = scanData.code;
      String recordSituation = "";
      // final parse_lateTime = formatIs.parse(authController.theLateLimit);
      List<String> lateTimeComp = authController.theLateLimit.split(":");
      int lateHour = int.parse(lateTimeComp[0]);
      int lateMin = int.parse(lateTimeComp[1]);
      int latesecond = int.parse(lateTimeComp[2]);
      TimeOfDay parse_lateTime = TimeOfDay(hour: lateHour, minute: lateMin);

      List<String> earlyLeaveTimeComp = authController.theEarlyLeaveLimit.split(":");
      int earlyHour = int.parse(earlyLeaveTimeComp[0]);
      int earlyMin = int.parse(earlyLeaveTimeComp[1]);
      int earlySecond = int.parse(earlyLeaveTimeComp[2]);
      TimeOfDay parse_earlyLeaveTime = TimeOfDay(hour: earlyHour, minute: earlyMin);

      // final parse_earlyLeaveTime = formatIs.parse(authController.theEarlyLeaveLimit); 
      DateTime scanedTime = DateTime.now();
      List<String> scanedQrDataList= scanedQrCodeData.split("\n");
      // String qrDataContainDate = scanedQrCodeData[1].split(": ")[1];
      // String qrDataContainTime = scanedQrDataList[2].split(": ")[1];
      String qrDataContainAction = scanedQrDataList[0].split(": ")[1];
      String qrDataContainDateTime = scanedQrDataList[1].split(": ")[1];
      // String qrDataContainDate = scanedQrCodeData!.split("\n")[2].split(": ")[1];
      // String qrDataContainTime = scanedQrCodeData.split("\n")[3].split(": ")[1];
      // DateTime qrDataContainDateAndTime = DateTime.parse("$qrDataContainDate $qrDataContainTime"); //Change to DateTime to compare that is or not is within 7 seconds
      
      DateTime parse_qrDataContainDateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(qrDataContainDateTime);
      String qrDataContainDate = DateFormat('yyyy-MM-dd').format(parse_qrDataContainDateTime);
      String qrDataContainTime = DateFormat('HH:mm:ss').format(parse_qrDataContainDateTime);
      
      List<String> qrContainTimeComp = qrDataContainTime.split(":");
      int qrHour = int.parse(qrContainTimeComp[0]);
      int qrMin = int.parse(qrContainTimeComp[1]);
      int qrSecond = int.parse(qrContainTimeComp[2]);
      TimeOfDay parse_qrTime = TimeOfDay(hour: qrHour, minute: qrMin);
      
       Future.delayed(Duration(seconds: 1),(){
          if(runApiCalled == false){ //to prevent loop for sending api or show message  
        if(scanedTime.difference(parse_qrDataContainDateTime).inSeconds <=8){
          if(qrDataContainAction == "StaffIn"){ //for staff take attendance in company
            // authController.getStaffAttendanceFromApi(authController.theName, "checkStaffName");
            if(parse_qrTime.hour > parse_lateTime.hour || parse_qrTime.hour == parse_lateTime.hour && parse_qrTime.minute > parse_lateTime.minute ){
              recordSituation = "Late";
            }else{
              recordSituation = "Normal";
            }
            authController.staffUseQrCodeCallAPIToTakeAttendance(qrDataContainDate, qrDataContainTime, authController.theName, authController.theEmail, "In", recordSituation, "No Remarks");
          }else if(qrDataContainAction == "StaffOut"){ //for staff take attendance to leave company
            if(parse_qrTime.hour < parse_earlyLeaveTime.hour || parse_qrTime.hour == parse_earlyLeaveTime.hour && parse_qrTime.minute < parse_earlyLeaveTime.minute ){
              recordSituation = "Early leave";
            }else{
              recordSituation = "Normal";
            }
            authController.staffUseQrCodeCallAPIToTakeAttendance(qrDataContainDate, qrDataContainTime, authController.theName, authController.theEmail, "Out", recordSituation, "No Remarks");
          }else if(qrDataContainAction == "VisitorIn"){ //for staff take attendance to leave company  
            // authController.staffUseQrCodeCallAPIToTakeAttendance(qrDataContainDate, qrDataContainTime, authController.theName, "Visitor In");
        }else{
          Get.snackbar("QR Sacnner", "Scan QR Code",
            backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
                      "Not Find",
                      style: TextStyle(
                        color: MyAppColorSetting.getMessageTitleColor()
                      ),
                    ),
                    messageText: Text(
                      'Please try again!',
                      style: TextStyle(
                        color:  MyAppColorSetting.getMessageTextColor()
                      ),
                    )
            );
          }
          // runApiCalled = true;
        }else{
          Get.snackbar("QR Sacnner", "Scan QR Code",
            backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
                      "ScanFiled",
                      style: TextStyle(
                        color: MyAppColorSetting.getMessageTitleColor()
                      ),
                    ),
                    messageText: Text(
                      'Please try again!',
                      style: TextStyle(
                        color:  MyAppColorSetting.getMessageTextColor()
                      ),
                    )
          ); 
        }
        runApiCalled = true;
      }
        });

      
    });
}


  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

}
import 'package:attendance_fyp_app/widgets/colorsSetting.dart';
import 'package:flutter/material.dart';
import 'package:attendance_fyp_app/utils/dimensions.dart';
import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:get/get.dart';

final AuthController authController = Get.find<AuthController>();
class OWNavigationBar extends StatelessWidget{ //for Office Worker
  @override
  Widget build(BuildContext context){
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: MyAppColorSetting.getNavigationBarBGColor()
      ),
      child: BottomNavigationBar(
        // backgroundColor: Colors.red,
        selectedItemColor: MyAppColorSetting.getNavigationBarTextIconColor(),
        unselectedItemColor: MyAppColorSetting.getNavigationBarTextIconColor(),
        selectedFontSize: Dimensions.font15,
        unselectedFontSize: Dimensions.font15,
        showUnselectedLabels: true,
        onTap: (index){
          switch (index){
            case 0:
            authController.backtoWelcomPage();
            break;
            case 1:
            // authController.getStaffAttendanceFromApi(authController.theEmail, "checkStaff"); // staff only check itself
            authController.goToStaffSelectRangeForCheckingAttendacnepage(); //select all record, one date or range of date to check
            //authController.seeAttendance();
            break;
            case 2:
            authController.qrCodeTakeAttendance();
            break;
            // case 3:
            // 
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,size: Dimensions.iconSize30), label: "Welcome Page"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month,size: Dimensions.iconSize30), label: "Attendance"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_rear,size: Dimensions.iconSize30),label: "Scan Code"),
          // BottomNavigationBarItem(icon: Icon(Icons.door_front_door_rounded,size: Dimensions.iconSize30),label: "Visit Record"),
        ],
      )
    );
  }
}

class ITSupportNavigationBar extends StatelessWidget{ //for Office Worker
  @override
  Widget build(BuildContext context){
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: MyAppColorSetting.getNavigationBarBGColor()
      ),
      child: BottomNavigationBar(
        selectedItemColor: MyAppColorSetting.getNavigationBarTextIconColor(),
        unselectedItemColor: MyAppColorSetting.getNavigationBarTextIconColor(),
        selectedFontSize: Dimensions.font15,
        unselectedFontSize: Dimensions.font15,
        showUnselectedLabels: true,
        onTap: (index){
          switch (index){
            case 0:
            authController.backtoWelcomPage();
            break;
            case 1:
            authController.goToStaffSelectRangeForCheckingAttendacnepage();  //select all record, one date or range of date to check
            break;
            case 2:
            authController.qrCodeTakeAttendance();
            break;
            case 3:
            authController.iTSupportSelectAccountManage();
            break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,size: Dimensions.iconSize30), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month,size: Dimensions.iconSize30), label: "Attendance"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_rear,size: Dimensions.iconSize30),label: "Scan Code"),
          BottomNavigationBarItem(icon: Icon(Icons.people,size: Dimensions.iconSize30),label: "AC Manage"),
        ],
      )
    );
  }
}

class BossNavigationBar extends StatelessWidget{ //for Boss
  @override
  Widget build(BuildContext context){
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: MyAppColorSetting.getNavigationBarBGColor()
      ),
      child: BottomNavigationBar(
        // backgroundColor: Colors.red,
        selectedItemColor: MyAppColorSetting.getNavigationBarTextIconColor(),
        unselectedItemColor: MyAppColorSetting.getNavigationBarTextIconColor(),
        // selectedItemColor: Colors.white,
        // unselectedItemColor: Colors.white,
        selectedFontSize: Dimensions.font15,
        unselectedFontSize: Dimensions.font15,
        showUnselectedLabels: true,
        onTap: (index){
          switch (index){
            case 0:
            authController.backtoWelcomPage();
            break;
            case 1:
            //open a new page that let boss choose person or Date
            authController.seeAttendance();
            break;
            case 2:
            authController.showVisitRequest();
            break;
            case 3:
            authController.showTAQRCode();
            break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,size: Dimensions.iconSize20), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.edit_calendar_sharp,size: Dimensions.iconSize20), label: "Check"),
          BottomNavigationBarItem(icon: Icon(Icons.people_outline, size: Dimensions.iconSize20),label: "Request"),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_2,size: Dimensions.iconSize20),label: "CODE"),
        ],
      )
    );
  }
}

class VisitorNavigationBar extends StatelessWidget{ //for Visitor
  @override
  Widget build(BuildContext context){
    return BottomNavigationBar(
      backgroundColor: MyAppColorSetting.getNavigationBarBGColor(),
        selectedItemColor: MyAppColorSetting.getNavigationBarTextIconColor(),
        unselectedItemColor: MyAppColorSetting.getNavigationBarTextIconColor(),
      selectedFontSize: Dimensions.font15,
      unselectedFontSize: Dimensions.font15,
      showUnselectedLabels: true,
      onTap: (index){
        switch (index){
          case 0:
          authController.backtoWelcomPage();
          break;
          case 1:
          authController.showVisitApplicationForm();
          break;
          case 2:
          // authController.visitorGetVisitRequestRecordFromApi();
          authController.showVisitorApprove();
          break;
        }
      },      
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home,size: Dimensions.iconSize30), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.view_day,size: Dimensions.iconSize30), label: "Application"),
        BottomNavigationBarItem(icon: Icon(Icons.people_outline,size: Dimensions.iconSize30),label: "Visit Reord"),
      ],
    );
  }
}

Widget loggedInTypeNavigationBar(String userType){
  if(userType =="Visitors"){
    return VisitorNavigationBar();
  }else if(userType =="IT support"){
    return ITSupportNavigationBar();
  }else if(userType =="Boss"){
    return BossNavigationBar();
  }else{
    return OWNavigationBar();
  }
}
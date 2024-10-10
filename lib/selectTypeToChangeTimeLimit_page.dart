import 'package:attendance_fyp_app/widgets/colorsSetting.dart';
import 'package:attendance_fyp_app/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:get/get.dart';
import 'package:attendance_fyp_app/utils/dimensions.dart';

final AuthController authController = Get.find<AuthController>();

class selectTypeChangeTimeLimit_page extends StatefulWidget{
  @override
  selectTypeChangeTimeLimit_pageState createState() => selectTypeChangeTimeLimit_pageState();
}

class selectTypeChangeTimeLimit_pageState extends State<selectTypeChangeTimeLimit_page>{

  List<String> checkTypeList = ["Office worker", "IT support"];
  // authController.callStaffNameList;
  String neededTypeSelected = "";

  void _onDropdownItemSelected(String? selectedItem){ //when IT support choose the type, typeSelected should be changed, selectedItem is IT support clicked the type
    setState(() {
      neededTypeSelected = selectedItem!;
      print(neededTypeSelected);
    });
  }

  void selectNeedTypeButtonClicked(){
    if(neededTypeSelected != ""){
      print("button clicked: "+ neededTypeSelected);
      authController.goToChangeTimeLimitPage(neededTypeSelected.toString());
    }else{
      Get.snackbar("Type", "Type select",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "No Type selected",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          'Please select a Name!',
          style: TextStyle(
            color:  MyAppColorSetting.getMessageTextColor()
          ),
        )
      );
    }
  }
  
  @override
  void initState(){
    super.initState();
    initialDropdownItems();
  }

  Future<void> initialDropdownItems() async {

    // await Future.delayed(Duration(seconds: 5));
    neededTypeSelected = checkTypeList.first;

    setState(() {
      //to update state
    });
  }

  @override
  Widget build(BuildContext context){
    // _itemSelected = checkStaffNameList.first;
    return WillPopScope(
      onWillPop: ()async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Choose need update account's Type!",
                        style: TextStyle(
                          color: MyAppColorSetting.getAppBarTextColor()
                        ) 
                      ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                hint: Text("Select A Type", style: TextStyle(fontSize: Dimensions.font20),),
                value: neededTypeSelected,
                onChanged: _onDropdownItemSelected,
                items: checkTypeList.map((String item){
                  return DropdownMenuItem<String>(
                    value: item, 
                    child: Text(item, style: TextStyle(fontSize: Dimensions.font20)),
                  );
                }).toList(),
              ),
              SizedBox(height: Dimensions.heihgt15,),
              ElevatedButton(
                onPressed: selectNeedTypeButtonClicked,
                child: Text('Choose the type!'))
            ],
          )
        ),
        bottomNavigationBar: loggedInTypeNavigationBar(authController.theMemeberType)
      )
    ); 
  }
}
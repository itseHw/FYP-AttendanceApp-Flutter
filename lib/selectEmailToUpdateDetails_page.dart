import 'package:attendance_fyp_app/widgets/colorsSetting.dart';
import 'package:attendance_fyp_app/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:attendance_fyp_app/utils/auth_controller.dart';
import 'package:get/get.dart';
import 'package:attendance_fyp_app/utils/dimensions.dart';

final AuthController authController = Get.find<AuthController>();

class selectEmailToUpdateDetailsPage extends StatefulWidget{
  @override
  selectEmailToUpdateDetailsPageState createState() => selectEmailToUpdateDetailsPageState();
}

class selectEmailToUpdateDetailsPageState extends State<selectEmailToUpdateDetailsPage>{

  List<String> staffInTypeEmailList = [];
  String needEmailSelected = "";

  void _onDropdownItemSelected(String? selectedItem){ //when IT support choose the email, needEmailSelected should changed, selectedItem is IT Support clicked the name
    setState(() {
      needEmailSelected = selectedItem!;
      print(needEmailSelected);
    });
  }
  

  void checkAccountNameButtonClicked(){
    if(needEmailSelected != ""){
      print("button clicked: "+ needEmailSelected);
      authController.getAccountDetailsFromApi(needEmailSelected, "itUpdateACData");
    }else{
      Get.snackbar("Email", "Email select",
        backgroundColor: MyAppColorSetting.getMessageBackGroundColor(),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "No Email selected",
          style: TextStyle(
            color: MyAppColorSetting.getMessageTitleColor()
          ),
        ),
        messageText: Text(
          'Please select a Email!',
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
    staffInTypeEmailList =  authController.callStaffNameList;
    needEmailSelected = staffInTypeEmailList.first;
    // nameSelected = checkStaffNameList.isNotEmpty ? checkStaffNameList.first :'';

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
          title: Text('Choose a Email!',
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
                hint: Text("Select A Email", style: TextStyle(fontSize: Dimensions.font20),),
                value: needEmailSelected,
                onChanged: _onDropdownItemSelected,
                items: staffInTypeEmailList.map((String item){
                  return DropdownMenuItem<String>(
                    value: item, 
                    child: Text(item, style: TextStyle(fontSize: Dimensions.font20)),
                  );
                }).toList(),
              ),
              SizedBox(height: Dimensions.heihgt15,),
              ElevatedButton(
                onPressed: checkAccountNameButtonClicked,
                child: Text('Choose a Email!'))
            ],
          )
        ),
        bottomNavigationBar: loggedInTypeNavigationBar(authController.theMemeberType)
      )
    ); 
  }
}
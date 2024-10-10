import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppColorSetting{
  //For snackBar Color
  static Color getMessageTextColor(){
    return Get.isDarkMode ? Colors.black : Colors.white;
  }

    static Color getMessageTitleColor(){
    return Get.isDarkMode ? Colors.grey : Colors.blue;
  }

  static Color getMessageBackGroundColor(){
    return Get.isDarkMode ? Colors.red : Colors.black;
  }

  //End of setting Message(get.sncakbar) Color

  //For Navigation Bar Color

  static Color getNavigationBarBGColor(){
    return Get.isDarkMode ? Colors.white : Colors.black;
  }

  static Color getNavigationBarTextIconColor(){
    return Get.isDarkMode ? Colors.black : Colors.white;
  }

  //End of setting Navigation Bar Color

  //For setting Input Text Box Color

  static Color getAlterTextColor(){
    return Colors.red;
  }

  static Color getTextBoxShadowColor(){
    return Get.isDarkMode ? Colors.white.withOpacity(0.3) : Colors.grey.withOpacity(0.3);
  }

  // static Color getTextBoxHintColor(){
  //   return Get.isDarkMode ? Colors.white.withOpacity(0.3) : Colors.grey;
  // }

  static Color getTextBoxBorderColor(){
    return Get.isDarkMode ? Colors.black : Colors.white;
  }

  static Color getTextBoxIconColor(){
    return Colors.purple;
  }
  //End of setting Text Box Color

  //For setting richText on SignUP Page and SignIn Page
  static Color getRichTextSignINUPColor(){
    return Get.isDarkMode ? Colors.yellow : Colors.grey;
  }

  static Color getRichTextClickColor(){
    return Get.isDarkMode ? Colors.white : Colors.black;
  }

  //End of setting richText on SignUp Page and SingIn Page

  //For setting textColor in the button with background Image

  static Color getTextInBGImageColor(){
    return Colors.white;
  }

  //End for setting textColor in the button with background Image

  // For settting Context Color

  static Color getContextTitleColor(){
    return Get.isDarkMode ? Colors.lightGreen : Colors.green;
  }

  static Color getContextSecondTitleColor(){
    return Colors.grey;
  }

  static Color getContextTextColor(){
    return Get.isDarkMode ? Colors.white : Colors.black;
  }

  //End for setting Context Color

  //For setting App Bar Color
  static Color getAppBarBackGroundColor(){
    return Get.isDarkMode ? Colors.red : Colors.purple;
  }

  static Color getAppBarTextColor(){
    return Get.isDarkMode ? Colors.black: Colors.blue;
  }

  static Color getRecordSitSpecialInCardTextColor(){
    return Colors.red;
  }
  
  static Color getRecordSitNormalInCardTextColor(){
    return Get.isDarkMode ? Colors.white: Colors.black;
  }
  //End of setting App Bar Color

}
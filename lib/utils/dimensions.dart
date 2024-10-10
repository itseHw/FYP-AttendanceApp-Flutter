import 'package:get/get.dart';

//Testing for non fixibile value for height weight
class Dimensions{

  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;


  //691.0/500(for you want the size) = 1.1
  static double pageView = screenHeight/1.1;
  //static double pageViewContainer = screenHeight/1.5;
  static double pageViewForm = screenHeight/1.5;

  //set Height to the Sizedbox and ...
  //691.0/60= 11.5
  // static double heihgtMi15 = screenHeight/0.85;
  static double heihgt80 = screenHeight/8.63;
  static double heihgt60 = screenHeight/11.5;
  static double heihgt30 = screenHeight/23.03;
  static double heihgt15 = screenHeight/46.07;
  

  //set width(window size is 1264.0) (margin need to test, left and right --> width, top and bottom --> height)
  static double width60 = screenHeight/11.5;
  static double width30 = screenHeight/23.03;
  static double width15 = screenHeight/46.07;

  //set Height for text
  static double font10 = screenHeight/69.1;
  static double font15 = screenHeight/46.07;
  static double font20 = screenHeight/34.55;
  static double font40 = screenHeight/17.28;

  //set Height for button
  static double button20 = screenHeight/34.55;
  static double button60 = screenHeight/11.5;

  //for radius
  static double radius60 = screenHeight/11.5;
  static double radius30 = screenHeight/23.03;
  static double radius10 = screenHeight/69.1;
  static double radius5 = screenHeight/138.2;

  // for icon
  static double iconSize100 = screenHeight/6.9;
  static double iconSize30 = screenHeight/23.03;
  static double iconSize20 = screenHeight/34.55;
  static double iconSize10 = screenHeight/69.1;

  //for image
  static double imageSize200 = screenHeight/3.45;
}
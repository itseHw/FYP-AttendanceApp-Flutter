import 'package:flutter/material.dart';
import 'package:attendance_fyp_app/utils/dimensions.dart';

//This widget is making string for different size, colors, text

class MakeText extends StatelessWidget{
  Color? color; //keep reuse and different color
  final String text; //keep reuse and different text
  double size; //for different size
  TextOverflow overFlow; //for screen not enough to show the strings

  MakeText({
    Key? key, 
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.size = 0,
    this.overFlow=TextOverflow.ellipsis
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Text(
      maxLines: 1, //need check
      text, 
      overflow: overFlow, 
      style: TextStyle( 
        //fontFamily: 'Roboto',
        color: color, 
        fontSize: size==0?Dimensions.font20:size,
        fontWeight: FontWeight.w400),
    );
  }
}
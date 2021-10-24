
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ktn_news/constants.dart';

class CustomTextStyle {
  static TextStyle display0(context) {
    return Theme
        .of(context)
        .textTheme
        .display1!
        .copyWith(fontSize: 16.0 ,color:myRed,fontWeight: FontWeight.bold);
  }
  static TextStyle display00(context) {
    return Theme
        .of(context)
        .textTheme
        .display1!
        .copyWith(fontSize: 14.0 ,color:kPrimaryColor,fontWeight: FontWeight.bold);
  } static TextStyle display01(context) {
    return Theme
        .of(context)
        .textTheme
        .display1!
        .copyWith(fontSize: 14.0 ,color:myRed,fontWeight: FontWeight.bold);
  } static TextStyle display1(context) {
    return Theme
        .of(context)
        .textTheme
        .display1!
        .copyWith(fontSize: 12.0 ,color:Theme.of(context).textSelectionColor,fontWeight: FontWeight.bold);
  }
  static TextStyle display2(context) {
    return Theme
        .of(context)
        .textTheme
        .display1!
        .copyWith(fontSize: 15.0,color: Theme.of(context).textSelectionColor);
  }
  static TextStyle display3(context) {
    return Theme
        .of(context)
        .textTheme
        .display1!
        .copyWith(fontSize: 12.0,color:Colors.white,fontWeight: FontWeight.w400);
  } static TextStyle display4(context) {
    return Theme
        .of(context)
        .textTheme
        .display1!
        .copyWith(fontSize: 13.0,color:Colors.white,fontWeight: FontWeight.bold);
  } static TextStyle ytCaption(context) {
    return Theme
        .of(context)
        .textTheme
        .display1!
        .copyWith(fontSize: 12.0,color:Colors.white);
  }
  static TextStyle display5(context) {
    return Theme
        .of(context)
        .textTheme
        .display1!
        .copyWith(fontSize: 12.0,color: Colors.white.withOpacity(0.4),fontWeight: FontWeight.w400);
  }
}
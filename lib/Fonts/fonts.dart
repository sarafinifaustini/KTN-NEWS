
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ktn_news/constants.dart';

class CustomTextStyle {
  static TextStyle display1(context) {
    return Theme
        .of(context)
        .textTheme
        .display1!
        .copyWith(fontSize: 15.0 ,color:Theme.of(context).textSelectionColor,fontWeight: FontWeight.bold);
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
        .copyWith(fontSize: 15.0,color: Colors.white.withOpacity(0.4),fontWeight: FontWeight.w400);
  } static TextStyle display4(context) {
    return Theme
        .of(context)
        .textTheme
        .display1!
        .copyWith(fontSize: 15.0,color:Colors.white);
  }
  static TextStyle display5(context) {
    return Theme
        .of(context)
        .textTheme
        .display1!
        .copyWith(fontSize: 15.0,color: Colors.white.withOpacity(0.4),fontWeight: FontWeight.w400);
  }
}
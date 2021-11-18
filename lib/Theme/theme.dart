

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';



class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }
  getCurrentStatusNavigationBarColor() {
    if (isDarkMode) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(

        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF26242e),
        systemNavigationBarIconBrightness: Brightness.light,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFFFFFFFF),
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    }
  }

  void toggleTheme(bool isOn) {
    Text(isOn? 'DarkMode':'LightMode',  style: TextStyle(fontWeight: FontWeight.bold),);
    themeMode = isOn ? ThemeMode.dark: ThemeMode.light;
    getCurrentStatusNavigationBarColor();
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    bottomSheetTheme: BottomSheetThemeData(modalBackgroundColor: Colors.black),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // scaffoldBackgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor:  Colors.black,
    // primaryColorDark: Colors.black,
    backgroundColor: myRed,
    colorScheme: ColorScheme.dark(),

    primaryColorDark: Colors.white10,
    canvasColor: myRed,
    primaryColorLight:Colors.grey[500],
    textSelectionColor: Colors.white,
    shadowColor: Colors.black,

    buttonColor: kPrimaryColor,
    iconTheme: IconThemeData(color: myRed,),

    textTheme:TextTheme(
      bodyText1: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 12,
      ),
      bodyText2: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 12,
      ),
    ).apply(
      bodyColor: Colors.white,

      // displayColor: Colors.green,
    ),
    //   primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
    //   textTheme: Typography(platform: TargetPlatform.iOS).white,
  );

  static final lightTheme = ThemeData(
    bottomSheetTheme: BottomSheetThemeData(modalBackgroundColor: Colors.black),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    backgroundColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: themeWhite,
    primaryColorDark: Colors.grey[300],
    primaryColorLight:Colors.grey[100],
    colorScheme: ColorScheme.light(),
    focusColor: Colors.black,
    dividerColor: kPrimaryColor,
    textSelectionColor: Colors.black,
    // textTheme: GoogleFonts.latoTextTheme(),

    canvasColor:myRed,
    iconTheme: IconThemeData(color: myRed),
    buttonTheme: ButtonThemeData(buttonColor:kPrimaryColor,),
    textTheme:TextTheme(
      bodyText1: GoogleFonts.inter(
        color: Colors.grey.shade900,
        fontSize: 12,
      ),
      bodyText2: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 12,
      ),
    ).apply(
      bodyColor:Colors.grey.shade900,
      // displayColor: Colors.green,
    ),
  );
}
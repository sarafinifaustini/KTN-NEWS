
import 'package:flutter/material.dart';
import 'Screens/LandingPage.dart';
import 'SplashScreen.dart';
import 'routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name) {
    case HomeViewRoute:
      return MaterialPageRoute(builder: (context) => Splash());
    default:
      return MaterialPageRoute(builder: (context) => Splash());
  }
}
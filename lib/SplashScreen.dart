import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ktn_news/API/API_Calls.dart';
import 'package:ktn_news/Screens/LandingPage.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:page_transition/page_transition.dart';

import 'Video/YoutubePlayer.dart';
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();

}
class _SplashState extends State<Splash>  with TickerProviderStateMixin {
  AnimationController? _controller;
  String? theToken;

  @override
  void initState() {
    super.initState();
    APICalls.getVideoId();
    print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<inside the splash screen");
print(YoutubeVideo.theLiveStreamVideoId);
    _controller = AnimationController(
      // duration: Duration(seconds: 5),
      vsync: this,
    );
  }
  Function duringSplash = () {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 100)
      return 1;
    else
      return 2;
  };

  Map<int, Widget> op = {1: LandingPage(), 2:LandingPage()};


  @override
  Widget build(BuildContext context) {
    return  CustomSplash(
      imagePath: 'assets/images/logo.png',
      backGroundColor:Theme.of(context).scaffoldBackgroundColor,
      // backGroundColor: Color(0xfffc6042),
      animationEffect: 'zoom-in',
      logoSize: 200,
      home: LandingPage(),
      customFunction: duringSplash,
      duration: 2500,
      type: CustomSplashType.StaticDuration,
      outputAndHome: op,
    );

  }
}

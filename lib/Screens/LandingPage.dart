import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktn_news/Screens/categories/Business.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ktn_news/Screens/categories/ViewAll/allMoreVideos.dart';
import 'package:ktn_news/Screens/categories/liveStream/LiveStream.dart';
import 'package:ktn_news/Video/YoutubePlayer.dart';
import 'package:ktn_news/constants.dart';
import 'package:ktn_news/model/video.dart';
import 'categories/Features.dart';
import 'categories/News/News.dart';
import 'categories/Sports.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LandingPage extends StatefulWidget {
  static int landingPageIndex = 0;
  static String? videoID;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  YoutubePlayerController? _controller;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  refreshAction(theVideoId) async{

      // APICalls.getVideo(NewsPage.playingVideo!);
      print("here");

          if(this.mounted) {
            setState(() {
              YoutubeVideo.controller!.load(theVideoId);
            });
          }
  }
  PageController pageController =
      PageController(initialPage: LandingPage.landingPageIndex);

  int _currentIndex = LandingPage.landingPageIndex;
  final bottomNavigationItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.live_tv),
      label: "Live",
    ),
    BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.newspaper), label: "News"),
    BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.star), label: "Features"),
    BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.basketballBall), label: "Sports"),
    BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.briefcase), label: "Business"),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return
      Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          title: FittedBox(
            child: Container(
                height: size.height * 0.08,
                // height: size.height * 0.08,
                child: Image.asset("assets/images/logo.png")),
          ),
          actions: [
            // Row(
            //   children: [
            //     Card(
            //       color: myRed,
            //       child: FlatButton(onPressed: () {
            //        setState(() {
            //         refreshAction("X0HnLzXnwPo");
            //        });
            //       },
            //         child: Row(
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.only(right:8.0),
            //               child: Icon(Icons.live_tv,color: Colors.white,),
            //             ),
            //
            //             Text("Watch Live",style: TextStyle(color: Colors.white),),
            //           ],
            //         ),),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(12.0),
            //       child: Icon(FontAwesomeIcons.user),
            //     ),
            //   ],
            // ),
          ],
        ),

        body: PageView(
          physics: new NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          children: [
            LiveStreamPage(),
            NewsPage(),
            FeaturesPage(),
            SportsPage(),
            BusinessPage(),
          ],
        ),
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Theme
                .of(context)
                .scaffoldBackgroundColor,

            primaryColor: kPrimaryColor,
            // inactive items foreground

            // TextTheme(caption: TextStyle(color: Colors.black45))
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            selectedItemColor: Theme
                .of(context)
                .backgroundColor,
            items: bottomNavigationItems,
            // backgroundColor: Theme.of(context).canvasColor,
            onTap: (newIndex) {
              pageController.animateToPage(newIndex,
                  duration: Duration(milliseconds: 1),
                  curve: Curves.easeInOut);
            },
          ),
        ),
      );
  }
}

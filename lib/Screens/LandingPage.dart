import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktn_news/Screens/categories/Business.dart';
import 'file:///C:/Users/jsarafini/AndroidStudioProjects/ktn_news/lib/Screens/categories/liveStream/LiveStream.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ktn_news/Screens/categories/ViewAll/allMoreVideos.dart';
import 'package:ktn_news/constants.dart';
import 'categories/Features.dart';
import 'categories/News/News.dart';
import 'categories/Sports.dart';
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

  // String? videoID = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=i5jboIWfGMA");

  final List<String> _ids = [
    'gQDByCdjUXw',
    'iLnmTe5Q2Qw',
    '_WoCV4c6XOE',
    'KmzdUe0RSJo',
    '6jZDSSZZxjQ',
    'p2lYr3vM_1w',
    '7QUtEmBT_-w',
    '34_PXCzGw1M',
  ];

  @override
  void initState() {
    super.initState();
    print("---------------------------------------------");

      LandingPage.videoID = YoutubePlayer.convertUrlToId(
          "https://www.youtube.com/watch?v=htqXL94Rza4");

    print(LandingPage.videoID);
    _controller = YoutubePlayerController(
      initialVideoId: LandingPage.videoID!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: true,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller!.value.isFullScreen) {
      setState(() {
        LiveStreamPage.youTubeTitle = _controller!.metadata.title;
        _playerState = _controller!.value.playerState;
        _videoMetaData = _controller!.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller!.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller!.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  PageController pageController =
      PageController(initialPage: LandingPage.landingPageIndex);

  int _currentIndex = LandingPage.landingPageIndex;
  final bottomNavigationItems = [
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.home),
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
    Size size = MediaQuery.of(context).size;
    return YoutubePlayerBuilder(
        onExitFullScreen: () {
          // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
          SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        },
        player:
        YoutubePlayer(
          controller: _controller!,
          showVideoProgressIndicator: true,
          liveUIColor: myRed,
          progressIndicatorColor: Colors.blueAccent,
          topActions: <Widget>[
            const SizedBox(width: 8.0),
            IconButton(
              icon: const Icon(
                Icons.share,
                color: Colors.white,
                size: 25.0,
              ),
              onPressed: () {
                log('Settings Tapped!');
              },
            ),
          ],
          onReady: () {
            _isPlayerReady = true;
          },
          onEnded: (data) {
            _controller!
                .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
            _showSnackBar('Next Video Started!');
          },
        ),
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                    height: size.height * 0.08,
                    child: Image.asset("assets/images/logo.png")),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(FontAwesomeIcons.user),
                ),
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
                canvasColor: Theme.of(context).scaffoldBackgroundColor,

                primaryColor: kPrimaryColor,
                // inactive items foreground

                // TextTheme(caption: TextStyle(color: Colors.black45))
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                selectedItemColor: Theme.of(context).backgroundColor,
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
        });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}

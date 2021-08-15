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

class LandingPage extends StatefulWidget {
  static int landingPageIndex =0;


  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  PageController pageController = PageController(initialPage: LandingPage.landingPageIndex);

  int _currentIndex =LandingPage.landingPageIndex;
  final bottomNavigationItems = [
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.home), label: "Live",),
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top:16.0),
          child: Container(
              height: size.height *0.08,
              child: Image.asset("assets/images/logo.png")),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(FontAwesomeIcons.user),
          ),
        ],
      ),

      body:PageView(
        physics:new NeverScrollableScrollPhysics(),
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
      bottomNavigationBar:new Theme(

        data: Theme.of(context).copyWith(

          // sets the background color of the `BottomNavigationBar`
          canvasColor:Theme.of(context).scaffoldBackgroundColor,

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
  }
}

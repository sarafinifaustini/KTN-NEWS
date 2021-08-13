import 'dart:convert';
import 'package:ktn_news/Screens/LandingPage.dart';
import 'package:ktn_news/Screens/categories/liveStream/MostViewed.dart';
import 'package:ktn_news/Screens/categories/liveStream/worldNews.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:ktn_news/API/APIs.dart';
import 'package:ktn_news/Screens/LifeCycleManager.dart';
import 'package:ktn_news/Screens/categories/liveStream/KTN_Business.dart';
import 'package:ktn_news/Screens/categories/liveStream/KTN_Sports.dart';
import 'package:ktn_news/Screens/categories/liveStream/KTN_morning.dart';
import 'package:ktn_news/Screens/categories/liveStream/ktn_leo.dart';
import 'package:ktn_news/Video/WebView.dart';
import 'package:ktn_news/model/Category1.dart';
import 'package:http/http.dart' as http;
import 'package:ktn_news/Fonts/fonts.dart';
import 'package:ktn_news/model/video.dart';

import '../../../API/API_Calls.dart';
import '../../../API/API_Calls.dart';
import '../../../API/API_Calls.dart';
import '../../../constants.dart';

class NewsPage extends StatefulWidget {
  static int? playingVideo;
  static String? liveThumb;
  static String? playingTitle;

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with WidgetsBindingObserver {
  final controller = ScrollController();
  double cWidth = 0.0;
  double itemHeight = 28.0;
  double? screenWidth;
  var screenHeight;
  double screenShrink = 4.0;
  var cHeight;
  Video? video;
  WebViewController? _controller;
  final _key = UniqueKey();
  bool isScreenVisible = true;
  List mainVideos = [];

  Future<List<Videos>> getVideos() async {
    try {
      final response = await http.get(Uri.parse(news),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json"
          });
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['videos'];
        mainVideos = jsonResponse;
        NewsPage.liveThumb = mainVideos[0]['thumbnail'];
        NewsPage.playingTitle = mainVideos[0]['title'];
        NewsPage.playingVideo = mainVideos[0]['id'];
        print(NewsPage.playingVideo);
        print("hapo juu");
        print(NewsPage.liveThumb);
        // print(jsonResponse);
        return jsonResponse.map((data) => new Videos.fromJson(data)).toList();
      } else {
        throw Exception('Unexpected error occurred !');
      }
    } catch (e) {
      throw e;
    }
  }

  static Future refreshVideo(context) async {
    // print("in refresh");
    return APICalls.getVideo(NewsPage.playingVideo!);
  }

  void initState() {
    super.initState();
    controller.addListener((onScroll));
    APICalls.refreshLiveStream(context);
    refreshVideo(context);
    WidgetsBinding.instance!.addObserver(this);
    getVideos();
  }

  onScroll() {
    if (controller.position.atEdge) {
      if (controller.position.pixels == 0) {
        //if at the top
        print("at the top");
        setState(() {
          cHeight = screenHeight * 0.4;
        });
      }
      //else if at bottom
    } else {
      print("not at top");
      setState(() {
        cHeight = screenHeight * 0.2;
      });
    }
  }


  @override
  void dispose() {
    super.dispose();
    controller.removeListener(onScroll);
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        print("--------------------------------------");
        print(NewsPage.playingVideo!);
       APICalls.getVideo(NewsPage.playingVideo!);
        isScreenVisible = true;
      });
      refreshVideo(context);
      _controller?.reload();
    } else {
      setState(() {
        isScreenVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: () => APICalls.refreshLiveStream(context),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            LifeCycleManager(
                child: RefreshIndicator(
                  onRefresh: () => APICalls.refreshLiveStream(context),
                  child: FutureBuilder<Video>(
                    future: APICalls.getVideo(NewsPage.playingVideo!),
                    builder: (context,snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Ooops! Something went wrong."),
                        );
                      }
                      if (snapshot.hasData) {
                        video = snapshot.data;
                        return Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.black.withOpacity(1),
                                Colors.black.withOpacity(0.0),
                              ], end: Alignment.topCenter, begin: Alignment
                                  .bottomCenter)),
                          child: Column(
                            children: [
                              isScreenVisible
                                  ? AnimatedContainer(
                                  duration: Duration(milliseconds: 0),
                                  curve: Curves.bounceInOut,
                                  color: Colors.transparent,
                                  height: cHeight,
                                  width: double.infinity,
                                  child: Container(
                                    height: screenHeight * 0.4,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: WebView(
                                        key: _key,
                                        javascriptMode: JavascriptMode
                                            .unrestricted,
                                        initialUrl:video!.videoURL,
                                        onWebViewCreated: (controller) =>
                                        _controller = controller,
                                      ),
                                    ),
                                  ))
                                  : Text("Not found"),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 0),
                                curve: Curves.bounceInOut,
                                color: Colors.transparent,
                                height: 60,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "NOW PLAYING",
                                          style: CustomTextStyle.display3(
                                              context),
                                        )),
                                    Flexible(
                                      child: Text(
                                       video!.title!,
                                        style: CustomTextStyle.display4(context),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                    }
                      return Container(
                        color: Colors.transparent,
                      );
                    }

                  ),
                )


                // WebViewContainer("https://www.youtube.com/embed/live_stream?channel=UCKVsdeoHExltrWMuK0hOWmg&rel=0&autoplay=1"))
                ),
            Expanded(
              child: Container(
                child: FutureBuilder<List<Videos>>(
                    future: APICalls.getVideos(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Oops! Something went wrong'),
                        );
                      }
                      if (snapshot.hasData) {
                        List<Videos>? data = snapshot.data;
                        return SingleChildScrollView(
                            controller: controller,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Text(
                                        "MORE VIDEOS",
                                        style:
                                            CustomTextStyle.display1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: kDefaultPadding / 2),
                                      height: size.height * 0.28,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: data!.length,
                                        itemBuilder: (context, index) =>
                                            GestureDetector(
                                          onTap: () {
                                            print("tapped");
                                            setState(() {
                                              print(NewsPage.liveThumb);
                                              NewsPage.liveThumb =
                                                  data[index].thumbnail;
                                              print(NewsPage.liveThumb);
                                              NewsPage.playingTitle =
                                                  data[index].title;

                                              print("on tap video");
                                              print(NewsPage.playingVideo);
                                              print("new load");

                                                NewsPage.playingVideo= data[index].id;
                                              print(NewsPage.playingVideo);

                                            });
                                            LandingPage.landingPageIndex =1;
                                            setState(() {
                                              NewsPage.playingVideo= data[index].id;
                                              refreshVideo(context);
                                              _controller?.reload();
                                            });

                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (_) {
                                            //           return LandingPage();
                                            //         }));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Container(
                                              // height: size.height*0.16,
                                              width: size.width * 0.7,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: size.width,
                                                    margin: EdgeInsets.only(
                                                        right: 8),
                                                    // width: 160,
                                                    height: 160,
                                                    child: Image.network(
                                                      data[index].thumbnail!,
                                                      fit: BoxFit.contain,
                                                      width: size.width,
                                                      height: size.height,
                                                      filterQuality:
                                                          FilterQuality.high,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          data[index].title!,
                                                          // style: CustomTextStyle.display1(context),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15, right: 15),
                                      child: Text(
                                        "WORLD NEWS",style: CustomTextStyle.display1(context),

                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    WorldNewsPage(),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15, right: 15),
                                      child: Text(
                                        "KTN MBIU",style: CustomTextStyle.display1(context),

                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    KTNLeoPage(),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15, right: 15),
                                      child: Text(
                                        "BUSINESS TODAY",style: CustomTextStyle.display1(context),

                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    // KTNSportsSection(),
                                    KTNBusinessSection(),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15, right: 15),
                                      child: Text(
                                        "MOST VIEWED VIDEOS",style: CustomTextStyle.display1(context),

                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    // KTNMESection(),
                                    MostViewedPage(),
                                  ],
                                )
                              ],
                            ));
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget latestStories() {
    Size size = MediaQuery.of(context).size;
    Videos videos;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: GestureDetector(
        onTap: () {
          print("tapped");
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (_) => VideoDetailPage(
          //             videoUrl:
          //             "assets/videos/video_1.mp4")));
        },
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            children: List.generate(10, (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                              image: AssetImage("assets/images/logo.png"),
                              fit: BoxFit.cover)),
                    ),
                    Text("videos[0].title"),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

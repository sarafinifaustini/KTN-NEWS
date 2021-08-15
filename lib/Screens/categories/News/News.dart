import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:ktn_news/Screens/categories/ViewAll/allMoreVideos.dart';
import 'package:ktn_news/Screens/categories/liveStream/MostViewed.dart';
import 'package:ktn_news/Screens/categories/liveStream/moreVideos.dart';
import 'package:ktn_news/Screens/categories/liveStream/worldNews.dart';
import 'package:ktn_news/Video/MainVideo.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:ktn_news/API/APIs.dart';
import 'package:ktn_news/Screens/LifeCycleManager.dart';
import 'package:ktn_news/Screens/categories/liveStream/KTN_Business.dart';
import 'package:ktn_news/Screens/categories/liveStream/ktn_leo.dart';
import 'package:ktn_news/Video/WebView.dart';
import 'package:ktn_news/model/Category1.dart';
import 'package:http/http.dart' as http;
import 'package:ktn_news/Fonts/fonts.dart';
import 'package:ktn_news/model/video.dart';

import '../../../API/API_Calls.dart';

class NewsPage extends StatefulWidget {
  static int? playingVideo;
  static String? liveThumb;
  static String? playingTitle;
  static var screenHeight;
  static var cHeight ;
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>  with AutomaticKeepAliveClientMixin {
   final controller = ScrollController();

  Video? video;
  WebViewController? _controller;
  final _key = UniqueKey();
  bool isScreenVisible = true;
  List mainVideos = [];
  var theTop;
  var theBottom;
  var theLeft;
  var theRight;
  var theLeft2;
  var theBottom2;
var theTop2;
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
         print(jsonResponse);
        return jsonResponse.map((data) => new Videos.fromJson(data)).toList();
      } else {
        throw Exception('Unexpected error occurred !');
      }
    } catch (e) {
      throw e;
    }
  }

  void initState() {
    super.initState();
    getVideos();
     controller.addListener((onScroll));
    APICalls.refreshLiveStream(context);

  print(NewsPage.playingVideo);

  }

  onScroll() {
    if (controller.position.atEdge) {
      if (controller.position.pixels == 0) {
        //if at the top
        print("at the top");
        if(this.mounted) {
          setState(() {
            NewsPage.cHeight = NewsPage.screenHeight * 0.35;
          });
        }
      }
      //else if at bottom
    } else {
      print("not at top");
      if(this.mounted){
      setState(() {
        NewsPage.cHeight = NewsPage.screenHeight * 0.2;
      });
    }}
  }


  @override
  void dispose() {
    super.dispose();
     controller.removeListener(onScroll);

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        // print("--------------------------------------");
        // print(NewsPage.playingVideo!);
       // APICalls.getVideo(NewsPage.playingVideo!);
        isScreenVisible = true;
      });

      _controller?.reload();
    } else {
      setState(() {
        isScreenVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    NewsPage.screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
     NewsPage.cHeight = NewsPage.screenHeight*0.3;
    NewsPage.playingVideo = mainVideos[0]['id'];
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
                          child: Container(
                            color: Colors.transparent,
                          ),
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
                              AnimatedContainer(
                                 duration: Duration(milliseconds: 0),
                                 curve: Curves.bounceInOut,
                                 color: Colors.transparent,
                                 height: NewsPage.cHeight,
                                 child: Stack(

                                  fit: StackFit.expand,
                                   children: [
                                     WebViewContainer(video!.videoURL!),
                                    ],
                                 ),

                              ),
                              Align(
                                  alignment:Alignment.bottomRight,
                                  child: IconButton(onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) {
                                              return MainVideo();
                                            }));

                                  }, icon: Icon(FontAwesomeIcons.expand),

                      )
                              ),

                              // AnimatedContainer(
                              //   duration: Duration(milliseconds: 0),
                              //   curve: Curves.bounceInOut,
                              //   color: Colors.transparent,
                              //   height: 60,
                              //   width: double.infinity,
                              //   child: Column(
                              //     children: [
                              //       Align(
                              //           alignment: Alignment.bottomLeft,
                              //           child: Text(
                              //             "NOW PLAYING",
                              //             style: CustomTextStyle.display3(
                              //                 context),
                              //           )),
                              //       Flexible(
                              //         child: Text(
                              //          NewsPage.playingTitle!,
                              //           style: CustomTextStyle.display4(context),
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),
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
                color: Theme.of(context).scaffoldBackgroundColor,
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
                                      height: 8,
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
                                      height: 2,
                                    ),
                                   MoreVideosPage(),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Card(
                                        child: FlatButton(onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) {
                                                    return AllMoreVideos();
                                                  }));
                                        },
                                          child: Text("View All"),),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15, right: 15),
                                      child: Text(
                                        "WORLD NEWS",style: CustomTextStyle.display1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                   WorldNewsPage(),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Card(
                                        child: FlatButton(onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) {
                                                    return AllMoreVideos();
                                                  }));
                                        },
                                          child: Text("View All"),),
                                      ),
                                    ),
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
                                    Align(
                                      alignment: Alignment.center,
                                      child: Card(
                                        child: FlatButton(onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) {
                                                    return AllMoreVideos();
                                                  }));
                                        },
                                          child: Text("View All"),),
                                      ),
                                    ),
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
                                    Align(
                                      alignment: Alignment.center,
                                      child: Card(
                                        child: FlatButton(onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) {
                                                    return AllMoreVideos();
                                                  }));
                                        },
                                          child: Text("View All"),),
                                      ),
                                    ),
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

                                    Align(
                                      alignment: Alignment.center,
                                      child: Card(
                                        child: FlatButton(onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) {
                                                    return AllMoreVideos();
                                                  }));
                                        },
                                          child: Text("View All"),),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),

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


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

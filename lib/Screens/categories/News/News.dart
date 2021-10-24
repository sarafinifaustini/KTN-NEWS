import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:ktn_news/API/API_Calls.dart';
import 'package:ktn_news/Screens/categories/ViewAll/allMoreVideos.dart';
import 'package:ktn_news/Screens/categories/liveStream/MostViewed.dart';
import 'package:ktn_news/Screens/categories/liveStream/moreVideos.dart';
import 'package:ktn_news/Screens/categories/liveStream/worldNews.dart';
import 'package:ktn_news/Video/MainVideo.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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
import 'package:shimmer/shimmer.dart';

import '../../../Video/YoutubePlayer.dart';
import 'PlayingVideo.dart';





class NewsPage extends StatefulWidget {
  static int? playingVideo;
  static String? liveThumb;
  static String? playingTitle;
  static var screenHeight;
  static var cHeight ;
  static String moreVideosDetail = "/videos/1/0/20";
  final Widget? child;
  final String? youTubeUrl;
  static String? youTubeTitle;
  static String? theLiveStreamVideoId;
  static String? ID;

  const NewsPage({Key? key, this.youTubeUrl, this.child,}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>  with AutomaticKeepAliveClientMixin {
  final controller = ScrollController();

  Video? video;

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
  bool _isPlayerReady = false;
  var theLiveStreamVideoId = APICalls.getVideoId();
  String videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/embed/live_stream?channel=UCKVsdeoHExltrWMuK0hOWmg")!;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;

  final List<String> _ids = [
    'L-uY64YQXIY',
    'L-uY64YQXIY',
  ];
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
        // NewsPage.playingVideo = mainVideos[0]['id'];
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
    print("inside the youtube video whatever-------------------");
    print(YoutubeVideo.theLiveStreamVideoId);
   if(!this.mounted){
     YoutubeVideo.controller!.pause();
     print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<inside the news page");
   }
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
    YoutubeVideo.controller!.pause();
    controller.removeListener(onScroll);

  }



  @override
  Widget build(BuildContext context) {
    NewsPage.screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;

    NewsPage.cHeight = NewsPage.screenHeight*0.3;
    // NewsPage.playingVideo = mainVideos[0]['id'];
    return RefreshIndicator(
      onRefresh: () => APICalls.refreshLiveStream(context),
      child: YoutubeVideo(
        child: Expanded(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child:
                      SingleChildScrollView(
                        // physics: const NeverScrollableScrollPhysics(),
                        physics: BouncingScrollPhysics(),
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
                                MoreVideosPage(theDetail: "/ktn-news/videos/23/0/20",),
                                Align(
                                  alignment: Alignment.center,
                                  child: Card(
                                    child: FlatButton(onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) {
                                                return AllMoreVideos(theDetail: "/ktn-news/videos/23/0/",theTitle: "More News Videos",);
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
                                                return AllMoreVideos(theDetail:"/ktn-news-category/videos/134/0/",theTitle: "World News",);
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
                                                return AllMoreVideos(theDetail: "/ktn-news-category/videos/2/0/",theTitle: "KTN Mbiu",);
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
                                                return AllMoreVideos(theDetail: "/ktn-news/videos/22/0/",theTitle: "Business Today",);
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
                                                return AllMoreVideos(theDetail: "/ktn-news-popular/videos/newsvideos/0/",theTitle: "Most Viewed Videos");
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
                        ))
  // }
                  // }
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }),
          // ),
        ),
      ),
    ));
  }




  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

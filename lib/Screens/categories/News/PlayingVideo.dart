import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:ktn_news/Screens/categories/ViewAll/allMoreVideos.dart';
import 'package:ktn_news/Screens/categories/liveStream/MostViewed.dart';
import 'package:ktn_news/Screens/categories/liveStream/moreVideos.dart';
import 'package:ktn_news/Screens/categories/liveStream/worldNews.dart';
import 'package:ktn_news/Video/MainVideo.dart';
import 'package:ktn_news/Video/YoutubePlayer.dart';
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
import 'News.dart';

class VideoPage extends StatefulWidget {

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>  with AutomaticKeepAliveClientMixin {
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
    print(news+NewsPage.moreVideosDetail);
    try {
      final response = await http.get(Uri.parse(news+NewsPage.moreVideosDetail),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json"
          });
      print("pox on it");
      print(response);
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['videos'];
        mainVideos = jsonResponse;

        print("pox on it");
        print(mainVideos);
        NewsPage.liveThumb = mainVideos[0]['thumbnail'];
        NewsPage.playingTitle = mainVideos[0]['title'];
         NewsPage.playingVideo = mainVideos[0]['videoUrl'];
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
    // APICalls.getVideo(NewsPage.playingVideo!);
    controller.addListener((onScroll));
    APICalls.refreshLiveStream(context);
print("-------------------------");
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
  Widget build(BuildContext context) {
   NewsPage.screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    NewsPage.cHeight = NewsPage.screenHeight*0.3;

    return LifeCycleManager(
        child: RefreshIndicator(
          onRefresh: () => APICalls.refreshLiveStream(context),
          child: FutureBuilder<Video>(
              future: APICalls.getVideo(2000216880),
              builder: (context,snapshot) {
                print(APICalls.theVideoURL);
                // if (snapshot.hasError) {
                //   print("error");
                //   return Center(
                //     child: Container(
                //       color: Colors.blueAccent,
                //     ),
                //   );
                // }
                // if (snapshot.hasData) {
                //   video = snapshot.data;
                  return Column(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 0),
                        curve: Curves.bounceInOut,
                        color: Colors.transparent,
                         height: NewsPage.screenHeight*0.3,
                        child: YoutubeVideo(youTubeUrl: APICalls.theVideoURL,),
                      ),
                    ],
                  );
                }
              //   return Container(
              //     color: Colors.transparent,
              //   );
              // }

          ),
        )


      // WebViewContainer("https://www.youtube.com/embed/live_stream?channel=UCKVsdeoHExltrWMuK0hOWmg&rel=0&autoplay=1"))
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

import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:ktn_news/API/API_Calls.dart';
import 'package:ktn_news/Screens/categories/ViewAll/allMoreVideos.dart';
import 'package:ktn_news/Screens/categories/liveStream/KTN_morning.dart';
import 'package:ktn_news/Screens/categories/liveStream/LatestStories.dart';
import 'package:ktn_news/Screens/categories/liveStream/MostViewed.dart';
import 'package:ktn_news/Screens/categories/liveStream/moreVideos.dart';
import 'package:ktn_news/Screens/categories/liveStream/worldNews.dart';
import 'package:ktn_news/Video/MainVideo.dart';
import 'package:ktn_news/Video/AllVideos.dart';
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
import '../../../constants.dart';
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

  refreshAction(theVideoId) async {

    print(NewsPage.playingVideo);
    print("inside refresh>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>more vids");
    print(theVideoId);
    String videoURL =
        "https://www.standardmedia.co.ke/farmkenya/api/ktn-home/video/$theVideoId";
    try {
      var result = await http.get(Uri.parse(videoURL));
      if (result.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(result.body)['video'];
        Video video = Video.fromJson(data);
        print("--------------------------");
        print(data['videoURL']);
        setState(() {

            print("this is the first index");
            AllVideos.controller!.load("${data['videoURL']}");

        });
      } else {
        print("problem in refresh Action");
        throw Exception('Could not connect.');
      }
    } catch (e) {
      throw e;
    }

  }
  void initState() {
    super.initState();
    print(NewsPage.playingVideo);

    // refreshAction(NewsPage.playingVideo);
    controller.addListener((onScroll));
    APICalls.refreshLiveStream(context);

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
      child:
            YoutubeVideo(
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
                                      // MoreVideosPage(theDetail: "/ktn-news/videos/23/0/20",theIndex: 1,),
                                      FutureBuilder<List<Videos>>(
                                          future: APICalls.getVideos("/ktn-news/videos/23/0/20"),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasError) {
                                              return SizedBox(
                                                // width: double.infinity,
                                                height: size.height * 0.3,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Shimmer.fromColors(
                                                    baseColor: Theme.of(context).primaryColorDark,
                                                    highlightColor: Theme.of(context).primaryColorLight,
                                                    child: ListView.builder(
                                                      scrollDirection: Axis.horizontal,
                                                      physics: BouncingScrollPhysics(),
                                                      itemCount: 20,
                                                      itemBuilder: (BuildContext context, int index) =>
                                                          dummyShimmer(),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            else if (!snapshot.hasData) {
                                              return SizedBox(
                                                // width: double.infinity,
                                                height: size.height * 0.3,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Shimmer.fromColors(
                                                    baseColor: Theme.of(context).primaryColorDark,
                                                    highlightColor: Theme.of(context).primaryColorLight,
                                                    child: ListView.builder(
                                                      scrollDirection: Axis.horizontal,
                                                      physics: BouncingScrollPhysics(),
                                                      itemCount: 20,
                                                      itemBuilder: (BuildContext context, int index) =>
                                                          dummyShimmer(),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            else if (snapshot.hasData) {
                                              List<Videos>? data = snapshot.data;

                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                                                    height: size.height * 0.3,
                                                    child: ListView.builder(
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: data!.length,
                                                      physics: BouncingScrollPhysics(),
                                                      itemBuilder: (context, index) => GestureDetector(
                                                        onTap: () {
                                                          print("tapped --------------inside News----------------------mot");
                                                          setState(() {
                                                            NewsPage.playingVideo = null;
                                                            NewsPage.playingVideo = data[index].id;
                                                            print(data[index].videoURL);
                                                            YoutubeVideo.controller!.load(data[index].videoURL!);
                                                            // refreshAction(
                                                            //   NewsPage.playingVideo!,);
                                                          });
                                                        },
                                                        child: FittedBox(
                                                          child: Card(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Container(
                                                                // height: size.height*0.16,
                                                                width: size.width * 0.7,
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Container(
                                                                      width: size.width,
                                                                      margin: EdgeInsets.only(right: 8),
                                                                      // width: 160,
                                                                      height: 160,
                                                                      child: Image.network(
                                                                        data[index].thumbnail!,
                                                                        fit: BoxFit.contain,
                                                                        width: size.width,
                                                                        height: size.height,
                                                                        filterQuality: FilterQuality.high,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.stretch,
                                                                        mainAxisAlignment: MainAxisAlignment.end,
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
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                            return Center();
                                            // child: CircularProgressIndicator(),
                                            // );
                                          }),
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
                                          "LATEST STORIES",style: CustomTextStyle.display1(context),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      LatestStories(),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Card(
                                          child: FlatButton(onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) {
                                                      return AllMoreVideos(theDetail:"/ktn-news/videos/1/0/",theTitle: "Latest Stories",);
                                                    }));
                                          },
                                            child: Text("View All"),),
                                        ),
                                      ),Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 15),
                                        child: Text(
                                          "KTN MORNING EXPRESS",style: CustomTextStyle.display1(context),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      KTNMorningExpress(),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Card(
                                          child: FlatButton(onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) {
                                                      return AllMoreVideos(theDetail: "/ktn-news-category/videos/28/0/",theTitle: "KTN Morning Express",);
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
            ),

      );}



  Widget dummyShimmer() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all( 8.0),
      child: Container(
        width: size.width * 0.7,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: size.width,
              height: 160,
              color: Colors.white,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
            ),
            Container(
              width: size.width * 0.7,
              height: 8.0,
              color: Colors.white,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
            ),
            Align(
              alignment:Alignment.bottomLeft,
              child: Container(
                width: size.width * 0.5,
                height: 8.0,
                color: Colors.white,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
            ),
            Align(
              alignment:Alignment.bottomLeft,
              child: Container(
                width: size.width * 0.2,
                height: 8.0,
                color: Colors.white,
              ),
            ),

          ],
        ),
      ),
    );
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

// // import 'dart:convert';
// // import 'package:flutter/widgets.dart';
// // import 'package:ktn_news/Screens/categories/ViewAll/allMoreVideos.dart';
// // import 'package:ktn_news/Screens/categories/liveStream/KTN_morning.dart';
// // import 'package:ktn_news/Screens/categories/liveStream/MostViewed.dart';
// // import 'package:ktn_news/Screens/categories/liveStream/moreVideos.dart';
// // import 'package:ktn_news/Screens/categories/liveStream/worldNews.dart';
// // import 'package:ktn_news/Video/MainVideo.dart';
// // import 'package:ktn_news/Video/YoutubePlayer.dart';
// // import 'package:webview_flutter/webview_flutter.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/rendering.dart';
// // import 'package:flutter/services.dart';
// // import 'package:ktn_news/API/APIs.dart';
// // import 'package:ktn_news/Screens/LifeCycleManager.dart';
// // import 'package:ktn_news/Screens/categories/liveStream/KTN_Business.dart';
// // import 'package:ktn_news/Screens/categories/liveStream/ktn_leo.dart';
// // import 'package:ktn_news/Video/WebView.dart';
// // import 'package:ktn_news/model/Category1.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:ktn_news/Fonts/fonts.dart';
// // import 'package:ktn_news/model/video.dart';
// //
// // import '../../../API/API_Calls.dart';
// // import 'PlayingVideo.dart';
// //
// // class NewsPage extends StatefulWidget {
// //   static int? playingVideo;
// //   static String? liveThumb;
// //   static String? playingTitle;
// //   static var screenHeight;
// //   static var cHeight ;
// //   static String moreVideosDetail = "/videos/1/0/20";
// //   @override
// //   _NewsPageState createState() => _NewsPageState();
// // }
// //
// // class _NewsPageState extends State<NewsPage>  {
// //    final controller = ScrollController();
// //
// //   Video? video;
// //   WebViewController? _controller;
// //   final _key = UniqueKey();
// //   bool isScreenVisible = true;
// //   List mainVideos = [];
// //   var theTop;
// //   var theBottom;
// //   var theLeft;
// //   var theRight;
// //   var theLeft2;
// //   var theBottom2;
// // var theTop2;
// //   Future<List<Videos>> getVideos() async {
// //     try {
// //       final response = await http.get(Uri.parse(news),
// //           headers: <String, String>{
// //             "Accept": "application/json",
// //             "Content-Type": "application/json"
// //           });
// //       if (response.statusCode == 200) {
// //         List jsonResponse = json.decode(response.body)['videos'];
// //         mainVideos = jsonResponse;
// //         NewsPage.liveThumb = mainVideos[0]['thumbnail'];
// //         NewsPage.playingTitle = mainVideos[0]['title'];
// //          // NewsPage.playingVideo = mainVideos[0]['id'];
// //         print(NewsPage.playingVideo);
// //         print("hapo juu");
// //         print(NewsPage.liveThumb);
// //          print(jsonResponse);
// //         return jsonResponse.map((data) => new Videos.fromJson(data)).toList();
// //       } else {
// //         throw Exception('Unexpected error occurred !');
// //       }
// //     } catch (e) {
// //       throw e;
// //     }
// //   }
// //
// //   void initState() {
// //     super.initState();
// //     getVideos();
// //      // controller.addListener((onScroll));
// //     APICalls.refreshLiveStream(context);
// //
// //   print(NewsPage.playingVideo);
// //
// //   }
// //
// //   // onScroll() {
// //   //   if(this.mounted) {
// //   //     if (controller.position.atEdge) {
// //   //       if (controller.position.pixels == 0) {
// //   //         //if at the top
// //   //         print("at the top");
// //   //
// //   //           setState(() {
// //   //             NewsPage.cHeight = NewsPage.screenHeight * 0.35;
// //   //           });
// //   //
// //   //       }
// //   //       //else if at bottom
// //   //     } else {
// //   //       print("not at top");
// //   //       if (this.mounted) {
// //   //         setState(() {
// //   //           NewsPage.cHeight = NewsPage.screenHeight * 0.2;
// //   //         });
// //   //       }
// //   //     }
// //   //   }}
// //
// //   @override
// //   void dispose() {
// //     super.dispose();
// //      // controller.removeListener(onScroll);
// //
// //
// //   }
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     NewsPage.screenHeight = MediaQuery.of(context).size.height;
// //     Size size = MediaQuery.of(context).size;
// //     NewsPage.cHeight =  NewsPage.screenHeight*0.3;
// //     // NewsPage.playingVideo = mainVideos[0]['id'];
// //     return RefreshIndicator(
// //       onRefresh: () => APICalls.refreshLiveStream(context),
// //       child: SafeArea(
// //         bottom: false,
// //         child: Column(
// //           children: [
// //             VideoPage(),
// //             Expanded(
// //               child: Container(
// //                 color: Theme.of(context).scaffoldBackgroundColor,
// //                 child: FutureBuilder<List<Videos>>(
// //                     future: APICalls.getVideos("/videos/1/0/20"),
// //                     builder: (context, snapshot) {
// //                       if (snapshot.hasError) {
// //                         return Center(
// //                           child: Text('Oops! Something went wrong'),
// //                         );
// //                       }
// //                       if (snapshot.hasData) {
// //                         List<Videos>? data = snapshot.data;
// //                         return SingleChildScrollView(
// //                             physics: BouncingScrollPhysics(),
// //                             controller: controller,
// //                             child: Column(
// //                               mainAxisSize: MainAxisSize.min,
// //                               mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                               // crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Column(
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     SizedBox(
// //                                       height: 8,
// //                                     ),
// //                                     Padding(
// //                                       padding: const EdgeInsets.only(
// //                                           left: 15, right: 15),
// //                                       child: Text(
// //                                         "MORE VIDEOS",
// //                                         style:
// //                                         CustomTextStyle.display1(context),
// //                                       ),
// //                                     ),
// //
// //                                     SizedBox(
// //                                       height: 2,
// //                                     ),
// //                                     MoreVideosPage(theDetail: "/videos/1/0/20",),
// //                                     Align(
// //                                       alignment: Alignment.center,
// //                                       child: Card(
// //                                         child: FlatButton(onPressed: () {
// //                                           Navigator.push(
// //                                               context,
// //                                               MaterialPageRoute(
// //                                                   builder: (_) {
// //                                                     return AllMoreVideos();
// //                                                   }));
// //                                         },
// //                                           child: Text("View All"),),
// //                                       ),
// //                                     ),
// //                                     Padding(
// //                                       padding: const EdgeInsets.only(left: 15, right: 15),
// //                                       child: Text(
// //                                         "WORLD NEWS",style: CustomTextStyle.display1(context),
// //                                       ),
// //                                     ),
// //                                     SizedBox(
// //                                       height: 2,
// //                                     ),
// //                                     WorldNewsPage(),
// //                                     Align(
// //                                       alignment: Alignment.center,
// //                                       child: Card(
// //                                         child: FlatButton(onPressed: () {
// //                                           Navigator.push(
// //                                               context,
// //                                               MaterialPageRoute(
// //                                                   builder: (_) {
// //                                                     return AllMoreVideos();
// //                                                   }));
// //                                         },
// //                                           child: Text("View All"),),
// //                                       ),
// //                                     ),
// //                                     Padding(
// //                                       padding: const EdgeInsets.only(left: 15, right: 15),
// //                                       child: Text(
// //                                         "KTN MBIU",style: CustomTextStyle.display1(context),
// //
// //                                       ),
// //                                     ),
// //                                     SizedBox(
// //                                       height: 8,
// //                                     ),
// //                                     KTNLeoPage(),
// //                                     Align(
// //                                       alignment: Alignment.center,
// //                                       child: Card(
// //                                         child: FlatButton(onPressed: () {
// //                                           Navigator.push(
// //                                               context,
// //                                               MaterialPageRoute(
// //                                                   builder: (_) {
// //                                                     return AllMoreVideos();
// //                                                   }));
// //                                         },
// //                                           child: Text("View All"),),
// //                                       ),
// //                                     ),
// //                                     Padding(
// //                                       padding: const EdgeInsets.only(left: 15, right: 15),
// //                                       child: Text(
// //                                         "BUSINESS TODAY",style: CustomTextStyle.display1(context),
// //
// //                                       ),
// //                                     ),
// //                                     SizedBox(
// //                                       height: 8,
// //                                     ),
// //                                     // KTNSportsSection(),
// //                                     KTNBusinessSection(),
// //                                     Align(
// //                                       alignment: Alignment.center,
// //                                       child: Card(
// //                                         child: FlatButton(onPressed: () {
// //                                           Navigator.push(
// //                                               context,
// //                                               MaterialPageRoute(
// //                                                   builder: (_) {
// //                                                     return AllMoreVideos();
// //                                                   }));
// //                                         },
// //                                           child: Text("View All"),),
// //                                       ),
// //                                     ),
// //                                     Padding(
// //                                       padding: const EdgeInsets.only(left: 15, right: 15),
// //                                       child: Text(
// //                                         "MOST VIEWED VIDEOS",style: CustomTextStyle.display1(context),
// //
// //                                       ),
// //                                     ),
// //                                     SizedBox(
// //                                       height: 8,
// //                                     ),
// //                                     // KTNMESection(),
// //                                     MostViewedPage(),
// //
// //                                     Align(
// //                                       alignment: Alignment.center,
// //                                       child: Card(
// //                                         child: FlatButton(onPressed: () {
// //                                           Navigator.push(
// //                                               context,
// //                                               MaterialPageRoute(
// //                                                   builder: (_) {
// //                                                     return AllMoreVideos();
// //                                                   }));
// //                                         },
// //                                           child: Text("View All"),),
// //                                       ),
// //                                     ),
// //                                     SizedBox(
// //                                       height: 30,
// //                                     ),
// //
// //                                   ],
// //                                 )
// //                               ],
// //                             ));
// //                       }
// //                       return Center(
// //                         child: CircularProgressIndicator(),
// //                       );
// //                     }),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// // }
// import 'dart:convert';
// import 'package:flutter/widgets.dart';
// import 'package:ktn_news/API/API_Calls.dart';
// import 'package:ktn_news/Screens/categories/ViewAll/allMoreVideos.dart';
// import 'package:ktn_news/Screens/categories/liveStream/KTN_morning.dart';
// import 'package:ktn_news/Screens/categories/liveStream/LatestStories.dart';
// import 'package:ktn_news/Screens/categories/liveStream/MostViewed.dart';
// import 'package:ktn_news/Screens/categories/liveStream/moreVideos.dart';
// import 'package:ktn_news/Screens/categories/liveStream/worldNews.dart';
// import 'package:ktn_news/Video/MainVideo.dart';
//
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:ktn_news/API/APIs.dart';
// import 'package:ktn_news/Screens/LifeCycleManager.dart';
// import 'package:ktn_news/Screens/categories/liveStream/KTN_Business.dart';
// import 'package:ktn_news/Screens/categories/liveStream/ktn_leo.dart';
// import 'package:ktn_news/Video/WebView.dart';
// import 'package:ktn_news/model/Category1.dart';
// import 'package:http/http.dart' as http;
// import 'package:ktn_news/Fonts/fonts.dart';
// import 'package:ktn_news/model/video.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../../../Video/YoutubePlayer.dart';
// import '../../../constants.dart';
//
//
//
// class LiveStreamPage extends StatefulWidget {
//   static int? playingVideo;
//   static String? liveThumb;
//   static String? playingTitle;
//   static var screenHeight;
//   static var cHeight ;
//   static String moreVideosDetail = "/videos/1/0/20";
//
//
//
//   @override
//   _LiveStreamPageState createState() => _LiveStreamPageState();
// }
//
// class _LiveStreamPageState extends State<LiveStreamPage>  with AutomaticKeepAliveClientMixin {
//   final controller = ScrollController();
//
//   Video? video;
//
//   final _key = UniqueKey();
//   bool isScreenVisible = true;
//   List mainVideos = [];
//   var theTop;
//   var theBottom;
//   var theLeft;
//   var theRight;
//   var theLeft2;
//   var theBottom2;
//   var theTop2;
//   Future<List<Videos>> getVideos() async {
//     try {
//       final response = await http.get(Uri.parse(news),
//           headers: <String, String>{
//             "Accept": "application/json",
//             "Content-Type": "application/json"
//           });
//       if (response.statusCode == 200) {
//         List jsonResponse = json.decode(response.body)['videos'];
//         mainVideos = jsonResponse;
//         LiveStreamPage.liveThumb = mainVideos[0]['thumbnail'];
//         LiveStreamPage.playingTitle = mainVideos[0]['title'];
//         // NewsPage.playingVideo = mainVideos[0]['id'];
//         print(LiveStreamPage.playingVideo);
//         print("hapo juu");
//         print(LiveStreamPage.liveThumb);
//         print(jsonResponse);
//         return jsonResponse.map((data) => new Videos.fromJson(data)).toList();
//       } else {
//         throw Exception('Unexpected error occurred !');
//       }
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   void initState() {
//     super.initState();
//     getVideos();
//     APICalls.getVideoId();
//     controller.addListener((onScroll));
//     APICalls.refreshLiveStream(context);
//
//     print(LiveStreamPage.playingVideo);
//
//   }
//
//   onScroll() {
//     if (controller.position.atEdge) {
//       if (controller.position.pixels == 0) {
//         //if at the top
//         print("at the top");
//         if(this.mounted) {
//           setState(() {
//             LiveStreamPage.cHeight = LiveStreamPage.screenHeight * 0.35;
//           });
//         }
//       }
//       //else if at bottom
//     } else {
//       print("not at top");
//       if(this.mounted){
//         setState(() {
//           LiveStreamPage.cHeight = LiveStreamPage.screenHeight * 0.2;
//         });
//       }}
//   }
//
//
//   @override
//   void dispose() {
//     super.dispose();
//     controller.removeListener(onScroll);
//
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     LiveStreamPage.screenHeight = MediaQuery.of(context).size.height;
//     Size size = MediaQuery.of(context).size;
//
//     LiveStreamPage.cHeight = LiveStreamPage.screenHeight*0.3;
//     // NewsPage.playingVideo = mainVideos[0]['id'];
//     return RefreshIndicator(
//         onRefresh: () => APICalls.refreshLiveStream(context),
//         child: YoutubeVideo(
//           child: Expanded(
//             child: Container(
//                  color: Theme.of(context).scaffoldBackgroundColor,
//                 child:SingleChildScrollView(
//                   // physics: const NeverScrollableScrollPhysics(),
//                     physics: BouncingScrollPhysics(),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       // crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//
//                             // Align(
//                             //   alignment: Alignment.center,
//                             //   child: Card(
//                             //     child: FlatButton(onPressed: () {
//                             //       Navigator.push(
//                             //           context,
//                             //           MaterialPageRoute(
//                             //               builder: (_) {
//                             //                 return AllMoreVideos(theDetail: "/ktn-news/videos/1/0/");
//                             //               }));
//                             //     },
//                             //       child: Row(
//                             //         children: [
//                             //           Icon(Icons.live_tv),
//                             //           Text("Watch Live"),
//                             //         ],
//                             //       ),),
//                             //   ),
//                             // ),
//                             SizedBox(
//                               height: 8,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 15, right: 15),
//                               child: Text(
//                                 "Latest Stories",
//                                 style:
//                                 CustomTextStyle.display1(context),
//                               ),
//                             ),
//
//                             SizedBox(
//                               height: 2,
//                             ),
//                             LatestStories(theDetail: "/ktn-news-category/videos/1/0/20",),
//                             // MoreVideosPage(theDetail: "/ktn-news-category/videos/28/0/10",),
//                             Align(
//                               alignment: Alignment.center,
//                               child: Card(
//                                 child: FlatButton(onPressed: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (_) {
//                                             return AllMoreVideos(theDetail: "/ktn-news/videos/1/0/");
//                                           }));
//                                 },
//                                   child: Text("View All"),),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 15, right: 15),
//                               child: Text(
//                                 "Morning Express",style: CustomTextStyle.display1(context),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 2,
//                             ),
//                             MorningExpressPage(theDetail: "/ktn-news-category/videos/28/0/10",),
//                             Align(
//                               alignment: Alignment.center,
//                               child: Card(
//                                 child: FlatButton(onPressed: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (_) {
//                                             return AllMoreVideos(theDetail:"/ktn-news-category/videos/28/0/");
//                                           }));
//                                 },
//                                   child: Text("View All"),),
//                               ),
//                             ),
//
//                             SizedBox(
//                               height: 30,
//                             ),
//
//                           ],
//                         )
//                       ],
//                     ))
//               // }
//               // }
//               //         return Center(
//               //           child: CircularProgressIndicator(),
//               //         );
//               //       }),
//               // ),
//             ),
//           ),
//         ));
//   }
//
//
//
//
//   @override
//   // TODO: implement wantKeepAlive
//   bool get wantKeepAlive => true;
// }
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:ktn_news/API/API_Calls.dart';
import 'package:ktn_news/Screens/categories/ViewAll/allMoreVideos.dart';
import 'package:ktn_news/Screens/categories/liveStream/MostViewed.dart';
import 'package:ktn_news/Screens/categories/liveStream/moreVideos.dart';
import 'package:ktn_news/Screens/categories/liveStream/worldNews.dart';
import 'package:ktn_news/Video/MainVideo.dart';

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
import 'package:ktn_news/constants.dart';
import 'package:ktn_news/model/Category1.dart';
import 'package:http/http.dart' as http;
import 'package:ktn_news/Fonts/fonts.dart';
import 'package:ktn_news/model/video.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Video/YoutubePlayer.dart';
import 'KTN_morning.dart';
import 'LatestStories.dart';
import 'package:getwidget/getwidget.dart';


class LiveStreamPage extends StatefulWidget {
  static int? playingVideo;
  static String? liveThumb;
  static String? playingTitle;
  static var screenHeight;
  static var cHeight ;
  static String moreVideosDetail = "/videos/1/0/20";



  @override
  _LiveStreamPageState createState() => _LiveStreamPageState();
}

class _LiveStreamPageState extends State<LiveStreamPage>  with AutomaticKeepAliveClientMixin {
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
        LiveStreamPage.liveThumb = mainVideos[0]['thumbnail'];
        LiveStreamPage.playingTitle = mainVideos[0]['title'];
        // NewsPage.playingVideo = mainVideos[0]['id'];
        print(LiveStreamPage.playingVideo);
        print("hapo juu");
        print(LiveStreamPage.liveThumb);
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

    print(LiveStreamPage.playingVideo);
    if(!this.mounted){
      YoutubeVideo.controller!.pause();
      print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<inside the Live page");
    }
  }

  onScroll() {
    if (controller.position.atEdge) {
      if (controller.position.pixels == 0) {
        //if at the top
        print("at the top");
        if(this.mounted) {
          setState(() {
            LiveStreamPage.cHeight = LiveStreamPage.screenHeight * 0.35;
          });
        }
      }
      //else if at bottom
    } else {
      print("not at top");
      if(this.mounted){
        setState(() {
          LiveStreamPage.cHeight = LiveStreamPage.screenHeight * 0.2;
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
    LiveStreamPage.screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;

    LiveStreamPage.cHeight = LiveStreamPage.screenHeight*0.3;
    // NewsPage.playingVideo = mainVideos[0]['id'];
    return RefreshIndicator(
        onRefresh: () => APICalls.refreshLiveStream(context),
        child: Container(

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
                            IconButton(onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return WebViewContainer("https://www.youtube.com/embed/live_stream?channel=UCKVsdeoHExltrWMuK0hOWmg&rel=0&autoplay=1");
                                }),
                              );
                            }, icon: Icon(FontAwesomeIcons.briefcase)),
                            SizedBox(
                              height: 2,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15),
                                child: Text(
                                  "Enjoy News Update 24/7",
                                  style:
                                  CustomTextStyle.display0(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 2,
                            ),


                            // Align(
                            //   alignment: Alignment.center,
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(
                            //         left: 15, right: 15),
                            //     child: Row(
                            //       children: [
                            //         Text(
                            //           "Get the Whole ",
                            //           style:
                            //           CustomTextStyle.display00(context),
                            //         ), Text(
                            //           "Story",
                            //           style:
                            //           CustomTextStyle.display01(context),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: double.infinity,
                                child: Card(
                                  child: FlatButton(onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) {
                                              return AllMoreVideos(theDetail: "/ktn-news/videos/1/0/",theTitle: "Latest Stories",);
                                            }));
                                  },
                                    child: Text("Latest Stories"),),
                                ),
                              ),
                            ),
                       SizedBox(
                              height: 2,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: double.infinity,
                                child: Card(
                                  child: FlatButton(
                                    onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) {
                                              return AllMoreVideos(theDetail: "/ktn-news-category/videos/2/0/",theTitle: "KTN Leo",);
                                            }));
                                  },
                                    child: Text("KTN Leo"),
                                ),
                              ),
                            ),
                            ),
                       SizedBox(
                              height: 2,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: double.infinity,
                                child: Card(
                                  child: FlatButton(onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) {
                                              return AllMoreVideos(theDetail: "/ktn-news/videos/1/0/",theTitle: "KTN Sports");
                                            }));
                                  },
                                    child: Text("KTN Sports"),),
                                ),
                              ),
                            ),
                       SizedBox(
                              height: 2,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: double.infinity,
                                child: Card(
                                  child: FlatButton(onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) {
                                              return AllMoreVideos(theDetail:  "/ktn-news-popular/videos/newsvideos/0/",theTitle: "Most Popular Videos",);
                                            }));
                                  },
                                    child: Text("Most Popular Videos"),),
                                ),
                              ),
                            ),
                       SizedBox(
                              height: 2,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: double.infinity,
                                child: Card(
                                  child: FlatButton(onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) {
                                              return AllMoreVideos(theDetail: "/ktn-news-category/videos/28/0/",theTitle: "KTN Morning Express",);
                                            }));
                                  },
                                    child: Text("KTN Morning Express"),),
                                ),
                              ),
                            ),
                       SizedBox(
                              height: 2,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: double.infinity,
                                child: Card(
                                  child: FlatButton(onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) {
                                              return AllMoreVideos(theDetail:"/ktn-news/videos/22/0/",theTitle: "KTN Business",);
                                            }));
                                  },
                                    child: Text("KTN Business"),),
                                ),
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

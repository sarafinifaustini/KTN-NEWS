// import 'dart:convert';
// import 'package:ktn_news/Screens/LandingPage.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:ktn_news/API/API_Calls.dart';
// import 'package:ktn_news/API/APIs.dart';
// import 'package:ktn_news/Screens/LifeCycleManager.dart';
// import 'package:ktn_news/Screens/categories/liveStream/KTN_Business.dart';
// import 'package:ktn_news/Screens/categories/liveStream/KTN_Sports.dart';
// import 'package:ktn_news/Screens/categories/liveStream/KTN_morning.dart';
// import 'package:ktn_news/Screens/categories/liveStream/ktn_leo.dart';
// import 'package:ktn_news/Video/WebView.dart';
// import 'package:ktn_news/model/Category1.dart';
// import 'package:http/http.dart' as http;
// import 'package:ktn_news/Fonts/fonts.dart';
// import 'package:ktn_news/model/video.dart';
//
// import '../constants.dart';
//
// class VideoPlaying extends StatefulWidget {
//   final int? videoId;
//   static int? playingVideo;
//   static String? liveThumb;
//   static String? playingTitle;
//
//   const VideoPlaying({Key? key, this.videoId}) : super(key: key);
//
//   @override
//   _VideoPlayingState createState() => _VideoPlayingState();
// }
//
// class _VideoPlayingState extends State<VideoPlaying> with WidgetsBindingObserver {
//   final controller = ScrollController();
//   double cWidth = 0.0;
//   double itemHeight = 28.0;
//   double? screenWidth;
//   var screenHeight;
//   double screenShrink = 4.0;
//   var cHeight;
//   Video? video;
//   WebViewController? _controller;
//   final _key = UniqueKey();
//   bool isScreenVisible = true;
//   List mainVideos = [];
//
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
//         VideoPlaying.liveThumb = mainVideos[0]['thumbnail'];
//         VideoPlaying.playingTitle = mainVideos[0]['title'];
//         VideoPlaying.playingVideo = mainVideos[0]['id'];
//         print(VideoPlaying.playingVideo);
//         print("hapo juu");
//         print(VideoPlaying.liveThumb);
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
//     controller.addListener((onScroll));
//     APICalls.refreshLiveStream(context);
//     WidgetsBinding.instance!.addObserver(this);
//     getVideos();
//   }
//
//   onScroll() {
//     if (controller.position.atEdge) {
//       if (controller.position.pixels == 0) {
//         //if at the top
//         print("at the top");
//         setState(() {
//           cHeight = screenHeight * 0.4;
//         });
//       }
//       //else if at bottom
//     } else {
//       print("not at top");
//       setState(() {
//         cHeight = screenHeight * 0.2;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     controller.removeListener(onScroll);
//     WidgetsBinding.instance!.removeObserver(this);
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       setState(() {
//         isScreenVisible = true;
//       });
//       _controller?.reload();
//     } else {
//       setState(() {
//         isScreenVisible = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     screenHeight = MediaQuery.of(context).size.height;
//     Size size = MediaQuery.of(context).size;
//
//     return LifeCycleManager(
//         child: FutureBuilder<Video>(
//             future: APICalls.getVideo(VideoPlaying.playingVideo!),
//             builder: (context,snapshot) {
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Text("Ooops! Something went wrong."),
//                 );
//               }
//               if (snapshot.hasData) {
//                 video = snapshot.data;
//                 return Container(
//                   decoration: BoxDecoration(
//                       gradient: LinearGradient(colors: [
//                         Colors.black.withOpacity(1),
//                         Colors.black.withOpacity(0.0),
//                       ], end: Alignment.topCenter, begin: Alignment
//                           .bottomCenter)),
//                   child: Column(
//                     children: [
//                       isScreenVisible
//                           ? AnimatedContainer(
//                           duration: Duration(milliseconds: 0),
//                           curve: Curves.bounceInOut,
//                           color: Colors.transparent,
//                           height: cHeight,
//                           width: double.infinity,
//                           child: Container(
//                             height: screenHeight * 0.4,
//                             child: AspectRatio(
//                               aspectRatio: 1,
//                               child: WebView(
//                                 key: _key,
//                                 javascriptMode: JavascriptMode
//                                     .unrestricted,
//                                 initialUrl:video!.videoURL,
//                                 onWebViewCreated: (controller) =>
//                                 _controller = controller,
//                               ),
//                             ),
//                           ))
//                           : Text("Not found"),
//                       AnimatedContainer(
//                         duration: Duration(milliseconds: 0),
//                         curve: Curves.bounceInOut,
//                         color: Colors.transparent,
//                         height: 60,
//                         width: double.infinity,
//                         child: Column(
//                           children: [
//                             Align(
//                                 alignment: Alignment.bottomLeft,
//                                 child: Text(
//                                   "NOW PLAYING",
//                                   style: CustomTextStyle.display3(
//                                       context),
//                                 )),
//                             Flexible(
//                               child: Text(
//                                 video!.title!,
//                                 style: CustomTextStyle.display4(context),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//               return Center(
//                 child: CircularProgressIndicator(
//                   backgroundColor: Theme.of(context).backgroundColor,
//                 ),
//               );
//             }
//
//         )
//
//
//       // WebViewContainer("https://www.youtube.com/embed/live_stream?channel=UCKVsdeoHExltrWMuK0hOWmg&rel=0&autoplay=1"))
//     );
//   }
//
//   Widget latestStories() {
//     Size size = MediaQuery.of(context).size;
//     Videos videos;
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: GestureDetector(
//         onTap: () {
//           print("tapped");
//           // Navigator.push(
//           //     context,
//           //     MaterialPageRoute(
//           //         builder: (_) => VideoDetailPage(
//           //             videoUrl:
//           //             "assets/videos/video_1.mp4")));
//         },
//         child: Padding(
//           padding: EdgeInsets.only(left: 10),
//           child: Row(
//             children: List.generate(10, (index) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(right: 8),
//                       width: 160,
//                       height: 160,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(6),
//                           image: DecorationImage(
//                               image: AssetImage("assets/images/logo.png"),
//                               fit: BoxFit.cover)),
//                     ),
//                     Text("videos[0].title"),
//                   ],
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:ktn_news/API/API_Calls.dart';
// import 'package:ktn_news/API/APIs.dart';
// import 'package:ktn_news/Screens/categories/liveStream/KTN_Business.dart';
// import 'package:ktn_news/Screens/categories/liveStream/KTN_Sports.dart';
// import 'package:ktn_news/Screens/categories/liveStream/KTN_morning.dart';
// import 'package:ktn_news/Screens/categories/liveStream/ktn_leo.dart';
// import 'package:ktn_news/Video/WebView.dart';
// import 'package:ktn_news/Video/YoutubePlayer.dart';
// import 'package:ktn_news/model/Category1.dart';
// import 'package:http/http.dart' as http;
// import 'package:ktn_news/Fonts/fonts.dart';
// import 'package:ktn_news/model/video.dart';
//
// import '../../../constants.dart';
// import '../../LifeCycleManager.dart';
//
// class LiveStreamPage extends StatefulWidget {
//   static String? playingVideo;
//   static String? liveThumb;
//
//   @override
//   _LiveStreamPageState createState() => _LiveStreamPageState();
// }
//
// class _LiveStreamPageState extends State<LiveStreamPage> {
//
//   void initState() {
//     super.initState();
//     APICalls.refreshLiveStream(context);
//     getVideos();
//   }
// List mainVideos =[];
//   Future<List<Videos>> getVideos() async {
//     try {
//       final response = await http.get(Uri.parse(news),
//           headers: <String, String>{
//             "Accept": "application/json",
//             "Content-Type": "application/json"
//           });
//       if (response.statusCode == 200) {
//         List jsonResponse = json.decode(response.body)['videos'];
//         mainVideos =jsonResponse;
//         LiveStreamPage.liveThumb = mainVideos[0][' thumbnail'];
//         // print(jsonResponse);
//         return jsonResponse.map((data) => new Videos.fromJson(data)).toList();
//       } else {
//         throw Exception('Unexpected error occurred !');
//       }
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     Size size = MediaQuery.of(context).size;
//     return RefreshIndicator(
//       onRefresh: () => APICalls.refreshLiveStream(context),
//       child: SafeArea(
//         bottom: false,
//         child: Padding(
//           padding: const EdgeInsets.all(0.0),
//           child: Column(
//             children: [
//               LifeCycleManager(
//                 child:YoutubeVideo(youTubeUrl: "RFWyGLw0N5k",)
//                 // WebViewContainer("https://www.youtube.com/embed/live_stream?channel=UCKVsdeoHExltrWMuK0hOWmg&rel=0&autoplay=1")
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:ktn_news/API/API_Calls.dart';
import 'package:ktn_news/Fonts/fonts.dart';
import 'package:ktn_news/Screens/categories/ViewAll/allMoreVideos.dart';
import 'package:ktn_news/Screens/categories/liveStream/MostViewed.dart';
import 'package:ktn_news/Screens/categories/liveStream/ktn_leo.dart';
import 'package:ktn_news/Screens/categories/liveStream/worldNews.dart';
import 'package:ktn_news/model/Category1.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../Video/YoutubePlayer.dart';
import '../../../constants.dart';
import '../../LandingPage.dart';
import 'KTN_Business.dart';
import 'moreVideos.dart';
import 'package:shimmer/shimmer.dart';
/// Homepage
class LiveStreamPage extends StatefulWidget {

  static String? youTubeTitle;
  static String? ID;


  const LiveStreamPage({Key? key,}) : super(key: key);


  @override
  _LiveStreamPageState createState() => _LiveStreamPageState();
}

class _LiveStreamPageState extends State<LiveStreamPage> {

  late TextEditingController _idController;
  late TextEditingController _seekToController;
 YoutubePlayerController? _controller;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  String? videoID = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=i5jboIWfGMA");


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
    print(videoID);
    LandingPage.videoID = videoID!;
    print("---------------------------------------------");
    print(videoID);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
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
        LiveStreamPage.youTubeTitle=_controller!.metadata.title;
        _playerState =_controller!.value.playerState;
        _videoMetaData =_controller!.metadata;
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

  @override
  Widget build(BuildContext context) {
    // videoID = YoutubePlayer.convertUrlToId(widget.youTubeUrl!);
    print("---------------------------------------------");
    print(videoID);
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        liveUIColor: myRed,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child:  AnimatedContainer(
              duration: Duration(milliseconds: 0),
              curve: Curves.bounceInOut,
              color: Colors.transparent,
              height: 60,
              width: double.infinity,
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        children: [

                        ],
                      )),

                ],
              ),
            ),
            //

          ),
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
        return  Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                  fit: BoxFit.fill,
                  child: player),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 0),
                  curve: Curves.bounceInOut,
                  color: Colors.black,
                  height: 60,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Flexible(
                        child: Text(
                        "KTN News Live stream",
                          style: CustomTextStyle.display4(context),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),

                      )
                    ],
                  ),
                ),

              ],
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: FutureBuilder<List<Videos>>(
                    future: APICalls.getVideos("/videos/23/0/20"),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Oops! Something went wrong'),
                        );
                      }
                      if (snapshot.hasData) {
                        List<Videos>? data = snapshot.data;
                        return SingleChildScrollView(
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
                                    MoreVideosPage(theDetail: "/videos/23/0/20",),
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

            // AnimatedContainer(
            //   duration: Duration(milliseconds: 0),
            //   curve: Curves.bounceInOut,
            //   color: Colors.black,
            //   height: 60,
            //   width: double.infinity,
            //   child: Text(
            //     _controller!.metadata.title,
            //     style: CustomTextStyle.display4(context),
            //     overflow: TextOverflow.ellipsis,
            //     maxLines: 2,
            //   ),
            // ),
          ],
        );
      },
    );
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700]!;
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900]!;
      default:
        return Colors.blue;
    }
  }

  Widget get _space => const SizedBox(height: 10);

  Widget _loadCueButton(String action) {
    return Expanded(
      child: MaterialButton(
        color: Colors.blueAccent,
        onPressed: _isPlayerReady
            ? () {
          if (_idController.text.isNotEmpty) {
            var id = YoutubePlayer.convertUrlToId(
              _idController.text,
            ) ??
                '';
            if (action == 'LOAD')_controller!.load(id);
            if (action == 'CUE') _controller!.cue(id);
            FocusScope.of(context).requestFocus(FocusNode());
          } else {
            _showSnackBar('Source can\'t be empty!');
          }
        }
            : null,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            action,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
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

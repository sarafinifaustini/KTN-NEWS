import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:ktn_news/API/API_Calls.dart';
import 'package:ktn_news/Fonts/fonts.dart';
import 'package:ktn_news/Screens/LandingPage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Screens/categories/ViewAll/allMoreVideos.dart';
import '../Screens/categories/liveStream/KTN_Business.dart';
import '../Screens/categories/liveStream/MostViewed.dart';
import '../Screens/categories/liveStream/ktn_leo.dart';
import '../Screens/categories/liveStream/moreVideos.dart';
import '../Screens/categories/liveStream/worldNews.dart';
import '../model/Category1.dart';
/// Homepage
class FeaturesVideo extends StatefulWidget {
  final Widget? child;
  final String? youTubeUrl;
  static String? youTubeTitle;
  static String? theLiveStreamVideoId;
  static String? ID;
  static YoutubePlayerController? controller;

  const FeaturesVideo({Key? key, this.youTubeUrl, this.child,}) : super(key: key);


  @override
  _FeaturesVideoState createState() => _FeaturesVideoState();
}

class _FeaturesVideoState extends State<FeaturesVideo> {

  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  var theId;
  bool _isPlayerReady = false;
  var theLiveStreamVideoId = APICalls.getVideoId();
  String videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/embed/live_stream?channel=UCKVsdeoHExltrWMuK0hOWmg")!;

  final List<String> _ids = [
    'a8aOmAlRdnE',
    'a8aOmAlRdnE',
  ];

  @override
  void initState() {
    super.initState();
    print("inside the youtube video whatever-------------------");
    // YoutubeVideo.controller!.pause();
    print(FeaturesVideo.theLiveStreamVideoId);
    if(FeaturesVideo.theLiveStreamVideoId != null){
      theId = FeaturesVideo.theLiveStreamVideoId;
      print("first >>>>>>>>>>>>>>>>>>>>>>>");
      print(theId);
    }
    else if(theId != FeaturesVideo.theLiveStreamVideoId){
      theId = FeaturesVideo.theLiveStreamVideoId;
      print("second >>>>>>>>>>>>>>>>>>>>>>>");
      print(FeaturesVideo.theLiveStreamVideoId);
      print("second2 >>>>>>>>>>>>>>>>>>>>>>>");
      print(theId);
    }

    if(FeaturesVideo.theLiveStreamVideoId == null){
      print("video Id Is null?????????????????????????????????????????????????");
      FeaturesVideo.controller = YoutubePlayerController(
        initialVideoId: "5useqU-NK50",
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: true,
          enableCaption: true,
        ),
      )..addListener(listener);
    }
    else {
      print("video Id is not null");
      FeaturesVideo.controller = YoutubePlayerController(
        initialVideoId: FeaturesVideo.theLiveStreamVideoId!,
        // initialVideoId: "a8aOmAlRdnE",
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: true,
          enableCaption: true,
        ),
      )
        ..addListener(listener);
    }
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !FeaturesVideo.controller!.value.isFullScreen) {
      setState(() {
        FeaturesVideo.youTubeTitle=FeaturesVideo.controller!.metadata.title;
        _playerState =FeaturesVideo.controller!.value.playerState;
        _videoMetaData =FeaturesVideo.controller!.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    FeaturesVideo.controller!.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    FeaturesVideo.controller!.pause();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // LandingPage.videoID = YoutubePlayer.convertUrlToId(widget.youTubeUrl!)!;
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: FeaturesVideo.controller!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          FeaturesVideo.controller!
              .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
          // _showSnackBar('Next Video Started!');
        },
      ),
      builder: (context, player) {
        return  SafeArea(
          child: Column(
            children: [
              player,
              AnimatedContainer(
                duration: Duration(milliseconds: 0),
                curve: Curves.bounceInOut,
                color: Colors.grey[900],
                height: 60,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0,right: 8.0),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            children: [
                              Text(
                                "NOW PLAYING",
                                style: CustomTextStyle.display3(
                                    context),
                              ),
                            ],
                          )),
                      Flexible(
                        child: Text(
                          FeaturesVideo.controller!.metadata.title,
                          style: CustomTextStyle.display4(context),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),

                      )
                    ],
                  ),
                ),
              ),
              widget.child!,
            ],
          ),
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
            if (action == 'LOAD')FeaturesVideo.controller!.load(id);
            if (action == 'CUE') FeaturesVideo.controller!.cue(id);
            FocusScope.of(context).requestFocus(FocusNode());
          } else {
            // _showSnackBar('Source can\'t be empty!');
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

}
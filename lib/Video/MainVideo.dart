import 'package:flutter/material.dart';
import 'package:ktn_news/API/API_Calls.dart';
import 'package:ktn_news/Fonts/fonts.dart';
import 'package:ktn_news/Screens/LifeCycleManager.dart';
import 'package:ktn_news/Screens/categories/News/News.dart';
import 'package:ktn_news/Screens/categories/ViewAll/allMoreVideos.dart';
import 'package:ktn_news/Video/WebView.dart';
import 'package:ktn_news/model/video.dart';

import 'MainWebView.dart';


class MainVideo extends StatelessWidget with  WidgetsBindingObserver {

  MainVideo({String? title});

  Video? video;
  int currentIndex=0;
   String title ="hen";


  static String calculateTimeDifferenceBetween(
      {@required DateTime? publishdate, @required DateTime? endDate}) {
    int seconds = endDate!.difference(publishdate!).inSeconds;
    if (seconds < 60)
      return '$seconds seconds ago';
    else if (seconds >= 60 && seconds < 3600)
      return '${publishdate.difference(endDate).inMinutes.abs()} minutes ago';
    else if (seconds >= 3600 && seconds < 86400)
      return '${publishdate.difference(endDate).inHours} hours ago';
    else
      return '${publishdate.difference(endDate).inDays} days ago';
  }



  @override
  Widget build(BuildContext context) {
    return LifeCycleManager(
      child:SafeArea(

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(

                    child: FutureBuilder<Video>(
                        future: APICalls.getVideo(NewsPage.playingVideo!),
                        // ignore: missing_return
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Ooops! Something went wrong."),
                            );
                          }
                          if (snapshot.hasData) {
                            video = snapshot.data;

                            return  MainWebViewContainer(
                                video!.videoURL!);


                          }
                          return Container() ;
                        }

                    )

                ),
                // Text(AllMoreVideos.theTitle),

              ],
            ),
          )),


    );
  }
}

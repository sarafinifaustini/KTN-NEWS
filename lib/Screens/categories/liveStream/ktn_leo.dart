import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ktn_news/API/API_Calls.dart';
import 'package:ktn_news/API/APIs.dart';
import 'package:ktn_news/Video/YoutubePlayer.dart';
import 'file:///C:/Users/jsarafini/AndroidStudioProjects/ktn_news/lib/Screens/categories/News/News.dart';
import 'package:ktn_news/model/Category1.dart';
import 'package:http/http.dart' as http;
import 'package:ktn_news/Fonts/fonts.dart';
import 'package:ktn_news/model/video.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants.dart';
import '../../LandingPage.dart';

class KTNLeoPage extends StatefulWidget {
  @override
  _KTNLeoPageState createState() => _KTNLeoPageState();
}


class _KTNLeoPageState extends State<KTNLeoPage> {

  void initState() {
    super.initState();
    APICalls.refreshLiveStream(context);
  }

  refreshAction(theVideoId) {
    setState(() async {
      // APICalls.getVideo(NewsPage.playingVideo!);
      print("here");
      String videoURL = "https://www.standardmedia.co.ke/farmkenya/api/ktn-home/video/$theVideoId";
      try {
        var result = await http.get(Uri.parse(videoURL));
        if (result.statusCode == 200) {
          Map<String,dynamic> data = jsonDecode(result.body)['video'];
          Video video = Video.fromJson(data);
          YoutubeVideo.controller!.load("${data['videoURL']}");

        } else {
          print("problem in refresh Action");
          throw Exception('Could not connect.');
        }
      } catch (e) {
        throw e;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<List<Videos>>(
        future: APICalls.getKtnLeo(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {

            return SizedBox(
              // width: double.infinity,
              height: size.height * 0.3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
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
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
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
                  margin: EdgeInsets.symmetric(
                      vertical: kDefaultPadding / 2),
                  height: size.height * 0.3,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data!.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        GestureDetector(
                          onTap: () {
                            print("tapped");
                            setState(() {
                              print(NewsPage.playingTitle);
                              NewsPage.playingTitle ="";
                              NewsPage.playingTitle =
                                  data[index].title;
                              NewsPage.playingVideo = null;
                              NewsPage.playingVideo= data[index].id;
                              refreshAction(NewsPage.playingVideo);

                            });


                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) {
                            //           return LandingPage();
                            //         }));
                          },
                          child: Card(

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                ),
              ],
            );
          }
          return Center();
          // child: CircularProgressIndicator(),
          // );
        });
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
}

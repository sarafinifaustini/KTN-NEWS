import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ktn_news/API/API_Calls.dart';
import 'package:ktn_news/Fonts/fonts.dart';
import 'package:ktn_news/Screens/categories/News/News.dart';
import 'package:ktn_news/Video/YoutubePlayer.dart';
import 'package:ktn_news/model/Category1.dart';
import 'package:ktn_news/model/video.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';


class AllMoreVideos extends StatefulWidget {
  final String theTitle;
  final String theDetail;
  static int? playingVideo;
  const AllMoreVideos({Key? key, required this.theDetail, required this.theTitle}) : super(key: key);

  @override
  _AllMoreVideosState createState() => _AllMoreVideosState();
}

class _AllMoreVideosState extends State<AllMoreVideos> {
  Video? video;


  refreshAction(theVideoId) {
    setState(() async {
      // APICalls.getVideo(NewsPage.playingVideo!);
      print("here");
      String videoURL =
          "https://www.standardmedia.co.ke/farmkenya/api/ktn-home/video/$theVideoId";
      try {
        var result = await http.get(Uri.parse(videoURL));
        if (result.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(result.body)['video'];

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
    print(widget.theDetail);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<List<Videos>>(
          future: APICalls.getVideos(widget.theDetail + "100"),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return SizedBox(
                // width: double.infinity,
                height: size.height ,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(

                      child: Column(
                        children: [
                          FittedBox(
                            child: dummyShimmer(),
                          ),
                          Container(
                            height:size.height*0.7 ,
                            child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 20),
                                itemCount: 8,
                                itemBuilder: (BuildContext ctx, index) {
                                  return dummyShimmer();
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if (!snapshot.hasData) {
            return SizedBox(
                // width: double.infinity,
                height: size.height ,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(

                      child: Column(
                        children: [
                          FittedBox(
                            child: dummyShimmer(),
                          ),
                          Container(
                            height:size.height*0.7 ,
                            child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 20),
                                itemCount: 8,
                                itemBuilder: (BuildContext ctx, index) {
                                  return dummyShimmer();
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              List<Videos>? data = snapshot.data;
              return YoutubeVideo(
                child: Expanded(
                  child: DefaultTabController(
                    length: 1,
                    child: NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return [
                          SliverOverlapAbsorber(
                              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                                      context),
                              sliver: SliverSafeArea(
                                  top: false,
                                  sliver: SliverAppBar(
                                      ///Properties of app bar
                                       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                      floating: true,
                                      pinned: true,
                                      // expandedHeight: 200.0,
                                      // title: Text("More Videos"),
                                      bottom: TabBar(
                                          indicatorColor:
                                              Theme.of(context).backgroundColor,
                                          tabs: [
                                            Tab(
                                              text: widget.theTitle,
                                            ),
                                            // Tab(text: "Popular Shows")
                                          ])))),
                        ];
                      },
                      body: CustomScrollView(slivers: [
                        SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            mainAxisExtent: 150.0,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return  GestureDetector(
                                onTap: () {
                                  print("tapped");
                                  setState(() {
                                    print(NewsPage.playingTitle);
                                    NewsPage.playingTitle ="";
                                    NewsPage.playingTitle =
                                        data![index].title;
                                    NewsPage.playingVideo = null;
                                    NewsPage.playingVideo= data[index].id;
                                    refreshAction(NewsPage.playingVideo);

                                  });
                                },
                                child: FittedBox(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        // height: size.height*0.25,
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
                                                data![index].thumbnail!,
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
                                                     style: TextStyle(fontSize: 18),
                                                     overflow: TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: data!.length,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              );
            }
            return Text("");
          }),
    );
  }

  Widget dummyShimmer() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: size.width * 0.7,
                height: 8.0,
                color: Colors.white,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
            ),
            Align(
              alignment: Alignment.bottomLeft,
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
              alignment: Alignment.bottomLeft,
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
